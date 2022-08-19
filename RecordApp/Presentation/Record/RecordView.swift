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
  @ObservedObject var recordStore: RecordStore
  
  var body: some View {
    NavigationView {
      VStack {
//        RecordingsList(recordStore: recordStore)
        HStack(alignment: .center, spacing: 30) {
          if recordStore.recording == false {
            Button(action: {self.recordStore.startRecording()}) {
              Image(systemName: "record.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .foregroundColor(.red)
                .padding(.bottom, 40)
              }
          } else {
            Button(action: {self.recordStore.stopRecording()}) {
              Image(systemName: "stop.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
                .foregroundColor(.red)
                .padding(.bottom, 40)
            }
          }
        }
      }
      
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    RecordView(recordStore: RecordStore())
  }
}
