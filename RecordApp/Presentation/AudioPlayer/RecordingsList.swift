//
//  RecordingsList.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 17.08.22.
//

import SwiftUI

struct RecordingsList: View {
  @ObservedObject var recordStore: RecordStore
  
  var groupedByDate: [Date: [Recording]] {
    Dictionary(grouping: recordStore.recordings, by: {$0.createdAt})
  }
  
  var headers: [Date] {
    groupedByDate.map({ $0.key }).sorted()
  }
  
  var body: some View {
    List {
      ForEach(headers, id: \.self) { header in
        Section(header: Text(header, style: .date)) {
          ForEach(groupedByDate[header] ?? []) { reminder in
            RecordingRow(audioURL: reminder.fileURL)
          }
          .onDelete(perform: delete)
        }
      }
    }
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
