//
//  CustomTextField.swift
//  AppcentNews
//
//  Created by Barış Can Akkaya on 21.10.2021.
//

import Foundation
import UIKit

class CustomTextField: UITextField {

    override open func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    func initialize() {
        let clearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        clearButton.setImage(UIImage(systemName: "x.circle"), for: .normal)
        clearButton.tintColor = .black
        let searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .black
        self.rightView = clearButton
        self.leftView = searchButton
        searchButton.addTarget(self, action: #selector(clearClicked), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(clearClicked), for: .touchUpInside)
        
        self.clearButtonMode = .never
        self.rightViewMode = .always
        self.leftViewMode = .always
    }

    @objc func clearClicked(sender:UIButton)
    {
        self.text = ""
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
