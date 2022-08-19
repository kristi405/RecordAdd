//
//  RecordingsList.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 17.08.22.
//

import SwiftUI

struct RecordingsList: View {
  @ObservedObject var recordStore: RecordStore
  
  var body: some View {
    NavigationView {
      VStack {
        ScrollView {
          List {
            ForEach(recordStore.recordings, id: \.createdAt) { recording in
              RecordingRow(audioURL: recording.fileURL)
            }
            .onDelete(perform: delete)
          }
        }
        HStack {
          Button {
            print("1111")
          } label: {
            Circle()
              .frame(width: 80, height: 80, alignment: .trailing)
              .background(Color.blue)
          }
        }
        .padding(.vertical, 15)
      }
      .navigationBarTitle("My reminders")
      .navigationBarItems(trailing: EditButton())
    }
  }
  
  var plusButtonView: some View {
    Button {
      print("111")
    } label: {
      R.image.plus.image
    }
    .frame(width: 35, height: 35, alignment: .trailing)
    .padding(.trailing, 20)
  }
  
  func delete(at offsets: IndexSet) {
    var urlsToDelete = [URL]()
    for index in offsets {
      urlsToDelete.append(recordStore.recordings[index].fileURL)
    }
    
    recordStore.deleteRecording(urlsToDelete: urlsToDelete)
  }
}

struct RecordingRow: View {
  var audioURL: URL
  @ObservedObject var audioPlayer = AudioPlayerStore()
  
  var body: some View {
    HStack {
      Text("\(audioURL.lastPathComponent)")
      Spacer()
      if audioPlayer.isPlaying == false {
        Button(action: {
          self.audioPlayer.startPlayback(audio: audioURL)
        }) {
          Image(systemName: "play.circle")
            .imageScale(.large)
        }
      } else {
        Button(action: {
          self.audioPlayer.stopPlayback()
        }) {
          Image(systemName: "stop.fill")
            .imageScale(.large)
        }
      }
    }
  }
}

struct RecordingsList_Previews: PreviewProvider {
  static var previews: some View {
    RecordingsList(recordStore: RecordStore())
  }
}
