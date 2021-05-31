//
//  BookViewController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 27.04.2021.
//

import UIKit

class BookViewController: UIViewController {
    
    lazy var booksDataSourse = BooksDataSourse.default
    lazy var player = Player.default
    
    var book: Book!
    
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
                self.player.startPlay(book: self.book)
            case .failure(let error):
                self.showLoadingError(error)
            }
        }
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
        navigationItem.title = book.name
        self.bookDetailsViewController = bookDetailsViewController
    }
    
    private func showLoadingError(_ error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        let alerControler = UIAlertController(title: "Can't load book", message: nil, preferredStyle: UIAlertController.Style.alert)
        show(alerControler, sender: Any?.self)
    }
}
