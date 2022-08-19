//
//  Helper.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 17.08.22.
//

import SwiftUI

func getCreationDate(for file: URL) -> Date {
  if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
     let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
    return creationDate
  } else {
    return Date()
  }
}
