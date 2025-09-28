//
//  EditView.swift
//  coupon
//
//  編集画面のView
//

import SwiftUI
import PhotosUI

struct EditView: View {
    @Binding var recognizedText: String
    @Binding var selectedImage: UIImage?
    @Binding var largestText: String?
    @StateObject private var editViewModel = EditViewModel()
    @StateObject private var addCouponModel = AddCouponModel()
    @State private var limitDate: String?
    @State private var companyName: String?
    @EnvironmentObject var isEditView: IsEditView
    @State private var isCalendarView:Bool = false
    @State private var photoPickerItem: PhotosPickerItem?
    @State private var isAlert = false
    @State private var isLoadingView = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    )private var coupons: FetchedResults<CardModel>
    
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .fill(Color("EditViewBackgroundColor"))
                
                ScrollView{
                    
                    VStack(spacing:5){
                        
                        HStack{
                            
                            Text("写真")
                            Spacer()
                        }
                        ZStack{
                            
                            Rectangle()
                                .fill(Color("EditViewTextColor"))
                                .frame(maxWidth:.infinity,minHeight:200,maxHeight:200)
                            PhotosPicker(selection: $photoPickerItem) {
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
                            }
                            .onChange(of: photoPickerItem) { item in
                                
                                Task {
                                    
                                    guard let data = try? await item?.loadTransferable(type: Data.self) else { return }
                                    guard let uiImage = UIImage(data: data) else { return }
                                    addCouponModel.selectedImage = uiImage
                                }
                            }
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
                            .background(Color("EditViewTextColor"))
                            .foregroundColor(Color("TextColor"))
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
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)            // 幅いっぱい
                            .foregroundColor(Color("TextColor"))
                            .background(Color("EditViewTextColor"))
                    }
                    .padding(10)
                    VStack(spacing:5){
                        
                        HStack{
                            
                            Text("クーポン名")
                            Spacer()
                        }
                        TextField("クーポン名",text:$addCouponModel.couponName)
                            .textFieldStyle(.plain)                // 縁なし
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)            // 幅いっぱい
                            .foregroundColor(Color("TextColor"))
                            .background(Color("EditViewTextColor"))
                    }
                    .padding(10)
                    
//                    VStack(spacing:5){
//                        HStack{
//                            Text("備考")
//                            Spacer()
//                        }
//                        TextEditor(text: $addCouponModel.notes)
//                            .textFieldStyle(.plain)                // 縁なし
//                            .padding(.horizontal)                  // 内側の余白
//                            .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)            // 幅いっぱい
//                            .foregroundColor(Color("TextColor"))
//                            .scrollContentBackground(.hidden)
//                            .background(Color("EditViewTextColor"))
//                    }
//                    .padding(10)
                    Button(action: {
                        
                        Task{
                            
                            isLoadingView = true
                            await setCoreDataToCard(addCouponModel:addCouponModel)
                            await updateCompanyList(company:addCouponModel.companyName)
                            await updateCouponInfomation()
                            isEditView.isEdit = false
                        }
                        
                    }, label: {
                        
                        Text("追加")
                    })
                    .padding()
                    
                }
                .navigationTitle("編集")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading:Button("キャンセル"){
                        
                        isAlert = true
                    }
                )
                .alert("操作を中止しますか",isPresented: $isAlert) {
                    
                    Button("中止", role: .destructive) {
                        
                        isEditView.isEdit = false
                    }
                    Button("戻る", role: .cancel) {
                        
                        isAlert = false
                    }
                    
                } message: {
                    
                    Text("この操作は元に戻せません")
                }
                .onTapGesture{
                    
                    UIApplication.shared.closeKeyboard()
                    print("フォーカスの変更 closeKeyboard呼び出し")
                }
            }
            .onAppear(){
                
                addCouponModel.clean()
                print("渡されたrecognizedText:\(recognizedText)")
                limitDate = editViewModel.extractDateRange(from: recognizedText)
                companyName = editViewModel.extractCompany(from: recognizedText)
                addCouponModel.setStart(limit:limitDate,
                                        companyName:companyName,
                                        couponName:largestText,
                                        selectedImage:selectedImage
                )
            }
            .interactiveDismissDisabled()
            .scrollDismissesKeyboard(.interactively)
            
        }
    }
    
    func setCoreDataToCard(addCouponModel: AddCouponModel) async {
        let newCard = CardModel(context: viewContext)
        newCard.couponName = addCouponModel.couponName
        newCard.companyName = addCouponModel.companyName
        newCard.notes = addCouponModel.notes
        newCard.limit = addCouponModel.limit
        newCard.selectedImage = imageToBinary(addCouponModel.selectedImage)
        
        // identifierの作成
        let id = genUUID()
        newCard.identifier = id
        
        scheduleNotification(
            date:addCouponModel.limit,
            coupon:addCouponModel.couponName,
            id:id)
        
        do {
            try viewContext.save()
            print("画像を保存しました")
        } catch {
            print("保存エラー: \(error)")
        }

    }
    
    func imageToBinary(_ selectedImage: UIImage?) -> Data? {
        
        if let image = selectedImage,
           let imageData = image.jpegData(compressionQuality: 0.8){
            return imageData
            
        } else {
            
            return nil
        }
    }
    
    func genUUID() -> String {
        
        let id = UUID()
        return id.uuidString
    }
    
    func updateCouponInfomation() async {
        
        let allinall = UserDefaults.standard.integer(forKey: "allInAll")
        let allinmonth = UserDefaults.standard.integer(forKey: "allInMonth")
        UserDefaults.standard.set(allinall + 1, forKey: "allInAll")
        UserDefaults.standard.set(allinmonth + 1, forKey: "allInMonth")
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
