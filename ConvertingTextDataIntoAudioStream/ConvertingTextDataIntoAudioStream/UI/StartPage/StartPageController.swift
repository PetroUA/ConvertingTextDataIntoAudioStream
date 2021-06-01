//
//  StartPageController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 27.04.2021.
//

import UIKit

class StartPageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        book = loadLastPlayedBook()
    }
    
    lazy var booksDataSourse = BooksDataSourse.default
    lazy var notifictionCenter = NotificationCenter.default
    let lastPlayedBook = UserDefaults.standard
    private let reuseIdentifier = "startPageCell"
    var book: Book?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notifictionCenter.addObserver(self, selector: #selector(getLastPlayedBook), name: Player.playerDidStartNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notifictionCenter.removeObserver(self)
    }
    
    private func loadLastPlayedBook() -> Book? {
           if let savedBook = lastPlayedBook.object(forKey: "lastPlayedBook") as? Data {
               let decoder = JSONDecoder()
               if let loadedBook = try? decoder.decode(Book.self, from: savedBook) {
                   return loadedBook
               }
           }
               return nil
    }
        
    @objc func getLastPlayedBook() {
        book = loadLastPlayedBook()
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionView.reloadData()
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if book != nil {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let startPageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StartPageCollectionViewCell
        
        startPageCollectionViewCell.configure(with: book!)
        return startPageCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let curentBook: Book = book!
        let storyboard = UIStoryboard(name: "BookDetailsStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        vc.book = curentBook
        show(vc, sender: self)
    }
}
