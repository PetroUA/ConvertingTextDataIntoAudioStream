//
//  MyCollectionViewCell.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 27.05.2021.
//

import UIKit

protocol LibraryBookCollectionViewCellDelegate: AnyObject {
    func libraryBookCollectionViewCellDelegateDidTapActionButton(book: Book)
}

class LibraryBookCollectionViewCell: UICollectionViewCell {
    var book: Book!
    weak var delegate: LibraryBookCollectionViewCellDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    func configure(with book: Book) {
        self.book = book
        label.text = book.name
        if book.coverImage != nil {
            let data = try! Data(contentsOf: book.coverImage!)
            self.coverImage.image = UIImage(data: data)
        }
    }
    
    @IBAction func actionWithBook(sender : UIButton){
        delegate?.libraryBookCollectionViewCellDelegateDidTapActionButton(book: book)
    }

}
