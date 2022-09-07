//
//  CustomBackButton.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 7.09.22.
//

import SwiftUI

struct CustomBackButton: View {
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Image(systemName: "chevron.left")
        .frame(width: 25, height: 25)
        .foregroundColor(.blue)
        .font(.system(size: 18, weight: .medium, design: .default))
    }
    .frame(width: 25, height: 25)
  }
}

struct CustomTrallingButton: View {
  let title: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .frame(width: 40, height: 30)
        .foregroundColor(.blue)
        .font(.system(size: 18, weight: .medium, design: .default))
    }
    .frame(width: 40, height: 30)
  }
}
