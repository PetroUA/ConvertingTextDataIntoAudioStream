//
//  Book.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 28.05.2021.
//
import Foundation

enum BookType: String, Codable {
    case txt
    case html
}

struct Book: Codable {
    let uniqueIndentificator: UUID
    let name: String
    let sorageFileName: String
    let coverImage: URL?
    let progresIndentificator: Int
    let type: BookType
}
