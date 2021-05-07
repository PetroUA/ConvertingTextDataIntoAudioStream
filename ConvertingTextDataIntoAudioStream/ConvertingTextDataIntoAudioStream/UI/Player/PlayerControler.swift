//
//  PlayerControler.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 27.04.2021.
//

import UIKit

class PlayerControler: UIViewController {
    
    @IBOutlet weak var playAndPauseButton: UIBarButtonItem!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    var isPlayMode = true
    
    lazy var synthesizer: SpeechSynthesizer = {
        let synthesizer = SpeechSynthesizer()
        synthesizer.delegate = self
        return synthesizer
    } ()
    
    let sentenceBySentenceReader = SentenceBySentenceReader(allTextData: TXTParser().getTextData())
    
    func speakNextSentenceIfAvailable() {
        if let sentence = sentenceBySentenceReader.getNextSentence() {
            synthesizer.stopSpeaking()
            synthesizer.speak(textToSpeakText: sentence)
        }
    }
    
    func speakPreviousSentenceIfAvailable() {
        if let sentence = sentenceBySentenceReader.getPreviousSentence() {
            synthesizer.stopSpeaking()
            synthesizer.speak(textToSpeakText: sentence)
        }
    }
    
    @IBAction func nextSentenceButtonTapped(_ sender: Any) {
        speakNextSentenceIfAvailable()
    }
    
    @IBAction func previousSentenceButtonTapped(_ sender: Any) {
        speakPreviousSentenceIfAvailable()
    }
    
    @IBAction func PlayAndPauseButtonTapped(_ sender: Any) {
        if isPlayMode {
            playAndPauseButton.image = UIImage(systemName: "play.fill")
            synthesizer.pauseSpeaking()
            isPlayMode = false
        } else {
            playAndPauseButton.image = UIImage(systemName: "pause.fill")
            synthesizer.continueSpeaking()
            isPlayMode = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parser = TXTParser()
        self.label.text = parser.getTextData()
        speakNextSentenceIfAvailable()
    }
}

extension PlayerControler: SpeechSynthesizerDelegate {
    func speechSynthesizerDidFinish() {
        speakNextSentenceIfAvailable()
    }
}
