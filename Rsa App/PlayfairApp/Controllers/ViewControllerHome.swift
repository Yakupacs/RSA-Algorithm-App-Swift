//
//  ViewControllerHomepage.swift
//  PlayfairApp
//
//  Created by Yakup on 15.12.2022.
//
import UIKit

class ViewControllerHome: UIViewController {
    
    @IBOutlet weak var asal1Txtfield: UITextField!
    @IBOutlet weak var asal2Txtfield: UITextField!
    @IBOutlet weak var asalCheckButton: UIButton!
    @IBOutlet weak var labelBirSayiSeciniz: UILabel!
    @IBOutlet weak var birSayiGirinizTxtfield: UITextField!
    @IBOutlet weak var eNumberButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var sifreTxtfield: UITextField!
    @IBOutlet weak var encryptDecryptButton: UIButton!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var encryptDecryptLabel: UITextView!
    
    var rsa = Rsa(p: 0, q: 0, n: 0, totient: 0, e: 0, d: 0, encryptedText: "", decryptedText: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setGradientBackground()
        
        textFieldLeftImage(imageName: "numbers", textField: asal1Txtfield)
        textFieldLeftImage(imageName: "numbers", textField: asal2Txtfield)
        textFieldLeftImage(imageName: "numbers", textField: birSayiGirinizTxtfield)
        textFieldLeftImage(imageName: "lock", textField: sifreTxtfield)
        
        asal1Txtfield.attributedPlaceholder = NSAttributedString(
            string: "1.Asal sayıyı giriniz",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        asal2Txtfield.attributedPlaceholder = NSAttributedString(
            string: "2.Asal sayıyı giriniz",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        birSayiGirinizTxtfield.attributedPlaceholder = NSAttributedString(
            string: "Bir sayı giriniz",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        sifreTxtfield.attributedPlaceholder = NSAttributedString(
            string: "Şifrelenecek Metin",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )

        buttonBorder(button: eNumberButton, color: .white)
        buttonBorder(button: asalCheckButton, color: .white)
        buttonBorder(button: clearButton, color: .white)
        buttonBorder(button: encryptDecryptButton, color: .white)
    }
    
    @IBAction func asalSayiCheckButton(_ sender: Any){
        if let myNumber = NumberFormatter().number(from: asal1Txtfield.text!) {
            rsa.p = myNumber.intValue
        }
        if let myNumber = NumberFormatter().number(from: asal2Txtfield.text!) {
            rsa.q = myNumber.intValue
        }
        
        if rsa.pqIsPrime(){
            infoText.text = rsa.printStatus()
            calculateNAndTotientStep()
        }
        else{
            alertFunction(head: "Uyarı!", content: "Lütfen asal sayı giriniz.")
        }
    }
    
    func calculateNAndTotientStep()
    {
        asal2Txtfield.isHidden = true
        asal1Txtfield.isHidden = true
        asalCheckButton.isHidden = true
        
        rsa.calculateNAndTotient()
        infoText.text = rsa.printStatus()

        labelBirSayiSeciniz.text = "1 < e < \(rsa.totient) kuralına uyarak \(rsa.totient) ile aralarında asal bir e sayısı giriniz."

        labelBirSayiSeciniz.isHidden = false
        birSayiGirinizTxtfield.isHidden = false
        eNumberButton.isHidden = false
    }

    @IBAction func eNumberFunc(_ sender: Any) {
        if let myNumber = NumberFormatter().number(from: birSayiGirinizTxtfield.text!) {
            rsa.e = myNumber.intValue
        }

        if rsa.e <= 1 && rsa.e >= rsa.totient{
            alertFunction(head: "Uyarı!", content: "1 < e < \(rsa.totient) kuralına uyarak \(rsa.totient) ile aralarında asal bir e sayısı giriniz.")
            birSayiGirinizTxtfield.text = ""
        }
        else{
            if (rsa.checkE()){
                calculateDFunc()
                infoText.text = rsa.printStatus()
            }
            else{
                alertFunction(head: "Uyarı!", content: "1 < e < \(rsa.totient) kuralına uyarak \(rsa.totient) ile aralarında asal bir e sayısı giriniz.")
                birSayiGirinizTxtfield.text = ""
            }
        }
    }
    
    func calculateDFunc(){
        rsa.calculateD()
        infoText.text = rsa.printStatus()
        
        birSayiGirinizTxtfield.isHidden = true
        labelBirSayiSeciniz.isHidden = true
        eNumberButton.isHidden = true
        segmentedControl.isHidden = false
        sifreTxtfield.isHidden = false
        encryptDecryptButton.isHidden = false
    }
    
    @IBAction func encrypDecryptFunc(_ sender: Any) {
        rsa.encryptedText = ""
        rsa.decryptedText = ""
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            if (sifreTxtfield.text != ""){
                encryptDecryptLabel.isHidden = false
                rsa.encryption(textfield: sifreTxtfield)
                encryptDecryptLabel.text = "Şifre: \(rsa.encryptedText)"
            }
            else{
                alertFunction(head: "Uyarı!", content: "Lütfen şifrelenecek metni giriniz.")
            }
        case 1:
            if (sifreTxtfield.text != ""){
                encryptDecryptLabel.isHidden = false
                rsa.decryption(textfield: sifreTxtfield)
                encryptDecryptLabel.text = "Çözülen Şifre: \(rsa.decryptedText)"
            }
            else{
                alertFunction(head: "Uyarı!", content: "Lütfen deşifrelenecek metni giriniz.")
            }
        default:
            break
        }
    }
    
    @IBAction func segmentIndexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            changePlaceHolder(textfield: sifreTxtfield, text: "Şifrelenecek Metin", color: .gray)
            sifreTxtfield.text = ""
            textFieldLeftImage(imageName: "lock", textField: sifreTxtfield)
            encryptDecryptButton.setTitle("Şifre Oluştur", for: .normal)
        case 1:
            changePlaceHolder(textfield: sifreTxtfield, text: "Virgüllü Deşifrelenecek Sayılar", color: .gray)
            sifreTxtfield.text = ""
            textFieldLeftImage(imageName: "unlock", textField: sifreTxtfield)
            encryptDecryptButton.setTitle("Şifre Çöz", for: .normal)
        default:
            break
        }
    }
    
    @IBAction func clearFunc(_ sender: Any) {
        rsa.clearRSA()
        
        asal1Txtfield.text = ""
        asal2Txtfield.text = ""
        birSayiGirinizTxtfield.text = ""
        sifreTxtfield.text = ""
        birSayiGirinizTxtfield.isHidden = true
        eNumberButton.isHidden = true
        labelBirSayiSeciniz.isHidden = true
        segmentedControl.isHidden = true
        sifreTxtfield.isHidden = true
        encryptDecryptButton.isHidden = true
        encryptDecryptLabel.isHidden = true
        asal1Txtfield.isHidden = false
        asal2Txtfield.isHidden = false
        asalCheckButton.isHidden = false
        infoText.text = "p = ?, q = ?, n = ?, totient = ?, e = ?, d = ?"
    }
}

