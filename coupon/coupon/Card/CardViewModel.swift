//
//  CardViewModel.swift
//  coupon
//
//  Created by 桜田聖和 on 2025/09/07.
//
import SwiftUI

func dateToString(date: Date?) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd"
    
    if let exactDate = date {
        return formatter.string(from:exactDate)
    } else {
        return nil
    }
}

func dateToStringLimit(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    
    return formatter.string(from: date)
}

func dateToStringWithoutYear(date: Date?) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd"
    
    if let exactDate = date {
        return formatter.string(from:exactDate)
    } else {
        return nil
    }
    
}

func exactDateFormatter(stringDate: String) -> String {
    if stringDate.contains("/") {
        return "MM/dd"
    } else if stringDate.contains("-") {
        return "MM-dd"
    } else {
        return "MM月dd日"
    }
}

// informationviewで表示する情報の更新（使用済み時に）
func updateCardUsed() async {
    let usedinmonth = UserDefaults.standard.integer(forKey: "usedInMonth")
    let usedinall = UserDefaults.standard.integer(forKey: "usedInAll")
    
    UserDefaults.standard.set(usedinmonth + 1, forKey: "usedInMonth")
    UserDefaults.standard.set(usedinall + 1, forKey: "usedInAll")
}
