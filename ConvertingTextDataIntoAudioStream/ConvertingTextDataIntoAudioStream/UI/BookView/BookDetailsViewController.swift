//
//  BookDetailsViewController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 28.05.2021.
//

import UIKit


class BookDetailsViewController: UIViewController {
    
    let settings = Settings()
    let color = Color()
    var bookStorage: BookStorage!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = color.getUIColor(stringColor: settings.getBackgroundColor())
        let size: CGFloat = CGFloat(Int(settings.getTextSize())!)
        textView.font = UIFont(descriptor: UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFont.TextStyle.body), size: size)
        textView.textColor = color.getUIColor(stringColor: settings.getTextColor())
        textView.backgroundColor = color.getUIColor(stringColor: settings.getBackgroundColor())
        textView.text = bookStorage.getOrigialText()
    }
}
