//
//  RecordAppApp.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 17.08.22.
//

import SwiftUI

@main
struct RecordAppApp: App {
  
  init() {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound, .badge]) { result, error in
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }
  
    var body: some Scene {
        WindowGroup {
          RemindersView(remindersStore: RemindersStore())
        }
    }
}
