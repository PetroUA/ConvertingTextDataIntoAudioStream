//
//  ExtrasViewController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 27.04.2021.
//

import UIKit

class ExtrasViewController: UITableViewController {
    
    let settings = Settings()
    let defaultsSettings = UserDefaults.standard
    
    let supportedLanguages = ["ar-SA", "cs-CZ", "da-DK", "de-DE", "el-GR" ,"en-AU", "en-GB", "en-IE", "en-IN", "en-US" ,"en-ZA", "es-ES", "es-MX", "fi-FI", "fr-CA" ,"fr-FR", "he-IL", "hi-IN", "hu-HU", "id-ID" ,"it-IT", "ja-JP", "ko-KR", "nl-NL", "no-NO" ,"pl-PL", "pt-BR", "pt-PT", "ro-RO", "ru-RU" ,"sk-SK", "sv-SE", "th-TH", "tr-TR", "zh-CN" ,"zh-HK", "zh-TW", "en-US"]
    
    let supportedTextSizes = ["1", "2"]
    
    //MARK: - Speech componets
    
    fileprivate let pickerView = UIPickerView()
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var rateSlider: UISlider!
    
    @IBOutlet weak var pitchSlider: UISlider!
    
    @IBOutlet weak var pausesSlider: UISlider!
    
    @IBOutlet weak var languageTextField: UITextField!
    
    var languagePickerController: SettingsPickerViewController!
    
    @IBOutlet weak var textSizeTextField: UITextField!
    
    var textSizePickerController: SettingsPickerViewController!
    
    @IBAction func volumeChanged(_ sender: UISlider) {
        settings.setVolumeValue(curentValue: sender.value)
    }
    
    @IBAction func rateChanged(_ sender: UISlider) {
        settings.setRateValue(curentValue: sender.value)
    }
    
    @IBAction func pitchChanged(_ sender: UISlider) {
        settings.setPitchMultiplierValue(curentValue: sender.value)
    }
    
    @IBAction func pausesChenged(_ sender: UISlider) {
        settings.setPostUtteranceDelayValue(curentValue: sender.value)
    }

    //MARK: - About componets
    @IBAction func AppInformationButtonTapped(_ sender: Any) {

        let alert = UIAlertController(title: "App information", message: "This is app converting text data into audio stream.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagePickerController = SettingsPickerViewController(currentValue: settings.getLanguageValue(),
                                                                data: supportedLanguages,
                                                                textField: languageTextField,
                                                                onValueSelected: { [weak self] (newValue) in
                                                                    self?.settings.setLanguageValue(curentValue: newValue)
                                                                })
        
        textSizePickerController = SettingsPickerViewController(currentValue: settings.getTextSize(),// why start always equal 0
        data: supportedTextSizes,
        textField: textSizeTextField,
        onValueSelected: { [weak self] (newValue) in
            self?.settings.setTextSize(curentValue: newValue)
        })
        
        volumeSlider.value = settings.getVolumeValue()
        pausesSlider.value = Float(settings.getPostUtteranceDelayValue())
        rateSlider.value = settings.getRateValue()
        pitchSlider.value = settings.getPitchMultiplierValue()
        
    }
}


