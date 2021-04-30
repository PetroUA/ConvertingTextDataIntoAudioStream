//
//  TxtParser.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 29.04.2021.
//

import Foundation

class TXTParser {
    let file = "file.txt" //this is the file. we will write to and read from it

    let text = "some text" //just a text

    func getTextData() -> String {
        var textData:String = " " // to do when add icloud
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent(file)
            
            do {
                textData = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {
                print("File is empty, or not exist")
            }
        }
        return textData
    }
    
    func getTitle() -> String {
        var title:String = " "
        
        title = "fileName" // to do when add icloud
        
        return title
    }
}
