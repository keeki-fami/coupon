//
//  CardView.swift
//  coupon
//
//  カードのView
//

import SwiftUI
import AudioToolbox

struct CardView: View {
    @State private var isCardInfo = false
    @State private var cornerColor = Color.gray
    @State private var cornerLineWidth:CGFloat = 2
    let companyName:String?
    let couponName:String?
    let limit:Date?
    let notes:String?
    let selectedImage:Data?
    let couponId:String?
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
                couponId: couponId,
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
                let cardLimitFormat = calendar.startOfDay(for: cardLimit)
                
                print("\(date)")
                print("\(couponName):\(cardLimitFormat)")
                if cardLimitFormat.timeIntervalSince(date) <= 60*60*24 {
                    print("aaa")
                    print("\(couponName)は、黄色です。")
                    cornerColor = .yellow
                    cornerLineWidth = 5
                } else { print("false") }
                if cardLimitFormat.timeIntervalSince(date) < 0 {
                    print("\(couponName)は、赤色です。")
                    cornerColor = .red
                    cornerLineWidth = 5
                }
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
    let couponId: String?
    let cornerColor: Color
    @State private var isAlert = false
    @State private var isWarning = false
    @State private var isX = false
    @State private var isCheck = false
    @State private var isGood = false
    @EnvironmentObject private var isEditView: IsEditView
    let UINFGenerator = UINotificationFeedbackGenerator()
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
                            Button(action: {
                                isCheck = true
                            }, label: {
                                Image(systemName: "checkmark.circle.fill")
                            })
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
        .alert(String(localized: "CardViewDeleteAlert"),isPresented: $isAlert) {
            Button("削除", role: .destructive) {
                deleteCard()
                if let couponid = couponId {
                    print("クーポンID\(couponid)を削除しました。")
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [couponid])
                }

            }
            Button(String(localized: "CardViewCancelButton"), role: .cancel) {
                print("削除ボタンが押されました")
            }
        }message: {
            Text(String(localized: "CardViewWarningMessage"))
        }
        .alert(String(localized: "CardViewNotification" ),isPresented: $isWarning) {
            Button(String(localized: "CardViewCloseButton"), role: .cancel) {
                print("削除ボタンが押されました")
            }
        }message: {
            Text(String(localized: "CardViewWillExpire"))
        }
        .alert(String(localized: "CardViewNotification"),isPresented: $isX) {
            Button(String(localized: "CardViewCloseButton"), role: .cancel) {
                print("削除ボタンが押されました")
            }
        }message: {
            Text(String(localized: "CardViewLimitExpire"))
        }
        
        .alert(String(localized: "CardVierConfirm"), isPresented: $isCheck) {
            Button(String(localized: "CardViewOkayButton"), role: .destructive) {
                Task {
                    UINFGenerator.notificationOccurred(.success)
                    deleteCard()
                    popupGoodView()
                    await updateCardUsed()
                }
            }
            Button(String(localized: "CardViewCancelButton"), role: .cancel){
                print("キャンセルが押されました。")
            }
        }message: {
            Text(String(localized: "CardViewUsed"))
        }
    }
    func popupGoodView() {
        isEditView.isGoodView = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            isEditView.isGoodView = false
        }
        
    }
}


#Preview{
    // CardView()
}
