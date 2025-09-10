//
//  CardView.swift
//  coupon
//
//  カードのView
//

import SwiftUI

struct CardView: View {
    let companyName:String?
    let couponName:String?
    let limit:Date?
    let notes:String?
    let selectedImage:Data?
    
    var body: some View{
        Button(action: {
            // Todo:ModalViewに遷移
            print("ボタンが押されました")
        }, label: {
            cardView(
                selectedImage: selectedImage,
                couponName: couponName,
                companyName: companyName,
                limit: limit)
                .frame(width:300,height:200)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 2)
                )
        })
        .contentShape(RoundedRectangle(cornerRadius: 5))
        .onAppear(){
            
        }
    }
}


struct cardView: View{
    let selectedImage:Data?
    let couponName:String?
    let companyName: String?
    let limit: Date?
    var body: some View{
        ZStack{
            HStack() {
                if let imageData = selectedImage,
                   let image = UIImage(data: imageData){
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width:150, height:200)
                        .mask(alignment: .top) {
                            LinearGradient(
                                gradient: .init(colors: [.white, .clear]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        }
                } else {
                    Image("defaultImage")
                        .scaledToFill()
                        .frame(width:150, height:200)
                        .mask(alignment: .top) {
                            LinearGradient(
                                gradient: .init(colors: [.white, .clear]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        }
                    
                }
                Spacer()
                VStack(alignment:.leading, spacing:10) {
                    Spacer()
                    if let couponname = couponName {
                        Text(couponname)
                            .font(.system(size :20))
                            .foregroundColor(.black)
                    } else {
                        Text("NULL")
                            .font(.system(size :20))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    VStack{
                        HStack{
                            if let limitExact = limit,
                               let date = dateToString(date: limitExact) {
                                Image(systemName:"clock")
                                Text(date)
                                    .foregroundColor(.gray)
                                    .font(.system(size :13))
                                Spacer()
                            }
                        }
                        HStack{
                            if let companyname = companyName {
                                if companyname != ""{
                                    Image(systemName:"mappin.circle")
                                    Text(companyname)
                                        .foregroundColor(.gray)
                                        .font(.system(size :13))
                                    Spacer()
                                }
                            }
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}


#Preview{
    // CardView()
}
