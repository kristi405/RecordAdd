//
//  RecordView.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 17.08.22.
//

import SwiftUI
import Foundation
import Combine
import AVFoundation

struct RecordView: View {
  @ObservedObject var recordAudioStore: RecordAudioStore
  @ObservedObject var recordStore: RecordStore
  @ObservedObject var textInputStore: TextInputStore
  @State private var date = Date()
  @State private var editing: Bool = false
  
  
  var body: some View {
    NavigationView {
      VStack(spacing: 40) {
        name
          .padding(.top, 15)
        chooseDate
        chooseTime
        Spacer()
        recordButton
      }
      .navigationTitle("New Reminder")
      .navigationBarTitleDisplayMode(.inline)
      .padding(.horizontal, 25)
      .ignoresSafeArea(.keyboard)
      .hideKeyboardWhenTappedAround()
    }
  }
  
  var name: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("Name")
      TextInputView(placeholder: "Enter the name", store: textInputStore)
    }
  }
  
  var chooseDate: some View {
    DatePicker(
      "Choose the date",
      selection: $date,
      displayedComponents: [.date]
    )
    .datePickerStyle(.compact)
  }
  
  var chooseTime: some View {
    VStack {
      DatePicker(
        "Choose the time",
        selection: $date,
        displayedComponents: .hourAndMinute
      )
    }
  }
  
  var recordButton: some View {
    HStack(alignment: .center) {
      if recordAudioStore.recording == false {
        Button(action: {self.recordAudioStore.startRecording()}) {
          Image(systemName: "record.circle")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 80, height: 80)
            .clipped()
            .foregroundColor(.red)
            .padding(.bottom, 40)
          }
      } else {
        Button(action: {self.recordAudioStore.stopRecording()}) {
          Image(systemName: "stop.circle")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 80, height: 80)
            .clipped()
            .foregroundColor(.red)
            .padding(.bottom, 40)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    RecordView(recordAudioStore: RecordAudioStore(),
               recordStore: RecordStore(),
               textInputStore: TextInputStore())
  }
}
