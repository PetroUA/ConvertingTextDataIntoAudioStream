//
//  Player.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 29.05.2021.
//
import Foundation
import AVFoundation
import MediaPlayer

class Player {
    static let `default` = Player()
    let settings = Settings()
    lazy var booksDataSourse = BooksDataSourse.default
    lazy var textSpeaker: TextSpeacker = {
        let textSpeaker = TextSpeacker()
        textSpeaker.delegate = self
        return textSpeaker
    } ()
    
    static let playerDidStartNotification: Notification.Name = Notification.Name("PlayerDidStartNotification")
    static let playerDidFinishNotification: Notification.Name = Notification.Name("PlayerDidFinishNotification")
    static let playerDidPauseNotification: Notification.Name = Notification.Name("PlayerDidPauseNotification")
    static let playerDidContinueNotification: Notification.Name = Notification.Name("PlayerDidContinueNotification")
    static let playerDidStartSentenceNotification: Notification.Name = Notification.Name("PlayerDidStartSentenceNotification")
    static let playerDidFinishSentenceNotification: Notification.Name = Notification.Name("PlayerDidFinishSentenceNotification")
    
    lazy var notifictionCenter = NotificationCenter.default
    
    private(set) var book: Book?
    private var bookStorage: BookStorage?
    private var parser: TextParser?
    
    var origialSentences: String = ""
    var startSentenceIndex = 0
    var endSentencesIndex = 0
    
    var isPaused: Bool {
        return textSpeaker.isPaused
    }

    private var shouldContnuePaying = false
    private var isStartingPayback = false
    private var isRewinding = false
    
    //MARK: Publick interface
    
    func startPlay(book: Book) {
        self.book = book
        shouldContnuePaying = true
        isStartingPayback = true
        loadBookStorageAndPlay()
        setupCommandCenter()
    }
    
    func stop() {
        shouldContnuePaying = false
        isStartingPayback = false
        book = nil
        nextSentenceOffset = nil
        bookStorage = nil
        textSpeaker.stop()
    }
    
    func continuePlay() {
        textSpeaker.continue()
        notifictionCenter.post(Notification(name: Player.playerDidContinueNotification))
    }
    
    func pause() {
        textSpeaker.pause()
        notifictionCenter.post(Notification(name: Player.playerDidPauseNotification))
    }
    
    func rewindToNextSentence() {
        isRewinding = true
        textSpeaker.stop()
        notifictionCenter.post(Notification(name: Player.playerDidFinishSentenceNotification))
        loadNextSentenceAndPlay()
        isRewinding = false
    }
    
    func rewindToPreviouseSentence() {
        isRewinding = true
        textSpeaker.stop()
        notifictionCenter.post(Notification(name: Player.playerDidFinishSentenceNotification))
        loadPrevSentenceAndPlay()
        isRewinding = false
    }
    
    //MARK: - Command center logic
    
    private func setupCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: book!.name]
        
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.continuePlay()
            return.success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.pause()
            return.success
        }
    }
    
    private func unwindeCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.removeTarget(self)
        commandCenter.pauseCommand.removeTarget(self)
    }
    
    //MARK: - Private logic
    private var nextSentenceOffset: Int?
    
    private func saveLastPlayedBook(curentBook: Book) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(curentBook) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "lastPlayedBook")
        }
    }
    
    private func loadBookStorageAndPlay() {
        guard let book = book else {
            return
        }
        saveLastPlayedBook(curentBook: book)
        nextSentenceOffset = book.readingOffset
        self.bookStorage = nil
        booksDataSourse.getBookStorge(for: book) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let bookStorage):
                self.bookStorage = bookStorage
                self.parser = TextParser(text: bookStorage.getOrigialText())
                self.loadNextSentenceAndPlay()
            case .failure(let error):
                print("Error\(error)")
            }
        }
    }
    
    private func loadNextSentenceAndPlay() {
        guard let parser = parser,
              let prevOffset = nextSentenceOffset,
              let (sentenceStart, sentenceEnd) = parser.getRangeForNextSentence(startingFrom: prevOffset) else {
            return
        }
        
        let text = parser.text
        let startIndex = text.index(text.startIndex, offsetBy: sentenceStart)
        let endIndex = text.index(text.startIndex, offsetBy: sentenceEnd)
        let sentence = String(text[startIndex ... endIndex])
        
        settings.setHighlightStartRange(curentValue: sentenceStart)
        settings.setHighlightEndRange(curentValue: sentence.count)
        notifictionCenter.post(Notification(name: Player.playerDidStartSentenceNotification))
        
        nextSentenceOffset = sentenceEnd + 1
        textSpeaker.speak(text: sentence)
    }
    
    private func loadPrevSentenceAndPlay()  {
        guard let parser = parser,
              let prevOffset = nextSentenceOffset,
              let (sentenceStart, sentenceEnd) = parser.getRangeForPreviousSentence(startingFrom: prevOffset) else {
            return
        }
        
        let text = parser.text
        let startIndex = text.index(text.startIndex, offsetBy: sentenceStart)
        let endIndex = text.index(text.startIndex, offsetBy: sentenceEnd)
        let sentence = String(text[startIndex ... endIndex])
        
        settings.setHighlightStartRange(curentValue: sentenceStart)
        settings.setHighlightEndRange(curentValue: sentence.count)
        notifictionCenter.post(Notification(name: Player.playerDidStartSentenceNotification))
        
        nextSentenceOffset = sentenceEnd + 1
        textSpeaker.speak(text: sentence)
    }
    
    private func onPlayerDidFinish() {
        notifictionCenter.post(Notification(name: Player.playerDidFinishNotification))
        unwindeCommandCenter()
    }
    
}

extension Player: TextSpeackerDelegate {
    func textSpeackerDidFinishSpeaking() {
        if !isRewinding, shouldContnuePaying {
            booksDataSourse.updateReadingProgress(for: book!, progress: nextSentenceOffset!)
            notifictionCenter.post(Notification(name: Player.playerDidFinishSentenceNotification))
            loadNextSentenceAndPlay()
        } else {
            onPlayerDidFinish()
        }
    }
    
    func textSpeackerDidStartSpeaking() {
        if isStartingPayback {
            notifictionCenter.post(Notification(name: Player.playerDidStartNotification))
        }
        isStartingPayback = false
    }
    
    func textSpeackerDidPauseSpeaking() {
        notifictionCenter.post(Notification(name: Player.playerDidPauseNotification))
    }
    
    func textSpeackerDidContinueSpeaking() {
        notifictionCenter.post(Notification(name: Player.playerDidContinueNotification))
    }
}
