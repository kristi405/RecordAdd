//
//  Recording.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 17.08.22.
//

import Foundation

struct Recording: Identifiable, Codable, Comparable {
  var id = UUID()
  let fileURL: URL
  var createdAt: Date { Calendar.current.startOfDay(for: Date()) }
  
  static func < (lhs: Recording, rhs: Recording) -> Bool {
    return lhs.createdAt < rhs.createdAt
  }
}
