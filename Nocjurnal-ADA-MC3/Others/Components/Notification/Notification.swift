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
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding var isDone: Bool

    var body: some View {
        VStack(spacing: 20) {
            
            Text("Set Daily Reminder")
                .font(Font.format.textHeadlineOne)
                .padding(.top, 24)

            DatePicker("Select time for daily notification", selection: $selectedTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
            
            ButtonRegular("Done", state: $submitState){
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: selectedTime)
                let minute = calendar.component(.minute, from: selectedTime)
                setReminderIfNeeded(title: "Daily Reminder", body: "This is your daily reminder to do your daily journaling session! :D", hour: hour, minute: minute)

            }
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 72, trailing: 24))
        .alert(isPresented: $showAlert) {
            Alert(
               title: Text("Reminder Status"),
               message: Text(alertMessage),
               dismissButton: .default(Text("OK")) {
                   isDone = true
               }
           )
        }
    }
    
    func setReminderIfNeeded(title: String, body: String, hour: Int, minute: Int) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                // Permission already granted, schedule the notification
                scheduleDailyNotification(title: title, body: body, hour: hour, minute: minute)
            } else {
                // Request permission first
                requestNotificationPermissions { granted in
                    if granted {
                        // Permission granted, schedule the notification
                        scheduleDailyNotification(title: title, body: body, hour: hour, minute: minute)
                    } else {
                        alertMessage = "Permission not granted, cannot schedule notification"
                        showAlert = true
                    }
                }
            }
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
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "Error scheduling notification: \(error.localizedDescription)"
                } else {
                    let formattedHour = String(format: "%02d", hour)
                    let formattedMinute = String(format: "%02d", minute)
                    alertMessage = "Daily notification scheduled at \(formattedHour):\(formattedMinute)"                }
                showAlert = true
            }
        }
    }
    
    
    func requestNotificationPermissions(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error requesting notifications permission: \(error.localizedDescription)")
                    completion(false)
                } else {
                    print("Notifications permission granted: \(granted)")
                    completion(granted)
                }
            }
        }
    }
}



#Preview {
    Notification(isDone: .constant(false))
}
