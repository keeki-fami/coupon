
import SwiftUI

struct BellView: View {
    @State private var isCalendar = false
    @State private var date: Date = Date()
    @State private var nowHour = 0
    @State private var nowMinute = 0
    @State private var nowCallDay = 1
    @State private var isNotify = false
    @State private var isCalendarView = false
    @State private var isCalendarDateView = false
    @AppStorage("notificationHour") private var hour: Int = 0
    @AppStorage("notificationMinute") private var minute: Int = 0
    @AppStorage("notificationDay") private var callDay: Int = 1
    var body: some View {
        NavigationStack{
            GeometryReader {geometry in
                VStack{
                    
                    Spacer()
                    
                    Text(String(localized: "bellViewNowNotificationTimeLabel"))
                    VStack(spacing:5){
                        Text("\(String(format: "%02d",nowHour)):\(String(format: "%02d", nowMinute))" )
                    }
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
                                    Text(String(localized: "bellViewSelectTimeLabel"))
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
                    .padding(5)
                        .onAppear() {
                            let calendar = Calendar.current
                            var components = calendar.dateComponents([.hour,.minute],from:Date())
                            
                            nowHour = hour
                            nowMinute = minute
                            components.hour = nowHour
                            components.minute = nowMinute
                            nowCallDay = callDay
                            
                            if let madeDate = calendar.date(from: components) {
                                date = madeDate
                            }
                        }
                    
                    VStack(spacing:5){
                        Button(action:{
                            isCalendarDateView = true
                            
                        },label: {
                            VStack(spacing:5){
                                HStack{
                                    Text(String(localized: "bellViewSelectNotificationTimeLabel"))
                                    Spacer()
                                }
                                
                                ZStack{
                                
                                    Rectangle()
                                        .fill(Color("BellButton"))
                                        .shadow(color: .gray.opacity(0.3),radius:5)
                                    HStack{
                                        Spacer()
                                        Text("\(String(nowCallDay))" + (nowCallDay == 1 ? String(localized: "bellViewNotificationDay_ForOne") : String(localized: "bellViewNotificationDay")))
                                        Spacer()
                                    }
                                }
                            }
                            .textFieldStyle(.plain)                // 縁なし
                            .padding(.horizontal)                  // 内側の余白
                            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                            
                            .foregroundColor(Color("TextColor"))
                        })
                            .sheet(isPresented: $isCalendarDateView){
                                CalendarDateView(selection: $nowCallDay)
                                    .presentationDetents([.medium])
                                    .presentationDragIndicator(.visible)
                            }
                    }
                    .padding(5)
                    Spacer()
                    
                    
                    
                    Button(String(localized: "bellViewRegisterButton")) {
                        
                        isNotify = true
                        let calendar = Calendar.current
                        hour = calendar.component(.hour, from: date)
                        minute = calendar.component(.minute, from: date)
                        callDay = nowCallDay
                        nowHour = hour
                        nowMinute = minute
                        
                    }
                    .navigationTitle(String(localized: "bellViewLabel"))
                    
                    Spacer()
                    
                    ZStack{
                        Rectangle()
                            .fill(Color("InfomationBackground"))
                            .frame(height:geometry.size.height * 0.5)
                        VStack(){
                            VStack(spacing:5){
                                HStack{
                                    Text(String(localized: "bellViewDescription1"))
                                    Spacer()
                                }
                                .padding(.horizontal)
                                HStack{
                                    Text(String(localized: "bellViewDescription2"))
                                    Spacer()
                                }
                                .padding(.horizontal)
                                HStack{
                                    Text(String(localized: "bellViewDescription3"))
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                            .padding(.vertical)
                            VStack(spacing:5){
                                HStack{
                                    Text(String(localized: "bellViewDescription4"))
                                    Spacer()
                                }
                                .padding(.horizontal)
                                HStack{
                                    Text(String(localized: "bellViewDescription5"))
                                    Spacer()
                                }
                                .padding(.horizontal)
                                HStack{
                                    Text(String(localized: "bellViewDescription6"))
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                            Spacer()
                        }
                        
                        
                    }
                    .foregroundColor(.gray)
                    .frame(height:geometry.size.height * 0.5)
                }
                .alert(String(localized: "bellViewNotificationButton"),isPresented: $isNotify) {
                    Button(String(localized: "bellViewOkayButton"), role: .cancel) {
                        print("削除ボタンが押されました")
                    }
                }message: {
                    Text(String(localized: "bellViewSettiongCompleteLabel"))
                }
            }
        }
    }
}
