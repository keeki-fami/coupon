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
    @State private var recognizedText: String = ""
    @State private var selectedImage: UIImage?
    
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
                ImagePicker(image: $selectedImage, onImagePicked: { image in
                    print("recognizeTextを呼び出しました")
                    recognizeText(from: image)
                })
            }
        }
    }
}
