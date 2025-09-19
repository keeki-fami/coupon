//
//  NotificationModel.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/13.
//

import UserNotifications
import SwiftUI

func scheduleNotification(date: Date, coupon: String,id:String) {
    let content = UNMutableNotificationContent()
    content.title = "🚨期限通知🚨"
    content.body = "クーポン \"\(coupon)\" の使用期限は、明日までです。"
    content.sound = .default
    
    let notificationDate = notificationDateChanger(date: date)
    
    guard let notification = notificationDate else {
        print("error: notificationDate is null")
        return
    }
    
    let triggerDate = Calendar.current.dateComponents(
        [.year, .month, .day, .hour, .minute, .second],
        from: notification
    )
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
    
    let request = UNNotificationRequest(identifier: id,
                                        content: content,
                                        trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)
    print("追加しました")
}

func notificationDateChanger(date: Date) -> Date? {
    let calendar = Calendar.current
    
    let hour = UserDefaults.standard.integer(forKey: "notificationHour")
    let minute = UserDefaults.standard.integer(forKey: "notificationMinute")
    
    if let previousDay = calendar.date(byAdding:.day,value: -1, to: date) {
        var components = calendar.dateComponents([.year, .month, .day],from: previousDay)
        components.hour = hour
        components.minute = minute
        components.second = 0
        
        print("値をセット：\(hour):\(minute)")
        
        if let newDate = calendar.date(from: components) {
            print(newDate)
            return newDate
        } else {
            return nil
        }
    } else {
        return nil
    }
}

