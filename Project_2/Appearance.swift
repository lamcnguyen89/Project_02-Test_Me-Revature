//
//  Appearance.swift
//  Project_2
//
//  Created by Lam Nguyen on 5/12/21.
//

// This file contains standardized appearances for objects
import Foundation
import UIKit

// Class to standardize Main View Objects
class MyMainView : UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        // MyMainView.appearance().backgroundColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        MyMainView.appearance().backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
}

// Class to standardize Primary Button Objects
class MyButtons : UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        // MyButtons.appearance().backgroundColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        MyButtons.appearance().backgroundColor = .systemPurple
        MyButtons.appearance().contentEdgeInsets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
        // MyButtons.appearance().tintColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        MyButtons.appearance().tintColor = .white
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.titleLabel?.font = UIFont(name: "System", size: 20)
        self.frame.size.width = 200
    
    
    }
    
    
}

// Class to standardize heading labels
class MyHeadingLabels: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        //MyQuestionLabels.appearance().backgroundColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 35.0)
        
    }}


// Class to standardize labels that contain the questions
class MyQuestionLabels : UILabel {
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        //MyQuestionLabels.appearance().backgroundColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        MyQuestionLabels.appearance().tintColor = .label
        
    }
}

// Class to style text fields
class MyTextFields : UITextField {
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        // textFieldPlaceholder()
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "placeholder", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }}
