//
//  RecordStore.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 22.08.22.
//

import SwiftUI

class RecordStore: ObservableObject {
  @Published var name: String
  
  init(name: String = "") {
    self.name = name
  }
}
