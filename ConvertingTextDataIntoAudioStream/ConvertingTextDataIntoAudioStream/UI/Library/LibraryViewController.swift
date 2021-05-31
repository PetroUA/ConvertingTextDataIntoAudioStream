//
//  LibraryViewController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 27.04.2021.
//
import UniformTypeIdentifiers
import UIKit

class LibraryViewController: UICollectionViewController {
    
    private let reuseIdentifier = "libraryBookCollectionViewCell"
    lazy var booksDataSourse = BooksDataSourse.default
    lazy var notifictionCenter = NotificationCenter.default
    
    var books: [Book] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadBooks()
        notifictionCenter.addObserver(self, selector: #selector(reloadBooks), name: BooksDataSourse.dataSourceDidUpdatedNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notifictionCenter.removeObserver(self)
    }
    
    @IBAction func importTapped(_ sender: Any) {
        let supportedTypes: [UTType] = [.text]
        let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        
        pickerViewController.delegate = self
        pickerViewController.allowsMultipleSelection = false
        pickerViewController.modalPresentationStyle = .fullScreen
        present(pickerViewController, animated: true, completion: nil)
        
    }
    
    @objc
    func reloadBooks() {
        books = booksDataSourse.getBooks()
        collectionView.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let libraryBookCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LibraryBookCollectionViewCell
        
        libraryBookCollectionViewCell.configure(with: books[indexPath.row])
        libraryBookCollectionViewCell.delegate = self
        
        return libraryBookCollectionViewCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let curentBook: Book = books[indexPath.row]
        let storyboard = UIStoryboard(name: "BookDetailsStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        vc.book = curentBook
        show(vc, sender: self)
    }
}

extension LibraryViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let origialURL = urls.first else {
            return
        }
        do {
            try booksDataSourse.importBook(from: origialURL)
        }
        catch {
            print("Import error: \(error)")
        }
        
    }
}

extension LibraryViewController: LibraryBookCollectionViewCellDelegate {
    func libraryBookCollectionViewCellDelegateDidTapActionButton(book: Book) {
        let alert = UIAlertController(title: "Action", message: "What to do?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Play", style: UIAlertAction.Style.default, handler: {_ in
            let storyboard = UIStoryboard(name: "BookDetailsStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
            vc.book = book
            self.show(vc, sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Delete Book", style: UIAlertAction.Style.destructive, handler: {_ in
            let deleteAlert = UIAlertController(title: "Book will be deleted", message: "Rely want delete book?", preferredStyle: UIAlertController.Style.alert)
            deleteAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { [self]_ in
                booksDataSourse.deleteBookFromStorge(book)
            }))
            deleteAlert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(deleteAlert, animated: true, completion: nil)
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

