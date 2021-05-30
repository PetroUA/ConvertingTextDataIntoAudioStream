//
//  Player.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 29.05.2021.
//
import AVFoundation
import Foundation
import MediaPlayer

class Player : NSObject {
    static let `default` = Player()
    weak var delegate: PlayerDelegate?
    
    let synth = AVSpeechSynthesizer()
    var book: Book?
    lazy var booksDataSourse = BooksDataSourse.default
    
    let settings = Settings()
    var rate: Float
    var pitchMultiplier: Float
    var postUtteranceDelay: Double
    var volume: Float
    let language: String = "en-GB"
    var seperatedSentences: [String] = []
    
    
    var isPlayMode = true
    var origialSentences: String = ""
    var startSentenceIndex = 0
    var endSentencesIndex = 0
    
    
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
    
    private func getOrigialSentences(){
        booksDataSourse.getBookStorge(for: book!) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let bookStorage):
                self.origialSentences = bookStorage.getOrigialSentences()
            case .failure(let error):
                print("Error\(error)")
            }
            
            //let separators = CharacterSet(charactersIn: ".!?")
            //return origialSentences.components(separatedBy: separators)
        }
    }
    
    private func startSpeak(book: Book) {
        self.book = book
        getOrigialSentences()
        speakNextSentenceIfAvailable()
    }
    
    private func stopSpeaking() {
        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    private func continueSpeaking() {
        synth.continueSpeaking()
    }
    
    private func pauseSpeaking() {
        synth.pauseSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    private func speak(textToSpeakText: String) {
        if synth.isSpeaking {
            stopSpeaking()
        }
        
        let utterance = AVSpeechUtterance(string: seperatedSentences.first!)
        
        utterance.rate = rate
        utterance.pitchMultiplier = pitchMultiplier
        utterance.postUtteranceDelay = postUtteranceDelay
        utterance.volume = volume
        
        let voice = AVSpeechSynthesisVoice(language: language)
        
        utterance.voice = voice
        synth.speak(utterance)
        setupCommandCenter()
    }
    
    private func setupCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: book!.name]
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.continueSpeaking()
            return.success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.pauseSpeaking()
            return.success
        }
        
    }
    
    private func unwindeCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.removeTarget(self)
        commandCenter.pauseCommand.removeTarget(self)
    }
    
    private func getNextSentence(prevSentence: (start: Int, end: Int)) -> String? {
        let parser = TextParser(text: origialSentences)
        if prevSentence.end == 0 {
            guard let sentence = parser.getRangForNextSentence(startingFrom: prevSentence.end) else {
                print("No sentence")
                return nil
            }
            let startIndex = origialSentences.index(origialSentences.startIndex, offsetBy: sentence.start)
            let endIndex = origialSentences.index(origialSentences.startIndex, offsetBy: sentence.end)
            let curentSentences = String(origialSentences[startIndex ... endIndex])
            
            return curentSentences
        }
        guard let sentence = parser.getRangForNextSentence(startingFrom: prevSentence.end + 1) else {
            print("No sentence")
            return nil
        }
        let startIndex = origialSentences.index(origialSentences.startIndex, offsetBy: sentence.start)
        let endIndex = origialSentences.index(origialSentences.startIndex, offsetBy: sentence.end)
        startSentenceIndex = sentence.start
        endSentencesIndex = sentence.end
        let curentSentences = String(origialSentences[startIndex ... endIndex])
        startSentenceIndex = endSentencesIndex
        return curentSentences
    }
    
    
    private func getPreviousSentence(prevSentence: (start: Int, end: Int)) -> String? {
        let parser = TextParser(text: origialSentences)
        if prevSentence.end == 0 {
            guard let sentence = parser.getRangForPreviousSentence(startingFrom: prevSentence.end) else {
                print("No sentence")
                return nil
            }
            let firstSentencestart = sentence.start + 1
            let startIndex = origialSentences.index(origialSentences.startIndex, offsetBy: firstSentencestart)
            let endIndex = origialSentences.index(origialSentences.startIndex, offsetBy: sentence.end)
            let curentSentences = String(origialSentences[startIndex ... endIndex])
            
            return curentSentences
        }
        guard let sentence = parser.getRangForPreviousSentence(startingFrom: prevSentence.end) else {
            print("No sentence")
            return nil
        }
        let startIndex = origialSentences.index(origialSentences.startIndex, offsetBy: sentence.start)
        let endIndex = origialSentences.index(origialSentences.startIndex, offsetBy: sentence.end)
        startSentenceIndex = sentence.start
        endSentencesIndex = sentence.end
        let curentSentences = String(origialSentences[startIndex ... endIndex])
        startSentenceIndex = endSentencesIndex
        return curentSentences
    }
    
    private func speakNextSentenceIfAvailable() {
        if let sentence = getNextSentence(prevSentence: (start: startSentenceIndex, end: endSentencesIndex)) {
            stopSpeaking()
            speak(textToSpeakText: sentence)
        }
    }
    
    private func speakPreviousSentenceIfAvailable() {
        if let sentence = getPreviousSentence(prevSentence: (start: startSentenceIndex, end: endSentencesIndex)) {
            stopSpeaking()
            speak(textToSpeakText: sentence)
        }
    }
    
    //MARK: Publick interface
    
    func startPlay(book: Book) {
        startSpeak(book: book)
    }
    
    func stop() {
        stopSpeaking()
    }
    
    func continuePlay() {
        continueSpeaking()
    }
    
    func pause() {
        pauseSpeaking()
    }
    
    func nextSentence() {
        speakNextSentenceIfAvailable()
    }
    
    func previousSentence() {
        speakPreviousSentenceIfAvailable()
    }
}
protocol PlayerDelegate: AnyObject {
    func playerDidFinish()
}

extension Player: AVSpeechSynthesizerDelegate {
    func player(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        speakNextSentenceIfAvailable()
        DispatchQueue.main.async {
            self.delegate?.playerDidFinish()
        }
    }
    
    func player(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("didStart")
    }
    
    func player(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        print("didPause")
    }
    
    func player(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        print("didContinue")
    }
}



