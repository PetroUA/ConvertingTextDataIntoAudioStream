//
//  StartPageCollectionViewCell.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 31.05.2021.
//

import Foundation
import UIKit

class StartPageCollectionViewCell: UICollectionViewCell {
    var book: Book!
    weak var delegate: LibraryBookCollectionViewCellDelegate?
    
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    
    func configure(with book: Book) {
        self.cellTitle.text = "Last book:"
        self.book = book
        bookName.text = book.name
        if book.coverImage != nil {
            let data = try! Data(contentsOf: book.coverImage!)
            self.coverImage.image = UIImage(data: data)
        }
    }
    
}
