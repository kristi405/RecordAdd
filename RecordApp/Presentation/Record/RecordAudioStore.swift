//
//  RecordAudioStore.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 17.08.22.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class RecordAudioStore: NSObject, ObservableObject {
  @Published var textInputStore = TextInputStore()
  @Published var date = Date()
  
  // MARK: Constants
  private var audioRecorder: AVAudioRecorder!
  let objectWillChange = PassthroughSubject<RecordAudioStore, Never>()
  var recordings = [Recording]()
  var reminders = [Reminder]()
  var recording = false {
    didSet {
      objectWillChange.send(self)
    }
  }
  
  override init() {
    super.init()
    
//    fetchRecordings()
  }
  
  func startRecording() {
    let recordingSession = AVAudioSession.sharedInstance()
    do {
      try recordingSession.setCategory(.playAndRecord, mode: .default)
      try recordingSession.setActive(true)
    } catch {
      print("Failed to set up recording session")
    }
    let audioFilename: URL
    let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    if textInputStore.enteredText.isEmpty {
      audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
    } else {
      audioFilename = documentPath.appendingPathComponent(textInputStore.enteredText)
    }

    let settings = [
      AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
      AVSampleRateKey: 12000,
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    do {
      audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
      audioRecorder.record()
      recording = true
    } catch {
      print("Could not start recording")
    }
  }
  
  func stopRecording() {
    audioRecorder.stop()
    recording = false
  }
  
  func fetchRecordings() {
    recordings.removeAll()
    
    let fileManager = FileManager.default
    let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
    for audio in directoryContents {
      let recording = Recording(fileURL: audio)
      recordings.append(recording)
    }
    recordings.sort(by: { $0.createdAt > $1.createdAt })
    objectWillChange.send(self)
  }
  
  func deleteRecording(urlsToDelete: [URL]) {
    for url in urlsToDelete {
      do {
        try FileManager.default.removeItem(at: url)
      } catch {
        print("File could not be deleted!")
      }
    }
    objectWillChange.send(self)
  }
}
