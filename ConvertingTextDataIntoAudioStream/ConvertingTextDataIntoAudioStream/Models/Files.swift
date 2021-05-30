//
//  Files.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 25.05.2021.
//
/*
import Foundation
class Files {
    let userFiles = UserDefaults.standard
    
    func getArrayForKey(key: String) -> [String] {
        
        return userFiles.object(forKey: key) as? [String] ?? []
    }
    
    func getFileContent() -> String {
        let strings: [String] = getArrayForKey(key: "fileContent")
        
        return strings[self.getCurentFileIdentificator()]
    }
    
    func setFileContent(curentValue: String) {
        var strings: [String] = getArrayForKey(key: "fileContent")
        
        strings.append(curentValue)
        
        userFiles.set(strings, forKey: "fileContent")
    }
    
    func deleteFileContent(fileName: String) {
        var strings: [String] = getArrayForKey(key: "fileContent")
        
        strings.remove(at: self.getFileIdentificator(fileName: fileName))
        
        userFiles.set(strings, forKey: "fileContent")
    }
    
    func getFileName() -> String {
        let strings: [String] = getArrayForKey(key: "fileName")
        
        return strings[self.getCurentFileIdentificator()]
    }
    
    func setFileName(curentValue: String) {
        var strings: [String] = getArrayForKey(key: "fileName")
        
        strings.append(curentValue)
        
        userFiles.set(strings, forKey: "fileName")
    }
    
    func deleteFileName(fileName: String) {
        var strings: [String] = getArrayForKey(key: "fileName")
        
        strings.remove(at: self.getFileIdentificator(fileName: fileName))
        
        userFiles.set(strings, forKey: "fileName")
    }
    
    func getFileIdentificator(fileName: String) -> Int {
        let strings: [String] = getArrayForKey(key: "fileName")
        let index = strings.firstIndex(of: fileName)
        return index!
    }
    
    func setCurentFileIdentificator(curentValue: Int) {
        userFiles.set(curentValue, forKey: "curentFileIdentificator")
    }
    
    func getCurentFileIdentificator() -> Int {
        return userFiles.integer(forKey: "curentFileIdentificator")
    }
 }*/
