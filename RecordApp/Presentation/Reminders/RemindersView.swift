//
//  RemindersView.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 19.08.22.
//

import SwiftUI

struct RemindersView: View {
  @ObservedObject var recordAudioStore: RecordAudioStore
  @ObservedObject var recordStore: RecordStore
  @ObservedObject var textInputStore: TextInputStore
  @State var isNiewBattonPressed: Bool = false
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        Spacer(minLength: 15)
        RecordingsList(recordStore: recordAudioStore)
        HStack {
          Spacer()
          plusButtonView
        }
        NavigationLink("", isActive: $isNiewBattonPressed) {
          RecordView(recordAudioStore: recordAudioStore,
                     recordStore: recordStore,
                     textInputStore: TextInputStore())
        }
      }
      .navigationBarTitle("My reminders")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarItems(trailing: EditButton()) 
    }
  }
  
  var plusButtonView: some View {
    Button {
      isNiewBattonPressed = true
    } label: {
      ZStack {
      RoundedRectangle(cornerRadius: 50)
          .frame(width: 50, height: 50)
        Image(systemName: "plus")
          .frame(width: 20, height: 20)
          .foregroundColor(.white)
          .font(.system(size: 20, weight: .semibold, design: .default))
      }
    }
    .frame(width: 70, height: 70)
    .padding(.trailing, 30)
  }
}
