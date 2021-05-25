//
//  FileImporter.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 07.05.2021.
//

import Foundation
import UniformTypeIdentifiers
import UIKit
/*
class FileImporter{
    func getFileURL () {
        let fileManager = FileManager.default
        // Browse your icloud container to find the file you want
        if let icloudFolderURL = fileManager.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents"),
           let urls = try? fileManager.contentsOfDirectory(at: icloudFolderURL, includingPropertiesForKeys: nil, options: []) {
            
            if let myURL = urls.first {
                var lastPathComponent = myURL.lastPathComponent
                
                if lastPathComponent.contains(".icloud") {
                    lastPathComponent.removeFirst()
                    let folderPath = myURL.deletingLastPathComponent().path
                    let downloadedFilePath = folderPath + "/" + lastPathComponent.replacingOccurrences(of: ".icloud", with: "")
                    
                    var isDownloaded = false
                    while !isDownloaded {
                        if fileManager.fileExists(atPath: downloadedFilePath) {
                            isDownloaded = true
                        }
                    }
                }
            }
        }
    }
}
*/
