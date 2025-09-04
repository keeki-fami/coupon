//
//  CardView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/08/31.
//

import SwiftUI

struct CardView: View {
    var body: some View{
        Button(action: {
            // Todo:ModalViewに遷移
            print("ボタンが押されました")
        }, label: {
            cardView
                .frame(width:300,height:200)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 2)
                )
        })
        .contentShape(RoundedRectangle(cornerRadius: 5))
    }
}


var cardView: some View{
    ZStack{
        HStack() {
            Image("myFace")
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
            Spacer()
            VStack(alignment:.leading, spacing:10) {
                Spacer()
                Text("タイトル")
                    .font(.system(size :20))
                    .foregroundColor(.black)
                Spacer()
                VStack{
                    HStack{
                        Image(systemName:"clock.fill")
                        Text("2025/9/15")
                            .foregroundColor(.gray)
                            .font(.system(size :13))
                        Spacer()
                    }
                    HStack{
                        Image(systemName:"mappin.circle.fill")
                        Text("セブンイレブン")
                            .foregroundColor(.gray)
                            .font(.system(size :13))
                        Spacer()
                    }
                    HStack{
                        Image(systemName:"globe")
                        Text("サンプル１")
                            .foregroundColor(.gray)
                            .font(.system(size :13))
                        Spacer()
                    }
                }
                Spacer()
            }
            Spacer()
        }
    }
}


#Preview{
    CardView()
}
