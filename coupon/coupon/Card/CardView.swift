//
//  CardView.swift
//  coupon
//
//  カードのView
//

import SwiftUI

struct CardView: View {
    @State private var isCardInfo = false
    @State private var cornerColor = Color.gray
    @State private var cornerLineWidth:CGFloat = 2
    let companyName:String?
    let couponName:String?
    let limit:Date?
    let notes:String?
    let selectedImage:Data?
    let deleteCard: () -> Void
    
    
    var body: some View{
        
        Button(action: {
            print("ボタンが押されました")
        }, label: {
            cardView(
                selectedImage: selectedImage,
                couponName: couponName,
                companyName: companyName,
                limit: limit,
                deleteCard: deleteCard,
                cornerColor: cornerColor)
                .frame(width:300,height:200)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(cornerColor, lineWidth: cornerLineWidth)
                )
        })
        .contentShape(RoundedRectangle(cornerRadius: 5))
        .onAppear() {
            if let cardLimit = limit {
                let calendar = Calendar.current
                let date = calendar.startOfDay(for: Date())
                
                if abs(cardLimit.timeIntervalSince(date)) <= 60*60*24 {
                    cornerColor = .yellow
                    cornerLineWidth = 5
                }
                if cardLimit.timeIntervalSince(date) < 0 {
                    cornerColor = .red
                    cornerLineWidth = 5
                }
                print("\(couponName):\(cardLimit.timeIntervalSince(Date()))")
            }
        }
        

    }
}


struct cardView: View{
    let selectedImage:Data?
    let couponName:String?
    let companyName: String?
    let limit: Date?
    let deleteCard: () -> Void
    let cornerColor: Color
    @State private var isAlert = false
    @State private var isWarning = false
    @State private var isX = false
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
                            .foregroundColor(Color("TextColor"))
                            .font(.system(size :20))
                    } else {
                        Text("NULL")
                            .foregroundColor(Color("TextColor"))
                            .font(.system(size :20))
                    }
                    Spacer()
                    VStack{
                        HStack{
                            if let limitExact = limit,
                               let date = dateToString(date: limitExact) {
                                Image(systemName:"clock")
                                    .foregroundColor(.gray)
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
                                        .foregroundColor(.gray)
                                    Text(companyname)
                                        .foregroundColor(.gray)
                                        .font(.system(size :13))
                                    Spacer()
                                }
                            }
                        }
                        HStack{
                            Spacer()
                            if (cornerColor == Color.yellow) {
                                Button(action: {
                                    isWarning = true
                                }, label: {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.yellow)
                                })
                            } else if (cornerColor == Color.red) {
                                Button(action: {
                                    isX = true
                                }, label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                })
                            }
                            Button(action:{
                                isAlert = true
                            }, label:{
                                Image(systemName: "trash")
                            })
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        }
        .alert("このクーポンを削除しますか",isPresented: $isAlert) {
            Button("削除", role: .destructive) {
                deleteCard()
            }
            Button("キャンセル", role: .cancel) {
                print("削除ボタンが押されました")
            }
        }message: {
            Text("この操作は取り消せません")
        }
        .alert("通知",isPresented: $isWarning) {
            Button("閉じる", role: .cancel) {
                print("削除ボタンが押されました")
            }
        }message: {
            Text("このクーポンはあともう少しで期限が切れます")
        }
        .alert("通知",isPresented: $isX) {
            Button("閉じる", role: .cancel) {
                print("削除ボタンが押されました")
            }
        }message: {
            Text("このクーポンは既に期限が切れています")
        }
    }
}


#Preview{
    // CardView()
}
