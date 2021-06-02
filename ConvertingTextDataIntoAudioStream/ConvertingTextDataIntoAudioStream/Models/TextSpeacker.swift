//
//  TextSpeacker.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 30.05.2021.
//

import Foundation
import AVFoundation

protocol TextSpeackerDelegate: AnyObject {
    func textSpeackerDidFinishSpeaking()
    func textSpeackerDidStartSpeaking()
    func textSpeackerDidPauseSpeaking()
    func textSpeackerDidContinueSpeaking()
}

class TextSpeacker: NSObject{
    
    lazy var synthesizer: AVSpeechSynthesizer = {
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.delegate = self
        return synthesizer
    } ()
    lazy var settings = Settings()
    
    weak var delegate: TextSpeackerDelegate?
    
    var isPaused: Bool {
        synthesizer.isPaused
    }
    
    override init() {
        super.init()
        
        setupAudioSession()
    }
    
    public func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = (settings.getRateValue() as NSString).floatValue
        utterance.pitchMultiplier = (settings.getPitchMultiplierValue() as NSString).floatValue
        utterance.postUtteranceDelay = TimeInterval((settings.getPostUtteranceDelayValue() as NSString).floatValue)
        utterance.volume = (settings.getVolumeValue() as NSString).floatValue

        let voice = AVSpeechSynthesisVoice(language: settings.getLanguageValue())
        
        utterance.voice = voice
        synthesizer.speak(utterance)
    }
    
    public func pause() {
        synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    public func `continue`() {
        synthesizer.continueSpeaking()
    }
    
    public func stop() {
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
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
}

extension TextSpeacker: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        delegate?.textSpeackerDidStartSpeaking()
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        delegate?.textSpeackerDidFinishSpeaking()
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        delegate?.textSpeackerDidPauseSpeaking()
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        delegate?.textSpeackerDidContinueSpeaking()
    }
}
