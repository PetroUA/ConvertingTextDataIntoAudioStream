//
//  SettingsPickerView.swift
//  ConvertingTextDataIntoAudioStream
//
//  Created by Petro on 01.06.2021.
//

import Foundation
import UIKit
protocol SettingsPickerViewDelegate: class {
    func didTapDone()
    func didTapCancel()
}

class SettingsPickerView: UIPickerView {

    public private(set) var toolbar: UIToolbar?
    public weak var settingsPickerDelegate: SettingsPickerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.toolbar = toolBar
    }

    @objc func doneTapped() {
        self.settingsPickerDelegate?.didTapDone()
    }

    @objc func cancelTapped() {
        self.settingsPickerDelegate?.didTapCancel()
    }
}
