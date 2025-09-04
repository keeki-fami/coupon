//
//  AddCouponCard.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/08/30.
//

import SwiftUI
import Vision
import VisionKit

struct AddCouponCard: View {
    @State private var isPickerPresented = false
    @State private var isImageCropper = false
    @State private var recognizedText: String = ""
    @State private var largestText: String = ""
    @State private var selectedImage: UIImage?
    @EnvironmentObject var isEditView: IsEditView
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height:200)
                }
                
                TextEditor(text: $recognizedText)
                    .frame(height: 200)
                    .border(Color.gray)
                
                Button("写真を撮る") {
                    isPickerPresented = true
                    print("写真を撮るをおしました")
                }
                .padding()
            }
            .navigationTitle("クーポンを追加する")
            .sheet(isPresented: $isPickerPresented) {
                ImagePicker(image: $selectedImage)
                    .onDisappear(){
                        isImageCropper = true
                    }
            }
            .sheet(isPresented:$isImageCropper) {
                ImageCropper(image: $selectedImage, visible: $isImageCropper, done: creppedImage, onImagePicked: { image in
                    recognizeText(
                        from: image,
                        recognizedText: $recognizedText,
                        largestText: $largestText
                    )
                })
                .onDisappear(){
                    isEditView.isEdit = true
                }
            }
            .sheet(isPresented: $isEditView.isEdit) {
                EditView(recognizedText: recognizedText,
                         selectedImage: $selectedImage,
                         largestText: $largestText)
                    .onAppear(){
                        print("呼び出します")
                    }
            }
        }
    }
    
    func creppedImage(image: UIImage) {
        selectedImage = image
    }
}
