//
//  BooksDataSourse.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 28.05.2021.
//

import Foundation

class BooksDataSourse {
    static let `default` = BooksDataSourse()
    
    static let dataSourceDidUpdatedNotification: Notification.Name = Notification.Name("BooksDataSourseDidUpdatedNotification")
    
    lazy var notificationCenter = NotificationCenter.default
    
    private var books: [Book]? {
        didSet {
            saveBooks()
            notificationCenter.post(Notification(name: BooksDataSourse.dataSourceDidUpdatedNotification))
        }
    }
    
    private lazy var booksFileURL: URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("books.json")
    }()
    
    private func loadBooksIfNeeded() -> Result<[Book], Error> {
        if let books = books {
            return .success(books)
        }
        do {
            
            let data = try Data(contentsOf: booksFileURL)
            let decoder = JSONDecoder()
            let loadedBooks = (try? decoder.decode([Book].self, from: data)) ?? [Book]()
            books = loadedBooks
            
            return .success(loadedBooks)
        }
        catch {
            return .failure(error)
        }
    }
    
    private func saveBooks() {
        guard let books = books else {
            return
        }
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(books)
            try data.write(to: booksFileURL)
        }
        catch {
            //show error to user
            print("Can't store books: \(error)")
        }
    }
    
    
    //MARK: Publick interface
    
    func getBooks() -> [Book] {
        let result = loadBooksIfNeeded()
        return (try? result.get()) ?? []
    }
    
    func updateReadingProgress(for bookToUpdate: Book, progress: Int) {
        if let books = books {
            self.books = books.map { (book) in
                if bookToUpdate.uniqueIndentificator == book.uniqueIndentificator {
                    return Book(uniqueIndentificator: book.uniqueIndentificator,
                                name: book.name,
                                sorageFileName: book.sorageFileName,
                                coverImage: book.coverImage,
                                progresIndentificator: book.progresIndentificator,
                                type: book.type)
                } else {
                    return book
                }
            }
        }
    }
    
    func importBook(from url: URL) throws {
        let originalFileName = url.lastPathComponent
        let uniqueIndentificator = UUID.init()
        let fileNameToSave = uniqueIndentificator.uuidString + "." + url.pathExtension
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileNameToSave)
        
        try Data(contentsOf: url).write(to: fileURL)
        
        let bookType = BookType(rawValue: url.pathExtension)!
        
        
        
        let newBook = Book(uniqueIndentificator: UUID.init(),
                           name: originalFileName,
                           sorageFileName: fileNameToSave,
                           coverImage: nil,
                           progresIndentificator: 0,
                           type: bookType)
        
        self.books = getBooks() + [newBook]
    }
    
    func deleteBookFromStorge(_ bookToRemove: Book) {
        books = books?.filter{ books in
            return bookToRemove.uniqueIndentificator != books.uniqueIndentificator
        }
    }
    
    private var currentLoadedBook: (book: Book, bookStorage: BookStorage)?
    
    func getBookStorge(for book: Book, completion: @escaping (Result<BookStorage, Error>) -> Void) {
        if let curentLoadedBook = currentLoadedBook,
           curentLoadedBook.book.uniqueIndentificator == book.uniqueIndentificator {
            completion(.success(curentLoadedBook.bookStorage))
            return
        }
        
        DispatchQueue.global().async {
            var storage: BookStorage?
            var loadingError: Error?
            do {
                switch book.type {
                case .html:
                    storage = try HtlmBookStorgare(storageURL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(book.sorageFileName))
                case .txt:
                    storage = try TextBookStorgare(storageURL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(book.sorageFileName))
                }
            }
            catch {
                loadingError = error
            }
            DispatchQueue.main.async {
                if let storage = storage {
                    self.currentLoadedBook = (book, storage)
                    completion(.success(storage))
                } else {
                    completion(.failure(loadingError!))
                }
            }
        }
    }
    
}
protocol BookStorage {
    func getCoverImageURL() -> URL?
    func getOrigialSentences() -> String
}

class TextBookStorgare: BookStorage {
    let storageURL: URL
    var origialSentences: String!
    
    
    init(storageURL: URL) throws {
        self.storageURL = storageURL
        try loadSentences()
    }
    
    private func loadSentences() throws {
        origialSentences = try? String(contentsOf: storageURL, encoding: .utf8)

    }
    
    func getOrigialSentences() -> String {
        return origialSentences
    }
    
    func getCoverImageURL() -> URL? {
        return nil
    }
}
class HtlmBookStorgare: BookStorage {
    let storageURL: URL
    var origialSentences: String!
    
    init(storageURL: URL) throws {
        self.storageURL = storageURL
    }
    
    private func loadSentences() {
        
    }
    
    func loadSentencesIfNeeded() {

    }
    
    func getOrigialSentences() -> String {
        return origialSentences
    }
    
    
    func getCoverImageURL() -> URL? {
        return nil
    }
}

