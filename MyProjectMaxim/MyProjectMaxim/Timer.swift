//
//  Timer.swift
//  MyProjectMaxim
//
//  Created by Максим on 18.02.2024.
//

import Foundation
import UserNotifications

public var timerFood: Timer = Timer()
public var timerWater: Timer = Timer()

class Timer {
    var foodNotificationID = 1
    var waterNotificationID = 1
    
    @objc func updateByTimerFood() {
        foodNotificationID += 1
        var foodNotificationIDString = "food-notification-\(foodNotificationID)"
        checkForPermissionFood(with: foodNotificationIDString)
    }
    
    @objc func updateByTimerWater() {
        waterNotificationID += 1
        var waterNotificationIDString = "water-notification-\(waterNotificationID)"
        checkForPermissionWater(with: waterNotificationIDString)
    }
    
    func checkForPermissionFood(with indentifier: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { setting in
            switch setting.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        if Keys.minutesToEat != nil {
                            self.dispatchNotification(indentifier: indentifier,
                                                      title: "Пора поесть!",
                                                      body: "Заходи в приложение и отмечай!",
                                                      timeIntervalSec: 1)
                        }
                    }
                }
            case .denied:
                return
            case .authorized:
                if Keys.minutesToEat != nil {
                    self.dispatchNotification(indentifier: indentifier,
                                              title: "Пора поесть!",
                                              body: "Заходи в приложение и отмечай!",
                                              timeIntervalSec: 1)
                }
            default:
                return
            }
        }
    }
    
    func checkForPermissionWater(with indentifier: String) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { setting in
            switch setting.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        if Keys.minutesToDrink != nil {
                            self.dispatchNotification(indentifier: indentifier,
                                                      title: "Пора попить воды!",
                                                      body: "Заходи в приложение и отмечай!",
                                                      timeIntervalSec: 1)
                        }
                    }
                }
            case .denied:
                return
            case .authorized:
                if Keys.minutesToDrink != nil {
                    self.dispatchNotification(indentifier: indentifier,
                                              title: "Пора попить воды!",
                                              body: "Заходи в приложение и отмечай!",
                                              timeIntervalSec: 1)
                }
            default:
                return
            }
        }
    }
    
    func dispatchNotification(indentifier: String, title: String, body: String, timeIntervalSec: Double) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeIntervalSec, repeats: false)
        
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
            let request = UNNotificationRequest(identifier: "\(indentifier)", content: content, trigger: trigger)
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(indentifier)"])
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
