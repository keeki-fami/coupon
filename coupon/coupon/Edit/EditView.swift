//
//  EditView.swift
//  coupon
//
//  編集画面のView
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
    @EnvironmentObject var isEditView: IsEditView
    @State private var isCalendarView:Bool = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    )private var coupons: FetchedResults<CardModel>
    
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .fill(Color(red: 242/255, green: 242/255, blue: 247/255))
                
                ScrollView{
                    
                    VStack(spacing:5){
                        HStack{
                            Text("写真")
                            Spacer()
                        }
                        ZStack{
                            Rectangle()
                                .fill(.white)
                                .frame(maxWidth:.infinity,minHeight:200,maxHeight:200)
                            Button(action:{
                                print("ボタンがタップされました")
                            },label:{
                                ZStack{
                                    Image(uiImage: addCouponModel.selectedImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 200)
                                    Rectangle()
                                        .fill(.black)
                                        .frame(width: 150, height: 200)
                                        .opacity(0.5)
                                    Image(systemName: "photo")
                                }
                            })
                        }
                    }
                    .padding(10)
                    
                    VStack(spacing:5){
                        HStack{
                            Text("期限")
                            Spacer()
                        }
                        Button(action:{
                            isCalendarView = true
                            
                        },label: {
                            Text("\(dateToString(date: addCouponModel.limit) ?? "MM/dd")")
                            Spacer()
                        })
                            .textFieldStyle(.plain)                // 縁なし
                            .padding(.horizontal)                  // 内側の余白
                            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)            // 幅いっぱい
                            .background(Color.white)
                            .sheet(isPresented: $isCalendarView){
                                CalendarView(limit: $addCouponModel.limit)
                                    .presentationDetents([.medium])
                                    .presentationDragIndicator(.visible)
                            }
                    }
                    .padding(10)
                    
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
                            Text("備考")
                            Spacer()
                        }
                        TextEditor(text: $addCouponModel.notes)
                            .textFieldStyle(.plain)                // 縁なし
                            .padding(.horizontal)                  // 内側の余白
                            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)            // 幅いっぱい
                            .background(Color.white)
                    }
                    .padding(10)
                    
                    Button(action: {
                        setCoreDataToCard(addCouponModel:addCouponModel)
                        isEditView.isEdit = false
                    }, label: {
                        Text("追加")
                    })
                    .padding()
                    
                }
                .navigationTitle("編集")
                .navigationBarTitleDisplayMode(.inline)
                .onTapGesture{
                    UIApplication.shared.closeKeyboard()
                    print("フォーカスの変更 closeKeyboard呼び出し")
                }
            }
            .onAppear(){
                addCouponModel.clean()
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
    
    func setCoreDataToCard(addCouponModel: AddCouponModel) {
        let newCard = CardModel(context: viewContext)
        newCard.couponName = addCouponModel.couponName
        newCard.companyName = addCouponModel.companyName
        newCard.notes = addCouponModel.notes
        newCard.limit = addCouponModel.limit
        newCard.selectedImage = imageToBinary(addCouponModel.selectedImage)
        do {
            try viewContext.save()
            print("画像を保存しました")
        } catch {
            print("保存エラー: \(error)")
        }

    }
    
    func imageToBinary(_ seledtedImage: UIImage?) -> Data? {
        if let image = selectedImage,
           let imageData = image.jpegData(compressionQuality: 0.8){
            return imageData
        } else {
            return nil
        }
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
