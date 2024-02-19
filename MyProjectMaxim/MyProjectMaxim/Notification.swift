//
//  Notification.swift
//  MyProjectMaxim
//
//  Created by Максим on 19.02.2024.
//

import Foundation
import UserNotifications

class NotificationClass {
    func dispatchNotification(indentifier: String, title: String, body: String, timeIntervalSec: Double ) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervalSec, repeats: true)

        let currentHour = Calendar.current.component(.hour, from: Date())
        let currentMinute = Calendar.current.component(.minute, from: Date())
        let totalCurrentMinutes = (currentHour*60) + currentMinute
        
        let keysTimeGetUpDate = formatString(dateString: Keys.timeGetUp, dateFormat: "HH:mm")
        let keysTimeGoSleepDate = formatString(dateString: Keys.timeGoSleep, dateFormat: "HH:mm")
        
        let hourGetUp = Calendar.current.component(.hour, from: keysTimeGetUpDate)
        let minuteGetUp = Calendar.current.component(.minute, from: keysTimeGetUpDate)
        let totalMinutesGetUp = (hourGetUp*60) + minuteGetUp
        
        let hourGoSleep = Calendar.current.component(.hour, from: keysTimeGoSleepDate)
        let minuteGoSleep = Calendar.current.component(.minute, from: keysTimeGoSleepDate)
        let totalMinutesGoSleep = (hourGoSleep*60) + minuteGoSleep
        
        if totalCurrentMinutes > totalMinutesGetUp && totalCurrentMinutes < totalMinutesGoSleep {
            let request = UNNotificationRequest(identifier: indentifier, content: content, trigger: trigger)
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [indentifier])
            notificationCenter.add(request)
       }
    }
    
    func formatString(dateString: String, dateFormat: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone =  .current
        return formatter.date(from: dateString) ?? Date()
    }
}

class WaterNotification : NotificationClass {
    static var timerWater : Timer? = nil
    var waterNotificationID = 0
    
    @objc func checkForPermissionWater() {
        waterNotificationID += 1
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { setting in
            switch setting.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        if Keys.minutesToDrink != nil {
                            self.dispatchNotification(indentifier: "message-water",
                                                      title: "Пора попить воды!",
                                                      body: "Заходи в приложение и отмечай!",
                                                      timeIntervalSec: Double(Keys.minutesToDrink)*60)
                        }
                    }
                }
            case .denied:
                return
            case .authorized:
                if Keys.minutesToDrink != nil {
                    self.dispatchNotification(indentifier: "message-water",
                                              title: "Пора попить воды!",
                                              body: "Заходи в приложение и отмечай!",
                                              timeIntervalSec: Double(Keys.minutesToDrink)*60)
                }
            default:
                return
            }
        }
    }
}

class FoodNotification : NotificationClass {
    static var timerFood : Timer? = nil
    var foodNotificationID = 0
    
    @objc func checkForPermissionFood() {
        foodNotificationID += 1
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { setting in
            switch setting.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        if Keys.minutesToEat != nil {
                            self.dispatchNotification(indentifier: "message-food",
                                                      title: "Пора поесть!",
                                                      body: "Заходи в приложение и отмечай!",
                                                      timeIntervalSec: Double(Keys.minutesToEat)*60)
                        }
                    }
                }
            case .denied:
                return
            case .authorized:
                if Keys.minutesToEat != nil {
                    self.dispatchNotification(indentifier: "message-food",
                                              title: "Пора поесть!",
                                              body: "Заходи в приложение и отмечай!",
                                              timeIntervalSec: Double(Keys.minutesToEat)*60)
                }
            default:
                return
            }
        }
    }
}
