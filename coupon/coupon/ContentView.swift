//
//  ContentView.swift
//  coupon
//
//  タブビュー
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var isEditView: IsEditView
    @AppStorage("isNotificated_1") private var isNotificated = false
    @AppStorage("usedInMonth") var usedInMonth = 0
    @AppStorage("allInMonth") var allInMonth = 0
    @AppStorage("usedInAll") var usedInAll = 0
    @AppStorage("allInAll") var allInAll = 0
    @AppStorage("LastOpen") var lastOpen = 8
    @State private var selection = 0
    @State private var isPickerPresented = false
    @State private var isImageCropper = false
    @State private var recognizedText: String = ""
    @State private var largestText: String? = ""
    @State private var selectedImage: UIImage?
    @State var isLoading: Bool = false
    @State private var showTitle = false
    @State private var isAppStore = false
    var body: some View {
        NavigationStack{
            VStack(spacing:0){
                TabView(selection: $selection){
                    
                    CouponListView()
                        .tag(0)
                    
                    InfomationView()
                        .tag(1)
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination: BellView()) {
                            Image(systemName: "clock")
                        }
                    }
                }
                
                
                ZStack(){
                    Rectangle()
                        .fill(Color("EditViewBackgroundColor"))
                        .frame(height:80)
                        .shadow(color: .gray, radius: 5, x:0, y:-2)
                    ZStack{
                        Rectangle()
                            .fill(Color("EditViewBackgroundColor"))
                            .ignoresSafeArea(edges: .bottom)
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                selection = 0
                            }, label: {
                                VStack{
                                    Image(systemName: "ticket")
                                    Text("coupon")
                                }
                                .foregroundColor(selection == 0 ? .blue : .gray)
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                isPickerPresented = true
                                print("押されました")
                            }, label: {
                                VStack{
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width:50, height:50)
                                }
                                .foregroundColor(.blue)
                            })
                            
                            Spacer()
                            
                            Button(action: {
                                selection = 1
                            }, label: {
                                VStack{
                                    Image(systemName:"info.square")
                                    Text("info")
                                }
                                .foregroundColor(selection == 1 ? .blue : .gray)
                            })
                            
                            Spacer()
                        }
                    }
                    .frame(height:80)
                }
                .sheet(isPresented: $isPickerPresented) {
                    ImagePicker(image: $selectedImage, done: toggleImageCropper)
                        .onAppear(){
                            // recognizedtextの初期化
                            recognizedText = ""
                        }
                }
                .sheet(isPresented:$isImageCropper) {
                    ImageCropper(image: $selectedImage, visible: $isImageCropper, done: creppedImage, onImagePicked: { image in
                        Task{
                            
                            isLoading = true
                            await recognizeText(
                                from: image,
                                recognizedText: $recognizedText,
                                largestText: $largestText
                            )
                            await displayEditView(isLoading: $isLoading)
                            
                        }
                    })
                }
                .sheet(isPresented: $isEditView.isEdit) {
                    EditView(recognizedText: $recognizedText,
                             selectedImage: $selectedImage,
                             largestText: $largestText)
                    .onAppear(){
                        print("呼び出します")
                    }
                }
                
            }
            .navigationTitle(selection == 0 ? "クーポン" : "情報")
            .overlay(){
                if isLoading {
                    LoadingView()
                        .onAppear(){
                            print("出力")
                        }
                }
                if isEditView.isGoodView {
                    GoodView()
                }
            }
            .onAppear() {
                judgeMonth()
                
                let update = Update()
                update.fetchLatestVersion {
                    let result = update.compareVersion()
                    if result {
                        isAppStore = true
                    } else {
                        isAppStore = false
                    }
                }
            }
            .alert("最新版があります",isPresented: $isAppStore) {
                Button("移動") {
                        if let url = URL(string: "https://apps.apple.com/jp/app/id6752533878"),
                           UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                }
                Button("キャンセル", role: .cancel) {
                    print("削除ボタンが押されました")
                }
            }message: {
                Text("AppStoreで最新版をインストールしてください。")
            }
        }
        
    }
    
    func judgeMonth() {
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let lastMonthNum = lastOpen
        
        print("月の最初")
        if lastMonthNum != month {
            lastOpen = month
            UserDefaults.standard.set(0, forKey:"usedInMonth")
            UserDefaults.standard.set(0, forKey:"allInMonth")
        }
        
    }
    
    func displayEditView(isLoading: Binding<Bool>) async {
        isEditView.isEdit = true
        isLoading.wrappedValue = false
    }
    
    func creppedImage(image: UIImage) {
        selectedImage = image
    }
    func toggleImageCropper() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation{
                isImageCropper = true
            }
        }
        isImageCropper = true
    }
}

//通知の許可をアラートで求める
private func requestNotification() {
    let center = UNUserNotificationCenter.current()
    //requestAuthorization
    center.requestAuthorization(options: .alert) { granted, error in
        if granted {
            print("許可されました。")
        } else {
            print("拒否されました。")
        }
    }
}

#Preview {
    ContentView()
}
