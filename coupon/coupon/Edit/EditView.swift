//
//  EditView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/01.
//

import SwiftUI

struct EditView: View {
    let recognizedText: String
    @State private var limitDate: String?
    @State private var companyName: String?
    var body: some View {
        VStack{
            Text("EditViewです。")
            Text("期限：\(limitDate)")
            Text("会社：\(companyName)")
        }
        .onAppear(){
            limitDate = extractDateRange(from: recognizedText)
            companyName = extractCompany(from: recognizedText)
        }
    }
}
