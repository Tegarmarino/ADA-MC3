//
//  Notification.swift
//  Nocjurnal-ADA-MC3
//
//  Created by Nicholas Dylan Lienardi on 23/07/24.
//

import SwiftUI
import UserNotifications

struct Notification: View {
    @State private var submitState = ButtonState.idle
    @State private var selectedTime = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            ButtonRegular("Req Perms", state: $submitState){
                requestNotificationPermissions()
            }
            
            DatePicker("Select time for daily notification", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
            
            ButtonRegular("Set Daily Reminder", state: $submitState){
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: selectedTime)
                let minute = calendar.component(.minute, from: selectedTime)
                scheduleDailyNotification(title: "Daily Reminder", body: "This is your daily reminder!", hour: hour, minute: minute)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 72, trailing: 24))
    }
    
    
    
}
func scheduleDailyNotification(title: String, body: String, hour: Int, minute: Int) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = .default
    
    var dateComponents = DateComponents()
    dateComponents.hour = hour
    dateComponents.minute = minute
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    let center = UNUserNotificationCenter.current()
    center.add(request) { error in
        if let error = error {
            print("Error scheduling notification: \(error.localizedDescription)")
        } else {
            print("Daily notification scheduled at \(hour):\(minute)")
        }
    }
}


func requestNotificationPermissions() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if let error = error {
            print("Error requesting notifications permission: \(error.localizedDescription)")
        } else {
            print("Notifications permission granted: \(granted)")
        }
    }
}

#Preview {
    Notification()
}
