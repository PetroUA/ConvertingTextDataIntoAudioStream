//
//  SettingsPickerViewController.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 01.06.2021.
//

import Foundation
import UIKit

class SettingsPickerViewController: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    let pickerView = SettingsPickerView()
    var currentValue: String
    let data: [String]
    let textField: UITextField
    let onValueSelected: (String) -> Void
    
    init(currentValue: String, data: [String], textField: UITextField, onValueSelected: @escaping (String) -> Void) {
        self.currentValue = currentValue
        self.data = data
        self.textField = textField
        self.onValueSelected = onValueSelected
        
        super.init()
    
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.settingsPickerDelegate = self
        pickerView.reloadAllComponents()
        
        if let selectedIndex = data.firstIndex(of: currentValue) {
            pickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
        }
        
        textField.inputView = pickerView
        textField.inputAccessoryView = pickerView.toolbar
        textField.text = currentValue
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.data.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.data[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = self.data[row]
    }
}

extension SettingsPickerViewController: SettingsPickerViewDelegate  {
    func didTapDone() {
        let row = pickerView.selectedRow(inComponent: 0)
        let newValue = data[row]
        currentValue = newValue
        textField.text = newValue
        textField.resignFirstResponder()
        onValueSelected(newValue)
    }

    func didTapCancel() {
        textField.text = currentValue
        if let selectedIndex = data.firstIndex(of: currentValue) {
            pickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
        }
        textField.resignFirstResponder()
    }
}
