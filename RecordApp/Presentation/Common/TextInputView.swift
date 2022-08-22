//
//  TextInputView.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 22.08.22.
//

import SwiftUI

struct TextInputView: View {
  @ObservedObject var store: TextInputStore

  private var placeholder: String
  @State private var editing = false
  
  init(placeholder: String, store: TextInputStore) {
    self.store = store
    self.placeholder = placeholder
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      HStack {
        TextField(
          placeholder,
          text: $store.enteredText,
          onEditingChanged: { edit in
            editing = edit
          })
        .font(.system(size: 18, weight: .regular))
      }
      .padding(.horizontal, 15)
      .background(
        RoundedRectangle(cornerRadius: 12, style: .continuous)
          .stroke(
            borderColor,
            lineWidth: 1
          )
          .frame(height: 40)
      )
      .frame(height: 40)
    }
  }

  var borderColor: Color {
    editing ? .blue : .gray
  }
}
