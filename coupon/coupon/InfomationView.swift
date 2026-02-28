

import SwiftUI

struct InfomationView: View {
    @State private var usedInMonth = 0
    @State private var allInMonth = 0
    @State private var usedInAll = 0
    @State private var allInAll = 0
    @State private var percent = 0.0
    var body: some View {
        GeometryReader { geometry in
             ScrollView {
            
                VStack() {
                    
                    VStack(spacing: 5){
                        HStack {
                            Text(String(localized: "InfomationUseLabel"))
                            Spacer()
                        }
                        .padding(.horizontal)
                        Text("\(String(Int(percent * 100)))%")
                            .font(.system(size: 40))
                            .bold()
                            .padding()
                    }
                    
                    VStack(spacing: 5) {
                        
                        HStack() {
                            Text(String(localized: "InfomationThisMonthLabel"))
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
                                Text(String(localized: "InfomationNumberOfUse"))
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
                                Text(String(localized: "InfomationNumberOfRegister"))
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
                            Text(String(localized: "InfomationWholeLabel"))
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
                                Text(String(localized: "InfomationNumberOfUse"))
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
                                Text(String(localized: "InfomationNumberOfRegister"))
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
                // .navigationTitle("情報")
             }
            .onAppear() {
                usedInMonth = UserDefaults.standard.integer(forKey: "usedInMonth")
                allInMonth = UserDefaults.standard.integer(forKey: "allInMonth")
                usedInAll = UserDefaults.standard.integer(forKey: "usedInAll")
                allInAll = UserDefaults.standard.integer(forKey: "allInAll")
                
                if allInMonth > 0 {
                    percent = Double(usedInMonth) / Double(allInMonth)
                }
                
            }
            
        }

    }
}

#Preview {
    InfomationView()
}
