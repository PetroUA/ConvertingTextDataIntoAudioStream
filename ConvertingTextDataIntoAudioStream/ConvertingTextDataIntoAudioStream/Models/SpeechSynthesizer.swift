//
//  SpeechSynthesizer.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 28.04.2021.
//

import UIKit
import AVFoundation

class SpeechSynthesizer: NSObject {
    
    let synth = AVSpeechSynthesizer()
    
    func startTextToSpeakSynthesis(rate: Float, pitchMultiplier: Float, postUtteranceDelay:Double, volume:Float, textToSpeakText:String, language:String){
        
        let utterance = AVSpeechUtterance(string: textToSpeakText)
        
        utterance.rate = rate
        utterance.pitchMultiplier = pitchMultiplier
        utterance.postUtteranceDelay = postUtteranceDelay
        utterance.volume = volume

        let voice = AVSpeechSynthesisVoice(language: language)
        
        utterance.voice = voice
        
        synth.speak(utterance)
        
    }
    
    func continueSpeaking(){
        synth.continueSpeaking()
    }
    func pauseSpeaking(){
        synth.pauseSpeaking(at: AVSpeechBoundary.word)
    }
}
