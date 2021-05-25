//
//  TxtParser.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 29.04.2021.
//

import Foundation

class TXTParser {
    let file = "file.txt" //this is the file. we will write to and read from it

    let text = "Apple Inc! is an American multinational technology company headquartered in Cupertino, California, that designs, develops, and sells consumer electronics, computer software, and online services? It is considered one of the Big Five companies in the U.S. information technology industry, along with Amazon, Google, Microsoft, and Facebook. Its hardware products include iPhone smartphones, iPad tablet computers, Mac personal computers, iPod portable media players, Apple Watch smartwatches, Apple TV digital media players, AirPods wireless earbuds, AirPods Max headphones, and the HomePod smart speaker line. Apple's software includes the iOS, iPadOS, macOS, watchOS, and tvOS operating systems, the iTunes media player, the Safari web browser, the Shazam music identifier, and the iLife and iWork creativity and productivity suites, as well as professional applications like Final Cut Pro, Logic Pro, and Xcode. Its online services include the iTunes Store, the iOS App Store, Mac App Store, Apple Arcade, Apple Music, Apple TV+, Apple Fitness+, iMessage, and iCloud. Other services include Apple Stores, the Genius Bar, AppleCare, Apple Pay, Apple Cash, and Apple Card. Apple was founded by Steve Jobs, Steve Wozniak, and Ronald Wayne in April 1976 to develop and sell Wozniak's Apple I personal computer, though Wayne sold his share back to Jobs and Wozniak within 12 days. It was incorporated as Apple Computer, Inc., in January 1977, and sales of its computers, including the Apple II, grew quickly.Jobs and Wozniak hired a staff of computer designers and had a production line starting in Jobs' garage. Apple went public in 1980 to instant financial success. Over the next few years, Apple shipped new computers featuring innovative graphical user interfaces, such as the original Macintosh in 1984, and Apple's marketing advertisements for its products received widespread critical acclaim. However, the high price of its products and limited application library caused problems, as did power struggles between executives. In 1985, Wozniak departed Apple amicably and remained an honorary employee, while Jobs resigned to found NeXT, taking some Apple co-workers with him." //just a text
    
    func getTextData() -> String {
        var textData: String? = nil // to do when add icloud
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(file)
            // remove when add icloud or...
            do {
                    try text.write(to: fileURL, atomically: false, encoding: .utf8)
                }
                catch {print("File is empty")}
            //
            do {
                textData = try String(contentsOf: fileURL)
            }
            catch {
                print("File is empty, or not exist")
            }
            //print (fileURL)
        }
        
        return textData!
    }
    
    func getTitle() -> String {
        var title: String = " "
        
        title = "fileName" // to do when add icloud
        
        return title
    }
}
