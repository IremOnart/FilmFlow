//
//  ModernTextField.swift
//  FilmFlow
//
//  Created by İrem Onart on 27.01.2025.
//

import UIKit

class ModernTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTextField()
    }
    
    private func configureTextField() {
    
        self.backgroundColor = UIColor.systemGray6
        self.layer.cornerRadius = 25
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.textColor = .darkGray
        self.font = UIFont.systemFont(ofSize: 16)
        
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        self.leftViewMode = .always
        
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        self.rightViewMode = .always
        
        self.attributedPlaceholder = NSAttributedString(
            string: "Search Film...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
