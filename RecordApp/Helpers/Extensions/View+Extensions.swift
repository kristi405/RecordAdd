//
//  View+Extensions.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 22.08.22.
//

import SwiftUI

extension View {
  func hideKeyboardWhenTappedAround() -> some View {
    self.onTapGesture {
      UIApplication.shared.sendAction(
        #selector(UIResponder.resignFirstResponder),
        to: nil, from: nil, for: nil
      )
    }
  }
  
  func endEditing() {
    UIApplication.shared.endEditing()
  }
}

extension UIApplication {
  func endEditing() {
    let resign = #selector(UIResponder.resignFirstResponder)
    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
  }
}
