//
//  AddCouponCard.swift
//  coupon
//
//  クーポン追加画面のView
//

import SwiftUI
import Vision
import VisionKit

struct AddCouponCard: View {
    @State private var isPickerPresented = false
    @State private var isImageCropper = false
    @State private var recognizedText: String = ""
    @State private var largestText: String? = ""
    @State private var selectedImage: UIImage?
    @EnvironmentObject var isEditView: IsEditView
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Button(action: {
                    isPickerPresented = true
                    print("写真を撮るをおしました")
                },label: {
                    ZStack {
                        Rectangle()
                            .fill(Color(red: 242/255, green: 242/255, blue: 247/255))
                            .frame(maxWidth:.infinity, minHeight:200,maxHeight:200)
                        Image(systemName: "camera")
                    }
                })
                Spacer()
                Button("追加の仕方") {
                    
                }
                Spacer()
            }
            .navigationTitle("クーポンを追加する")
            .sheet(isPresented: $isPickerPresented) {
                ImagePicker(image: $selectedImage, done: toggleImageCropper)
                    .onAppear(){
                        // recognizedtextの初期化
                        recognizedText = ""
                    }
            }
            .sheet(isPresented:$isImageCropper) {
                ImageCropper(image: $selectedImage, visible: $isImageCropper, done: creppedImage, onImagePicked: { image in
                    Task{
                        
                        isLoading = true
                        await recognizeText(
                            from: image,
                            recognizedText: $recognizedText,
                            largestText: $largestText
                        )
                        await displayEditView(isLoading: $isLoading)
                        
                    }
                })
            }
            .sheet(isPresented: $isEditView.isEdit) {
                EditView(recognizedText: $recognizedText,
                         selectedImage: $selectedImage,
                         largestText: $largestText)
                    .onAppear(){
                        print("呼び出します")
                    }
            }
            .overlay(){
                if isLoading {
                    ProgressView()
                }
            }
            // 今度追加予定
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing){
//                    NavigationLink(destination: BellView()) {
//                        Image(systemName: "bell")
//                    }
//                }
//            }
        }
    }
    
    func displayEditView(isLoading: Binding<Bool>) async {
        await isLoading.wrappedValue = false
        await isEditView.isEdit = true
    }
    
    func creppedImage(image: UIImage) {
        selectedImage = image
    }
    func toggleImageCropper() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation{
                isImageCropper = true
            }
        }
        isImageCropper = true
    }
}
