//
//  BookViewController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 27.04.2021.
//

import UIKit

class BookViewController: UIViewController {
    
    lazy var booksDataSourse = BooksDataSourse.default
//    lazy var synthesizer: SpeechSynthesizer = {
//        let synthesizer = SpeechSynthesizer()
//        synthesizer.delegate = self
//        return synthesizer
//    } ()
//    lazy var sentenceBySentenceReader = SentenceBySentenceReader(sentences: sentences)
    
    var book: Book!
//    var sentences: [String]?
//    var isPlayMode = true
    
    var bookDetailsViewController: BookDetailsViewController? {
        didSet {
            if let oldValue = oldValue {
                oldValue.willMove(toParent: nil)
                oldValue.view.removeFromSuperview()
                oldValue.removeFromParent()
            }
            if let bookDetailsViewController = bookDetailsViewController {
                addChild(bookDetailsViewController)
                view.addSubview(bookDetailsViewController.view)
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: bookDetailsViewController.view.topAnchor),
                    view.bottomAnchor.constraint(equalTo: bookDetailsViewController.view.bottomAnchor),
                    view.leadingAnchor.constraint(equalTo: bookDetailsViewController.view.leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: bookDetailsViewController.view.trailingAnchor),
                ])
                didMove(toParent: self)
            }
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
/*
    func speakNextSentenceIfAvailable() {
//        if let sentence = sentenceBySentenceReader.getNextSentence() {
//            synthesizer.stopSpeaking()
//            synthesizer.speak(textToSpeakText: sentence)
//        }
    }
  
    func speakPreviousSentenceIfAvailable() {
//        if let sentence = sentenceBySentenceReader.getPreviousSentence() {
//            synthesizer.stopSpeaking()
//            synthesizer.speak(textToSpeakText: sentence)
//        }
    }
*/
//    @IBAction func nextSentenceButtonTapped(_ sender: Any) {
//        speakNextSentenceIfAvailable()
//    }
//
//    @IBAction func previousSentenceButtonTapped(_ sender: Any) {
//        speakPreviousSentenceIfAvailable()
//    }
//
//    @IBAction func PlayAndPauseButtonTapped(_ sender: Any) {
//        if isPlayMode {
//            playAndPauseButton.image = UIImage(systemName: "play.fill")
//            synthesizer.pauseSpeaking()
//            isPlayMode = false
//        } else {
//            playAndPauseButton.image = UIImage(systemName: "pause.fill")
//            synthesizer.continueSpeaking()
//            isPlayMode = true
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingState()
        
        booksDataSourse.getBookStorge(for: book) { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let bookStorage):
                self.show(bookStorage: bookStorage)
            case .failure(let error):
                self.showLoadingError(error)
            }
        }
        
        
//        let files = Files()
//        textView.backgroundColor = UIColor.white
//        textView.textColor = UIColor.black
//        let size = 14
//        textView.font = UIFont(name: "System", size: CGFloat(size))
//
//
//        textView.text = files.getFileContent()
//        speakNextSentenceIfAvailable()
    }
    
    private func showLoadingState() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func show(bookStorage: BookStorage) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        
        let bookDetailsViewController = UIStoryboard(name: "BookDetailsStoryboard", bundle: nil).instantiateViewController(identifier: "BookDetailsViewController") as! BookDetailsViewController
        
        bookDetailsViewController.bookStorage = bookStorage
        self.bookDetailsViewController = bookDetailsViewController
    }
    
    private func showLoadingError(_ error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
//        let alerControler = UIAlertController(title: "Can't load book", message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
    }
}
/*
extension PlayerControler: SpeechSynthesizerDelegate {
    func speechSynthesizerDidFinish() {
        speakNextSentenceIfAvailable()
    }
}*/
