//
//  RemindersView.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 19.08.22.
//

import SwiftUI

struct RemindersView: View {
  @ObservedObject var remindersStore: RemindersStore
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        navigation
        Spacer(minLength: 15)
        RecordingsList(recordStore: remindersStore.recordAudioStore)
        HStack {
          Spacer()
          plusButtonView
        }
        NavigationLink("", isActive: $remindersStore.isNiewBattonPressed) {
          RecordView(recordAudioStore: remindersStore.recordAudioStore,
                     recordStore: remindersStore.recordStore)
        }
      }
      .navigationBarHidden(true)
    }
  }
  
  
  @ViewBuilder
  var navigation: some View  {
    ZStack {
      HStack(alignment: .top) {
        Spacer()
        EditButton()
        .padding(.trailing, 30)
      }
      Text("My reminders")
        .foregroundColor(.black)
        .font(.system(size: 20, weight: .bold))
        .frame(maxWidth: UIScreen.main.bounds.width / 2)
    }
    .frame(maxWidth: .infinity, maxHeight: 35)
    .background(Color.white)
  }
  
  var plusButtonView: some View {
    Button {
      remindersStore.plusButtonDidTapped()
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
