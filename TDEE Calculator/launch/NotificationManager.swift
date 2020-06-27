//
//  NotificationManager.swift
//  TDEE Calculator
//
//  Created by Andrei Khvalko on 6/27/20.
//  Copyright © 2020 Greams. All rights reserved.
//


import UserNotifications


struct Notification {

    var id: String
    var title: String
    var body: String
}

class NotificationManager {

    private var notifications: [ Notification ] = []
    
    func completionHandler(granted: Bool, error: Error?) {

        if granted == true && error == nil {
            self.scheduleNotifications()
        }
    }
    
    func requestPermission() {
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .alert],
            completionHandler: self.completionHandler
        )
    }

    func addNotification(title: String, body: String) {
        self.notifications.append(
            Notification(id: UUID().uuidString, title: title, body: body)
        )
    }

    func scheduleNotifications() {

        for notification in self.notifications {

            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                
                if error == nil {
                    print("Scheduling notification with id: \(notification.id)")
                }
            }
        }
    }

    
    func schedule() {

        UNUserNotificationCenter.current().getNotificationSettings { settings in

            switch settings.authorizationStatus {
                case .notDetermined:
                    self.requestPermission()
                case .authorized, .provisional:
                    self.scheduleNotifications()
                default:
                    break
            }
        }
    }
    
    
    
    public static func scheduleNotification(title: String, body: String) {

        let nm = NotificationManager()

        nm.addNotification(title: title, body: body)
        nm.schedule()
    }
}

