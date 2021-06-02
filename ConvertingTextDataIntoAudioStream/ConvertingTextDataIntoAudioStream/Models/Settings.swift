//
//  Settings.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 14.05.2021.
//

import Foundation

class Settings {
    let defaultsSettings = UserDefaults.standard
    //MARK: Audio setting
    func getVolumeValue() -> String {
        return defaultsSettings.string(forKey: "volume") ?? "0,5"
    }
    func getPostUtteranceDelayValue() -> String {
        return defaultsSettings.string(forKey: "postUtteranceDelay") ?? "0,2"
    }
    func getRateValue() -> String {
        return defaultsSettings.string(forKey: "rate") ?? "0,5"
    }
    func getPitchMultiplierValue() -> String {
        return defaultsSettings.string(forKey: "pitchMultiplier") ?? "0,5"
    }
    func getLanguageValue() -> String {
        return defaultsSettings.string(forKey: "language") ?? "en-GB"
    }
    
    func setLanguageValue(curentValue: String) {
        defaultsSettings.set(curentValue, forKey: "language")
    }
    func setVolumeValue(curentValue: Float) {
        defaultsSettings.set(curentValue, forKey: "volume")
    }
    func setPostUtteranceDelayValue(curentValue: Float) {
        defaultsSettings.set(curentValue, forKey: "postUtteranceDelay")
    }
    func setRateValue(curentValue: Float) {
        defaultsSettings.set(curentValue, forKey: "rate")
    }
    func setPitchMultiplierValue(curentValue: Float) {
        defaultsSettings.set(curentValue, forKey: "pitchMultiplier")
    }
    //MARK: Text setting
    func getTextSize() -> String {
        return defaultsSettings.string(forKey: "textSize") ?? "14"
    }
    
    func setTextSize(curentValue: String) {
        defaultsSettings.set(curentValue, forKey: "textSize")
    }
    
    func getTextColor() -> String {
        return defaultsSettings.string(forKey: "textColor") ?? "Black"
    }
    
    func setTextColor(curentValue: String) {
        defaultsSettings.set(curentValue, forKey: "textColor")
    }
    
    func getBackgroundColor() -> String {
        return defaultsSettings.string(forKey: "backgroundColor") ?? "White"
    }
    
    func setBackgroundColor(curentValue: String) {
        defaultsSettings.set(curentValue, forKey: "backgroundColor")
    }
    //MARK: Books setting
    
    func getHighlightStartRange() -> Int {
        return defaultsSettings.integer(forKey: "highlightStartRange")
    }
    
    func setHighlightStartRange(curentValue: Int) {
        defaultsSettings.set(curentValue, forKey: "highlightStartRange")
    }
    
    func getHighlightEndRange() -> Int {
        return defaultsSettings.integer(forKey: "highlightEndRange")
    }
    
    func setHighlightEndRange(curentValue: Int) {
        defaultsSettings.set(curentValue, forKey: "highlightEndRange")
    }
}

