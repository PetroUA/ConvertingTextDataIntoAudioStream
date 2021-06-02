//
//  Color.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 02.06.2021.
//

import Foundation
import UIKit
class Color {
    func getUIColor(stringColor: String) -> UIColor{
        switch stringColor {
        case "Black":
            return UIColor.black
        case "White":
            return UIColor.white
        case "Red" :
            return UIColor.red
        case "Yellow" :
            return UIColor.yellow
        case "Gray" :
            return UIColor.gray
        case "Green":
            return UIColor.green
        case "Orange" :
            return UIColor.orange
        default:
            return UIColor.black
        }
    }
}
