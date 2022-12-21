//
//  global_functions.swift
//  PlayfairApp
//
//  Created by Yakup on 15.12.2022.
//

import Foundation
import UIKit

extension UIViewController{
    
    func setGradientBackground() {
        let colorTop =  UIColorFromRGB(rgbValue: 0x000000).cgColor
        let colorBottom = UIColorFromRGB(rgbValue: 0x4c060b).cgColor
                        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                    
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
    }
    
    func textFieldLeftImage(imageName: String, textField: UITextField){
            let imageView = UIImageView(frame: CGRect(x: 12.0, y: 8.0, width: 24.0, height: 24.0))
            let image = UIImage(named: imageName);
            imageView.contentMode = .scaleAspectFit
            imageView.image = image;
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 46, height: 40))
            view.addSubview(imageView)

            textField.leftView = view;
            textField.leftViewMode = .always

            textField.layer.cornerRadius = 18.0
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.white.cgColor
        }
    
    @objc func alertFunction(head : String, content : String){
            let warnMessage = UIAlertController(title: head, message: content, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default) { (UIAlertAction) in
            }
            warnMessage.addAction(okButton)
            self.present(warnMessage, animated: true, completion: nil)
    }
    
    func buttonBorder(button: UIButton, color: UIColor){
        button.backgroundColor = .clear
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = color.cgColor
    }
    
    func changePlaceHolder(textfield: UITextField, text: String, color: UIColor){
        textfield.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }
}
