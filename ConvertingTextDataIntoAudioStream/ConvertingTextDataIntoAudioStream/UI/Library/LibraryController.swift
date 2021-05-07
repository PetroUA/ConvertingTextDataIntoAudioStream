//
//  LibraryController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 27.04.2021.
//
import UniformTypeIdentifiers
import UIKit

class LibraryController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var synthesizer = SpeechSynthesizer()
    let sentenceBySentenceReader = SentenceBySentenceReader(allTextData: TXTParser().getTextData())
    
    @IBAction func importTapped(_ sender: Any) {
        let supportedTypes: [UTType] = [UTType.text]
        let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: false)
        
        pickerViewController.delegate = self
        pickerViewController.allowsMultipleSelection = false
        pickerViewController.modalPresentationStyle = .fullScreen
        present(pickerViewController, animated: true, completion: nil)
        
    }
    
}
extension LibraryController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("URLs: \(urls)")
    }
}
