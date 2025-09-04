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
    @Binding var largestText: String?
    @StateObject private var editViewModel = EditViewModel()
    @StateObject private var addCouponModel = AddCouponModel()
    @State private var limitDate: String?
    @State private var companyName: String?
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .fill(Color(red: 242/255, green: 242/255, blue: 247/255))
                
                ScrollView{
                    
                    VStack(spacing:5){
                        HStack{
                            Text("会社名")
                            Spacer()
                        }
                        TextField("会社名",text:$addCouponModel.companyName)
                            .textFieldStyle(.plain)                // 縁なし
                            .padding(.horizontal)                  // 内側の余白
                            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)            // 幅いっぱい
                            .background(Color.white)
                    }
                    .padding(10)
                    VStack(spacing:5){
                        HStack{
                            Text("クーポン名")
                            Spacer()
                        }
                        TextField("クーポン名",text:$addCouponModel.couponName)
                            .textFieldStyle(.plain)                // 縁なし
                            .padding(.horizontal)                  // 内側の余白
                            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)            // 幅いっぱい
                            .background(Color.white)
                    }
                    .padding(10)
                    VStack(spacing:5){
                        HStack{
                            Text("クーポン名")
                            Spacer()
                        }
                        TextEditor(text: $addCouponModel.notes)
                            .textFieldStyle(.plain)                // 縁なし
                            .padding(.horizontal)                  // 内側の余白
                            .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)            // 幅いっぱい
                            .background(Color.white)
                    }
                    .padding(10)
                }
                .navigationTitle("編集")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear(){
                limitDate = editViewModel.extractDateRange(from: recognizedText)
                companyName = editViewModel.extractCompany(from: recognizedText)
                addCouponModel.setStart(limit:limitDate,
                                        companyName:companyName,
                                        couponName:largestText,
                                        selectedImage:selectedImage
                )
            }
        }
    }
}

struct DarkPictureView: View{
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.black)
                .frame(maxWidth:.infinity)
                .frame(height: 100)
                .opacity(0.3)
            
            Image(systemName: "photo.artframe.circle.fill")
                .frame(width:100,height:100)
            
        }
    }
}
