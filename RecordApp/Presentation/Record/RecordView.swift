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
import RealmSwift

struct RecordView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @ObservedObject var recordAudioStore: RecordAudioStore
  @ObservedObject var recordStore: RecordStore
  @State private var editing: Bool = false
  
  var body: some View {
    VStack {
      navigation
      VStack(spacing: 40) {
        name
          .padding(.top, 15)
        chooseDate
        chooseTime
        Spacer()
        recordButton
      }
    }
    .navigationBarHidden(true)
    .padding(.horizontal, 25)
    .ignoresSafeArea(.keyboard)
    .hideKeyboardWhenTappedAround()
  }
  
  @ViewBuilder
  var navigation: some View  {
    ZStack {
      HStack(alignment: .top) {
        CustomBackButton {
          presentationMode.wrappedValue.dismiss()
        }
        Spacer()
        CustomTrallingButton(title: "Save", action: {
          recordAudioStore.fetchRecordings()
          presentationMode.wrappedValue.dismiss()
        })
        .padding(.trailing, 5)
      }
      Text("New reminder")
        .foregroundColor(.black)
        .font(.system(size: 20, weight: .bold))
        .frame(maxWidth: UIScreen.main.bounds.width / 2)
    }
    .frame(maxWidth: .infinity, maxHeight: 35)
    .background(Color.white)
  }
  
  var name: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("Name")
      TextInputView(placeholder: "Enter the name", store: recordAudioStore.textInputStore)
    }
  }
  
  var chooseDate: some View {
    DatePicker(
      "Choose the date",
      selection: $recordAudioStore.date,
      displayedComponents: [.date]
    )
    .datePickerStyle(.compact)
  }
  
  var chooseTime: some View {
    VStack {
      DatePicker(
        "Choose the time",
        selection: $recordAudioStore.date,
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
               recordStore: RecordStore())
  }
}
