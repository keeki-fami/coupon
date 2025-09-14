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
    content.body = "\(coupon)　の使用期限は、明日切れます。"
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
    
    if let previousDay = calendar.date(byAdding:.day,value: -1, to: date) {
        var components = calendar.dateComponents([.year, .month, .day],from: previousDay)
        components.hour = 9
        components.minute = 0
        components.second = 0
        
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

