//
//  EPUBBook.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 29.04.2021.
//

import Foundation

class EPUBBook {
    let container: ContainerDocument
    
    init?(contentsOf baseURL: URL) {
        // Find the location of container.xml
        let containerURL = baseURL.appendingPathComponent("META-INF/container.xml")
        // Parse the container file
        guard let container = ContainerDocument(url: containerURL) else { return nil }
        self.container = container
        // Get the location of the OPF file
        let opfURL = baseURL.appendingPathComponent(container.opfPath)
    }
}
