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

enum ReminderType: String {
    case WeightInput, FoodInput
}

class NotificationManager {

    private static var center: UNUserNotificationCenter {
        UNUserNotificationCenter.current()
    }
    
    private static func getNotification(notificationType: ReminderType) -> Notification {
        
        switch notificationType {
            case ReminderType.WeightInput:
                return Notification(
                    id: notificationType.rawValue,
                    title: "Update Entry",
                    body: "It's time to add your weight"
                )
            case ReminderType.FoodInput:
                return Notification(
                    id: notificationType.rawValue,
                    title: "Update Entry",
                    body: "It's time to add your food"
                )
        }
    }

    private static func requestPermission(dateComponents: DateComponents, notification: Notification) {
        
        Self.center.requestAuthorization(
            options: [.alert, .badge, .alert],
            completionHandler: { (granted, error) in

                if granted == true && error == nil {
                    Self.scheduleNotification(dateComponents: dateComponents, notification: notification)
                }
            }
        )
    }
    
    private static func scheduleNotification(dateComponents: DateComponents, notification: Notification) {
        
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.body
        content.badge = 1

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
        
        Self.center.add(request) { error in error.map { print("Notification error: \($0)") } }
    }
    
    private static func schedule(dateComponents: DateComponents, notification: Notification) {

        Self.center.getNotificationSettings { settings in

            switch settings.authorizationStatus {
                case .notDetermined:
                    Self.requestPermission(dateComponents: dateComponents, notification: notification)
                case .authorized, .provisional:
                    Self.scheduleNotification(dateComponents: dateComponents, notification: notification)
                default:
                    break
            }
        }
    }

    public static func scheduleReocurring(date: Date, notification: Notification) {
        
        let components = Calendar.current.dateComponents([ .hour, .minute ], from: date)
        
        Self.scheduleNotification(dateComponents: components, notification: notification)
    }

    public static func updateNotificationTimes(weightTime: Date, foodTime: Date) {
        
        Self.center.removeAllPendingNotificationRequests()
        
        Self.scheduleReocurring(
            date: weightTime,
            notification: Self.getNotification(notificationType: ReminderType.WeightInput)
        )
        
        Self.scheduleReocurring(
            date: foodTime,
            notification: Self.getNotification(notificationType: ReminderType.FoodInput)
        )
    }
}

