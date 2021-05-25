//
//  SpeechSynthesizer.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 28.04.2021.
//

import UIKit
import AVFoundation
import MediaPlayer

protocol SpeechSynthesizerDelegate: AnyObject {
    func speechSynthesizerDidFinish()
}

class SpeechSynthesizer: NSObject {
    let synth = AVSpeechSynthesizer()
    weak var delegate: SpeechSynthesizerDelegate?
    let settings = Settings()
    
    var rate: Float
    var pitchMultiplier: Float
    var postUtteranceDelay: Double
    var volume: Float
    let language = "en-GB"
    
    override init() {
        self.rate = settings.getRateValue()
        self.pitchMultiplier = settings.getPitchMultiplierValue()
        self.postUtteranceDelay = settings.getPostUtteranceDelayValue()
        self.volume = settings.getVolumeValue()
        //self.language = settings.getLanguageValue()
        
        super.init()
        synth.delegate = self
        setupAudioSession()
    }
    
    deinit {
        unwindeCommandCenter()
    }
    
    func speak(textToSpeakText: String) {
        if synth.isSpeaking {
            stopSpeaking()
        }
        
        let utterance = AVSpeechUtterance(string: textToSpeakText)
        
        utterance.rate = rate
        utterance.pitchMultiplier = pitchMultiplier
        utterance.postUtteranceDelay = postUtteranceDelay
        utterance.volume = volume
        
        let voice = AVSpeechSynthesisVoice(language: language)
        
        utterance.voice = voice
        synth.speak(utterance)
        setupCommandCenter()
    }
    
    func stopSpeaking() {
        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
    }

    func continueSpeaking() {
        synth.continueSpeaking()
    }

    func pauseSpeaking() {
        synth.pauseSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    private func setupAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback)
            try session.setActive(true)
        }
        catch {
            print("setupAudioSession error=\(error)")
        }
    }
    
    private func setupCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: "Something"]

        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        //commandCenter.nextTrackCommand.isEnabled = true
        //commandCenter.previousTrackCommand.isEnabled = true
        
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.continueSpeaking()
            return.success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.pauseSpeaking()
            return.success
        }/*
        commandCenter.nextTrackCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.continueSpeaking()
            return.success
        }
        commandCenter.previousTrackCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.continueSpeaking()
            return.success
        }*/
    }
    
    private func unwindeCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.removeTarget(self)
        commandCenter.pauseCommand.removeTarget(self)
    }
}

extension SpeechSynthesizer: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("all done")
        DispatchQueue.main.async {
            self.delegate?.speechSynthesizerDidFinish()
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("didStart")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        print("didPause")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        print("didContinue")
    }
}
