//
//  ExtrasController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 27.04.2021.
//

import UIKit

class ExtrasController: UITableViewController {
    
    let settings = Settings()
    
    let defaultsSettings = UserDefaults.standard
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var rateSlider: UISlider!
    
    @IBOutlet weak var pitchSlider: UISlider!
    
    @IBOutlet weak var pausesSlider: UISlider!
    
    @IBOutlet private weak var languageRateLabel: UILabel!
    var dataLanguage: String = "Language"
    
    @IBOutlet private weak var volumeLabel: UILabel!
    var dataVolume: String = "Speech volume"
    
    @IBOutlet private weak var rateLabel: UILabel!
    var dataRate: String = "Speech rate"
    
    @IBOutlet private weak var pitchMultiplierLabel: UILabel!
    var dataPitchMultiplier: String = "Baseline pitch"
    
    @IBOutlet private weak var postUtteranceDelayLabel: UILabel!
    var dataPostUtteranceDelay: String = "Pauses after speaking"
    
    @IBOutlet weak var textSize: UILabel!
    var datatextSize: String = "Text size"
    
    @IBOutlet weak var textColor: UILabel!
    var datatextColor: String = "Text color"
    
    @IBOutlet weak var backgroundColor: UILabel!
    var databackgroundColor: String = "Background color"
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        volumeSlider.value = settings.getVolumeValue()
        pausesSlider.value = Float(settings.getPostUtteranceDelayValue())
        rateSlider.value = settings.getRateValue()
        pitchSlider.value = settings.getPitchMultiplierValue()
        
        
        rateLabel.text = dataRate
        languageRateLabel.text = dataLanguage
        pitchMultiplierLabel.text = dataPitchMultiplier
        postUtteranceDelayLabel.text = dataPostUtteranceDelay
        volumeLabel.text = dataVolume
        textSize.text = datatextSize
        textColor.text = datatextColor
        backgroundColor.text = databackgroundColor
    }
}
