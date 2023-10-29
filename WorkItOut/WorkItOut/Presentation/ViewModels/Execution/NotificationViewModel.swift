//
//  NotificationViewModel.swift
//  WorkItOut
//
//  Created by Angela Valentine Darmawan on 28/10/23.
//

import Foundation
import UserNotifications

class NotificationViewModel: NSObject, UNUserNotificationCenterDelegate {
    
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
    
    func makeNotification(title:String ,subtitle: String) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil) //no trigger, so the notif will pop up immediately
        
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

