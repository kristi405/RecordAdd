//
//  TextInputStore.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 22.08.22.
//

import SwiftUI
import Combine


final class TextInputStore: ObservableObject {
  @Published var enteredText: String
  
  init(
    enteredText: String = ""
  ) {
    self.enteredText = enteredText
  }
}

