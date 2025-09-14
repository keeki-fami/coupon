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
    var body: some View {
        TabView{
            CouponListView()
                .tabItem{
                    Image(systemName: "ticket")
                    Text("coupon")
                }
            AddCouponCard()
                .tabItem{
                    Image(systemName:"barcode.viewfinder")
                    Text("scan")
                }
        }
        .onAppear(){
//            if isNotificated == false {
//                requestNotification()
//                isNotificated = true
//            }
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
