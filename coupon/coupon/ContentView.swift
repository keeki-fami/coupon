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
    @State private var selection = 0
    var body: some View {
        VStack(spacing:0){
            TabView(selection: $selection){
                
                CouponListView()
                    .tag(0)
                
                AddCouponCard()
                    .tag(1)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            
            ZStack(){
                Rectangle()
                    .fill(.white)
                    .frame(height:80)
                    .shadow(color: .gray, radius: 5, x:0, y:-2)
                ZStack{
                    Rectangle()
                        .fill(.white)
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
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            selection = 1
                        }, label: {
                            VStack{
                                Image(systemName:"barcode.viewfinder")
                                Text("scan")
                            }
                        })
                        
                        Spacer()
                    }
                }
                .frame(height:80)
            }
        }
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
