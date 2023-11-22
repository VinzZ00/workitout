//
//  NotificationViewModel.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 28/10/23.
//

import Foundation
import UserNotifications

class NotificationViewModel: NSObject, UNUserNotificationCenterDelegate, ObservableObject {
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                print("Authorization success")
                UNUserNotificationCenter.current().delegate = self // Set the delegate here
            }
        }
    }
    
    //call this function to schedule the notification
    
    func makeNotification(title:String, subtitle: String, date: Day, time: TimeOfDay) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        
        var dateInfo = DateComponents()
        var dates = date.getInt()
        if dates == 7 {
            dates = 1
        }
        else {
            dates += 1
        }
        dateInfo.weekday = dates
        
        switch time{
            case .morning:
            dateInfo.hour = 6
            dateInfo.minute = 0
        case .afternoon:
            dateInfo.hour = 12
            dateInfo.minute = 0
        case .evening:
            dateInfo.hour = 18
            dateInfo.minute = 0
        }
        
//        //specify if repeats or no
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger) //no trigger, so the notif will pop up immediately
        
        UNUserNotificationCenter.current().add(request)
            { error in
                if let error = error {
                    print("Notification error: \(error)")
                } else {
                    print("Notification shown")
                }
            }
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound, .badge]) // Show the notification while the app is in the foreground
    }
}

