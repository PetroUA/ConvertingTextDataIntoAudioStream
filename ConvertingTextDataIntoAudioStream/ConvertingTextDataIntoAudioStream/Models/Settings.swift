//
//  Settings.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 14.05.2021.
//

import Foundation

class Settings {
    let defaultsSettings = UserDefaults.standard
    
    func getVolumeValue() -> Float {
        return defaultsSettings.float(forKey: "volume")
    }
    func getPostUtteranceDelayValue() -> Double {
        return defaultsSettings.double(forKey: "postUtteranceDelay")
    }
    func getRateValue() -> Float {
        return defaultsSettings.float(forKey: "rate")
    }
    func getPitchMultiplierValue() -> Float {
        return defaultsSettings.float(forKey: "pitchMultiplier")
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
    
}

