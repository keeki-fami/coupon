//
//  Explanation.swift
//  coupon
//
//  Created by 櫻田聖和 on 9/23/25.
//

import SwiftUI

struct Explanation: View {
    @State private var selection = 0
    @Binding var isExplanation: Bool
    var body: some View {
        
        ZStack{
            Rectangle()
                .fill(Color(red: 225/256, green: 168/256 ,blue: 64/256))
            TabView(selection: $selection) {
                Image("explanation1")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(0)
                Image("explanation2")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                    .tag(1)
                ZStack{
                    Image("explanation3")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                        .tag(2)
                    VStack{
                        Spacer()
                        Button(action: {
                            UserDefaults.standard.set(false,forKey:"isFirstOpen")
                            isExplanation = false
                        }, label:{
                            ZStack{
                                Rectangle()
                                    .fill(.cyan)
                                    .cornerRadius(20)
                                    .frame(width:200,height:70)
                                Text("始める")
                                    .foregroundColor(.white)
                            }
                            
                        })
                        .padding(40)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}
