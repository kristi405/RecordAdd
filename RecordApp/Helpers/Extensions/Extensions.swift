//
//  Extensions.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 17.08.22.
//

import SwiftUI

extension Date {
  func toString(dateFormat format: String ) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
}

extension Collection {
  func enumeratedArray() -> [(offset: Int, element: Self.Element)] {
    Array(enumerated())
  }
}
