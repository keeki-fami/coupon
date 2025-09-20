//
//  InfomationView.swift
//  coupon
//
//  Created by 櫻田聖和 on 9/19/25.
//

import SwiftUI

struct InfomationView: View {
    @State private var usedInMonth = 0
    @State private var allInMonth = 0
    @State private var usedInAll = 0
    @State private var allInAll = 0
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack() {
                    
                    VStack(spacing: 5) {
                        
                        HStack() {
                            Text("今月")
                            Spacer()
                        }
                        .padding(.horizontal)
                        HStack() {
                            
                            Spacer()
                            
                            VStack {
                                Spacer()
                                Text("\(String(usedInMonth))")
                                    .font(.system(size: 40))
                                    .bold()
                                    .padding()
                                Spacer()
                                Text("使用数")
                                    .padding()
                            }
                            .frame(
                                width: geometry.size.width*0.4,
                                height: geometry.size.width*0.4
                            )
                            .background(Color("InfomationBackground"))
                            
                            Spacer()
                            
                            VStack {
                                Spacer()
                                Text("\(String(allInMonth))")
                                    .font(.system(size: 40))
                                    .bold()
                                    .padding()
                                Spacer()
                                Text("登録数")
                                    .padding()
                            }
                            .frame(
                                width: geometry.size.width*0.4,
                                height: geometry.size.width*0.4
                            )
                            .background(Color("InfomationBackground"))
                            
                            Spacer()
                        }
                        
                    }
                    .padding()
                    
                    VStack(spacing: 5) {
                        
                        HStack() {
                            Text("全体")
                            Spacer()
                        }
                        .padding(.horizontal)
                        HStack() {
                            
                            Spacer()
                            
                            VStack {
                                Spacer()
                                Text("\(String(usedInAll))")
                                    .font(.system(size: 40))
                                    .bold()
                                    .padding()
                                Spacer()
                                Text("使用数")
                                    .padding()
                            }
                            .frame(
                                width: geometry.size.width*0.4,
                                height: geometry.size.width*0.4
                            )
                            .background(Color("InfomationBackground"))
                            
                            Spacer()
                            
                            VStack {
                                Spacer()
                                Text("\(String(allInAll))")
                                    .font(.system(size: 40))
                                    .bold()
                                    .padding()
                                Spacer()
                                Text("登録数")
                                    .padding()
                            }
                            .frame(
                                width: geometry.size.width*0.4,
                                height: geometry.size.width*0.4
                            )
                            .background(Color("InfomationBackground"))
                            
                            Spacer()
                        }
                        
                    }
                    .padding()
                    
                }
                .navigationTitle("情報")
            }
            .onAppear() {
                usedInMonth = UserDefaults.standard.integer(forKey: "usedInMonth")
                allInMonth = UserDefaults.standard.integer(forKey: "allInMonth")
                usedInAll = UserDefaults.standard.integer(forKey: "usedInAll")
                allInAll = UserDefaults.standard.integer(forKey: "allInAll")
                
            }
            
        }

    }
}

#Preview {
    InfomationView()
}
