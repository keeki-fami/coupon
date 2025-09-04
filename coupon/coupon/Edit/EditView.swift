//
//  EditView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/01.
//

import SwiftUI

struct EditView: View {
    let recognizedText: String
    @Binding var selectedImage: UIImage?
    @Binding var largestText: String
    @StateObject private var editViewModel = EditViewModel()
    @State private var limitDate: String?
    @State private var companyName: String?
    var body: some View {
        VStack{
            if let selectedimage = selectedImage {
                Image(uiImage: selectedimage)
                    .resizable()
                    .scaledToFit()
                    .frame(height:200)
            }
            Text("EditViewです。")
            Text("期限：\(limitDate)")
            Text("会社：\(companyName)")
            Text("タイトル予想：\(largestText)")
        }
        .onAppear(){
            limitDate = editViewModel.extractDateRange(from: recognizedText)
            companyName = editViewModel.extractCompany(from: recognizedText)
        }
    }
}
