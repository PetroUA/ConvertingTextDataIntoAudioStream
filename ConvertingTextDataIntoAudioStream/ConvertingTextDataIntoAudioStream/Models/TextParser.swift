//
//  TextParser.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 29.05.2021.
//

import Foundation
class TextParser {
    var text: String
    
    init(text: String) {
        self.text = text
    }
    
    func getRangForNextSentence(startingFrom: Int) -> (start: Int, end: Int)? {
        guard startingFrom >= 0, startingFrom < text.count else {
            return nil
        }
        let startIndex = text.index(text.startIndex, offsetBy: startingFrom)
        var startOffset: Int?
        var endOffset: Int?
        var prevChar: Character?
        
        for (i, char) in text[startIndex ..< text.endIndex].enumerated() {
            if startOffset == nil {
                if !char.isWhitespace {
                    startOffset = i
                }
            } else {
                endOffset = i
                if char == "." {
                    break
                }
                if char == "!" {
                    break
                }
                if char == "?" {
                    break
                }
                if prevChar == "\n", char == "\n" {
                    endOffset = endOffset! - 1
                    break
                }
            }
            prevChar = char
        }
        
        if let startOffset = startOffset, let endOffset = endOffset {
            return (startingFrom + startOffset, startingFrom + endOffset)
        }
        
        return nil
    }
    
    var isNextSentence: Bool = false
    
    func getRangForPreviousSentence(startingFrom: Int) -> (start: Int, end: Int)? {
        guard startingFrom >= 0, startingFrom < text.count else {
            return nil
        }
        let endIndex = text.index(text.startIndex, offsetBy: startingFrom)
        var startOffset: Int?
        var endOffset: Int?
        var prevChar: Character?
        
        for (i, char) in text[...endIndex].enumerated().reversed() {
            if endOffset == nil {
                if !char.isWhitespace {
                    endOffset = i
                }
            } else {
                startOffset = i
                if char == "." {
                    break
                }
                if char == "!" {
                    break
                }
                if char == "?" {
                    break
                }
                if prevChar == "\n", char == "\n" {
                    startOffset = startOffset! - 1
                    break
                }
            }
            prevChar = char
        }
        if endOffset == 0 {
            return nil
        }
        if isNextSentence{
            if let startOffset = startOffset, let endOffset = endOffset {
                return (startOffset + 1,  endOffset)
            }
        }
        else {
            isNextSentence = true
            return getRangForPreviousSentence(startingFrom: startOffset!)
        }
        
        return nil
    }
}
