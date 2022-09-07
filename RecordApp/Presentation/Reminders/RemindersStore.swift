//
//  RemindersStore.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 7.09.22.
//

import SwiftUI
import Rswift

enum NotificationAction: String {
  case dismiss
  case reminder
}

enum NotificationCategory: String {
  case general
}

final class RemindersStore: ObservableObject {
  @Published var textInputStore = TextInputStore()
  @Published var isNiewBattonPressed: Bool = false
  @Published var recordAudioStore = RecordAudioStore()
  @Published var recordStore = RecordStore()
  
  init() {
    pushNotifications()
  }
  
  func plusButtonDidTapped() {
    isNiewBattonPressed = true
    recordAudioStore.textInputStore.enteredText.removeAll()
    recordAudioStore.date = Date()
  }
  
  func pushNotifications() {
    let center = UNUserNotificationCenter.current()
    
    let content = UNMutableNotificationContent()
    content.title = "Hello"
    content.sound = UNNotificationSound.default
    content.categoryIdentifier = NotificationCategory.general.rawValue
    
    if let url = Bundle.main.url(forResource: FileResource(bundle: R.image.deks.bundle, name: "deks", pathExtension: "png")) {
      if let attachments = try? UNNotificationAttachment(identifier: "images", url: url) {
        content.attachments = [attachments]
      }
    }
    recordAudioStore.fetchRecordings()
    let calendar = Calendar.current
    var dateComponents = DateComponents()
    for reminder in recordAudioStore.reminders {
      dateComponents = calendar.dateComponents([.month, .day, .year, .hour, .minute], from: reminder.dateOfReminder)
    }
    
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    let dismiss = UNNotificationAction(identifier: NotificationAction.dismiss.rawValue, title: "Dismiss", options: [])
    let reminder = UNNotificationAction(identifier: NotificationAction.reminder.rawValue, title: "Reminder", options: [])
    
    let generalCategory = UNNotificationCategory(identifier: NotificationCategory.general.rawValue, actions: [dismiss, reminder], intentIdentifiers: [])
    
    center.setNotificationCategories([generalCategory])
    
    let request = UNNotificationRequest(identifier: "Id", content: content, trigger: trigger)
    center.add(request)
  }
}
