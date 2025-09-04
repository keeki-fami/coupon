//
//  ContentView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/08/29.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var isEditView: IsEditView
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
    }
}

#Preview {
    ContentView()
}
