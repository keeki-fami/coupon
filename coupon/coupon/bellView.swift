//
//  bellView.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/14.
//

import SwiftUI

struct BellView: View {
    @State private var isCalendar = false
    @State private var date: Date = Date()
    @State private var nowHour = 0
    @State private var nowMinute = 0
    @State private var isNotify = false
    @State private var isCalendarView = false
    @AppStorage("notificationHour") private var hour: Int = 0
    @AppStorage("notificationMinute") private var minute: Int = 0
    var body: some View {
        NavigationStack{
            GeometryReader {geometry in
                VStack{
                    
                    Spacer()
                    
                    Text("現在の通知時間")
                    Text("\(String(format: "%02d",nowHour)):\(String(format: "%02d", nowMinute))" )
                        .font(.system(size: 30))
                        .bold()
                        .padding()
                    
                    Spacer()
                    
//                    DatePicker(" 通知", selection: $date, displayedComponents: .hourAndMinute)
//                        .datePickerStyle(.compact)
                    
                    VStack(spacing:5){
                        Button(action:{
                            isCalendarView = true
                            
                        },label: {
                            VStack(spacing:5){
                                HStack{
                                    Text("変更")
                                    Spacer()
                                }
                                
                                ZStack{
                                
                                    Rectangle()
                                        .fill(Color("BellButton"))
                                        .shadow(color: .gray.opacity(0.3),radius:5)
                                    HStack{
                                        Spacer()
                                        Text("\(dateToStringLimit(date:date))")
                                        Spacer()
                                    }
                                }
                            }
                            .textFieldStyle(.plain)                // 縁なし
                            .padding(.horizontal)                  // 内側の余白
                            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                            
                            .foregroundColor(Color("TextColor"))
                        })

                            .sheet(isPresented: $isCalendarView){
                                CalendarListView(limit: $date)
                                    .presentationDetents([.medium])
                                    .presentationDragIndicator(.visible)
                            }
                    }
                    .padding(10)
                        .onAppear() {
                            let calendar = Calendar.current
                            var components = calendar.dateComponents([.hour,.minute],from:Date())
                            
                            nowHour = hour
                            nowMinute = minute
                            components.hour = nowHour
                            components.minute = nowMinute
                            
                            if let madeDate = calendar.date(from: components) {
                                date = madeDate
                            }
                        }
                    Spacer()
                    
                    Button("登録") {
                        isNotify = true
                        let calendar = Calendar.current
                        hour = calendar.component(.hour, from: date)
                        minute = calendar.component(.minute, from: date)
                        nowHour = hour
                        nowMinute = minute
                    }
                    .navigationTitle("通知設定")
                    
                    Spacer()
                    
                    ZStack{
                        Rectangle()
                            .fill(Color("InfomationBackground"))
                            .frame(height:geometry.size.height * 0.5)
                        VStack(alignment:.leading){
                            Text("設定した時間に通知が送信されます。")
                                .padding(.vertical)
                            Text("例：12:00で登録")
                            Text("9月15日期限　→ 9月14日12:00に通知")
                            Spacer()
                        }
                        
                    }
                    .foregroundColor(.gray)
                    .frame(height:geometry.size.height * 0.5)
                }
                .alert("通知",isPresented: $isNotify) {
                    Button("OK", role: .cancel) {
                        print("削除ボタンが押されました")
                    }
                }message: {
                    Text("通知時間の設定が完了しました")
                }
            }
        }
    }
}
