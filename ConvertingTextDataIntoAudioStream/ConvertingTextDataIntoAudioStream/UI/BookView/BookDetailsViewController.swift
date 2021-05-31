//
//  BookDetailsViewController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 28.05.2021.
//

import UIKit


class BookDetailsViewController: UIViewController {
    var bookStorage: BookStorage!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        textView.text = bookStorage.getOrigialText()
    }
}
