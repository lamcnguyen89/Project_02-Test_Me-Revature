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
class MyBackground1 : UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        self.backgroundColor = UIColor(red: 194/255 , green: 246/255 ,blue: 233/255 , alpha: 1.0)
       // let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
       // backgroundImage.image = UIImage(named: "Circuit-Board")
       // backgroundImage.contentMode = .scaleAspectFill
       // self.insertSubview(backgroundImage, at: 0)
        
    }
    
}

class MyBackground2 : UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        self.backgroundColor = UIColor(red: 255/255 , green: 222/255 ,blue: 239/255 , alpha: 1.0)
    }
    
}

class MyBackground3 : UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        self.backgroundColor = UIColor(red: 206/255 , green: 203/255 ,blue: 230/255 , alpha: 1.0)
    }
    
}

class MyBackground4 : UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        self.backgroundColor = UIColor(red: 231/255 , green: 200/255 ,blue: 180/255 , alpha: 1.0)
    }
    
}

class MyBackground5 : UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        self.backgroundColor = UIColor(red: 247/255 , green: 242/255 ,blue: 212/255 , alpha: 1.0)
    }
    
}

class MyBackground6 : UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        self.backgroundColor = UIColor(red: 187/255 , green: 203/255 ,blue: 255/255 , alpha: 1.0)
    }
    
}


// Class to standardize Main View Objects
class MyMainView : UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        // MyMainView.appearance().backgroundColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
    
}

// Class to standardize Primary Button Objects
class MyButtons : UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        // MyButtons.appearance().backgroundColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        self.backgroundColor = .white
        MyButtons.appearance().contentEdgeInsets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
        // MyButtons.appearance().tintColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        MyButtons.appearance().tintColor = .black
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = false
        self.titleLabel?.font = UIFont(name: "System", size: 20)
        self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
        
    
    }
    
    
}

// Class to standardize heading labels
class MyHeadingLabels: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        //MyQuestionLabels.appearance().backgroundColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        self.textColor = UIColor.black
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 35.0)
        
    }}

// Class to standardize subheading labels
class MySubHeadingLabels: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        //MyQuestionLabels.appearance().backgroundColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        self.textColor = UIColor.black
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 20.0)
        
    }}

// Class to standardize subheading labels
class MyLongFormLabels: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        //MyQuestionLabels.appearance().backgroundColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        self.textColor = UIColor.black
        self.textAlignment = .center
        self.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.numberOfLines = 0
        self.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        
    }}


// Class to style text fields
class MyTextFields : UITextField {
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        // textFieldPlaceholder()
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "placeholder", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
        ])
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 20)
        //Basic texfield Setup
          self.borderStyle = .none
          self.backgroundColor = UIColor.groupTableViewBackground // Use anycolor that give you a 2d look.

          //To apply corner radius
            self.layer.cornerRadius = 8

          //To apply border
          self.layer.borderWidth = 0.25
          self.layer.borderColor = UIColor.white.cgColor

          //To apply Shadow
          self.layer.shadowOpacity = 1
          self.layer.shadowRadius = 0.0
          self.layer.shadowOffset = CGSize.zero // Use any CGSize
          self.layer.shadowColor = UIColor.gray.cgColor
          self.layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
          self.layer.shadowOffset = CGSize(width: 0, height: 3)
          self.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor //Any dark color
    }}

// Class to standardize labels that contain the questions
class MySwitch : UISwitch {
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        //MyQuestionLabels.appearance().backgroundColor = UIColor(red: 85/255 , green: 150/255 ,blue: 100/255 , alpha: 1.0)
        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
    }
}
