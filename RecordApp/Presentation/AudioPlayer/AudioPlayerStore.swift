//
//  AudioPlayerStore.swift
//  RecordApp
//
//  Created by Kristina Makarevich on 17.08.22.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioPlayerStore: NSObject, ObservableObject, AVAudioPlayerDelegate {
  let objectWillChange = PassthroughSubject<AudioPlayerStore, Never>()
  var audioPlayer: AVAudioPlayer!
  var isPlaying = false {
    didSet {
      objectWillChange.send(self)
    }
  }
  
  func startPlayback(audio: URL) {
    let playbackSession = AVAudioSession.sharedInstance()
    do {
      try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
    } catch {
      print("Playing over the device's speakers failed")
    }
    
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: audio)
      audioPlayer.play()
      audioPlayer.delegate = self
      isPlaying = true
    } catch {
      print("Playback failed.")
    }
  }
  
  func stopPlayback() {
    audioPlayer.stop()
    isPlaying = false
  }
}

extension AudioPlayerStore {
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
          if flag {
              isPlaying = false
          }
      }
}
