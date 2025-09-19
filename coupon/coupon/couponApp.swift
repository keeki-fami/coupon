//
//  couponApp.swift
//  coupon
//
//  main
//

import SwiftUI

@main
struct couponApp: App {
    @StateObject private var isEditView = IsEditView()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    @AppStorage("isInitCompanyList") private var isInitCompanyList = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(isEditView)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear() {
                    if isInitCompanyList == false {
                        isInitCompanyList = true
                        UserDefaults.standard.set(["セブンイレブン","セブン-イレブン","スターバックス","STARBUCKS","ローソン","ファミリーマート","ミニストップ"],forKey:"companyList") 
                    }
                }
        }
    }
}

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        // 通知権限リクエスト
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("通知許可OK")
            } else {
                print("通知拒否")
            }
        }

        // フォアグラウンド通知表示用
        UNUserNotificationCenter.current().delegate = self

        return true
    }
        // フォアグラウンドでも通知を表示
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler:
                                       @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.banner, .sound])
        }
}
//extension AppDelegate: UNUserNotificationCenterDelegate {
//    // フォアグラウンドでも通知を表示
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler:
//                                   @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.banner, .sound])
//    }
//}
