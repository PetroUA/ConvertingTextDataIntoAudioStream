//
//  LineByLineReader.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 04.05.2021.
//

import Foundation

class SentenceBySentenceReader {
    let sentences: [String]
    var currentIndex = 0
    
    init(sentences: [String]) {
        self.sentences = sentences
    }
    
    func getNextSentence() -> String? {
        guard currentIndex < sentences.count else {
            return nil
        }
        
        let result = sentences[currentIndex]
        currentIndex += 1
        print(currentIndex)
        return result
    }
    
    func getPreviousSentence() -> String? {
        guard currentIndex > 0 else {
            return nil
        }
        currentIndex -= 1
        print(currentIndex)
        if currentIndex == 0 {
            return self.getNextSentence()
        }
        return sentences[currentIndex - 1]
    }
}
