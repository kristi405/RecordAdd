//
//  RealmManager.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 7.09.22.
//
//
//import SwiftUI
//import RealmSwift
//
//class RealmManager: ObservableObject {
//  private(set) var localRealm: Realm?
//  @Published var recordings: [Recording] = []
//
//  init() {
//    openRealm()
//  }
//
//  func openRealm() {
//    do {
//      let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
//        if oldSchemaVersion > 1 {
//          // Do something, usually updating the schema's variables here
//        }
//      })
//
//      Realm.Configuration.defaultConfiguration = config
//
//      localRealm = try Realm()
//    } catch {
//      print("Error opening Realm", error)
//    }
//  }
//
//  func addRecording(recording: Recording) {
//    if let localRealm = localRealm {
//      do {
//        try localRealm.write {
//          localRealm.add(recording)
//        }
//      } catch {
//        print("Error adding course to Realm", error)
//      }
//    }
//  }
//
//  func getRecording() {
//    if let localRealm = localRealm {
//      let allRecordings = localRealm.objects(Recording.self)
//      allRecordings.forEach { recording in
//        recordings.append(recording)
//      }
//    }
//  }
//}
