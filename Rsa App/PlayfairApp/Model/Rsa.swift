//
//  Rsa.swift
//  PlayfairApp
//
//  Created by Yakup on 18.12.2022.
//

import Foundation
import UIKit

var alphabetToNum = ["a":0, "b":1, "c":2, "d":3, "e":4, "f":5, "g":6, "h":7, "i":8, "j":9, "k":10, "l":11, "m":12, "n":13, "o":14, "p":15, "r":16, "s":17, "t":18, "u":19, "v":20, "y":21, "z":22]

class Rsa{
    var p = Int()
    var q = Int()
    var n = Int()
    var totient = Int()
    var e = Int()
    var d = Int()
    var encryptedText = String()
    var decryptedText = String()
    
    init(p: Int = Int(), q: Int = Int(), n: Int = Int(), totient: Int = Int(), e: Int = Int(), d: Int = Int(), encryptedText: String = String(), decryptedText: String = String()) {
        self.p = p
        self.q = q
        self.n = n
        self.totient = totient
        self.e = e
        self.d = d
        self.encryptedText = encryptedText
        self.decryptedText = decryptedText
    }
    
    func printStatus() -> String{
        return "p = \(self.p), q = \(self.q), n = \(self.n), totient = \(self.totient), e = \(self.e), d = \(self.d)"
    }
    
    func pqIsPrime() -> Bool{
        if isPrime(self.p) && isPrime(self.q){
            return true
        }
        else{
            return false
        }
    }
    
    func calculateNAndTotient(){
        self.n = self.p * self.q
        self.totient = (self.p - 1) * (self.q - 1)
    }
    
    func checkE() -> Bool{
        var sign = 0
        
        var totientFactors = factors(of: self.totient)
        var eFactors = factors(of: self.e)
        
        totientFactors.remove(at: 0)
        eFactors.remove(at: 0)
        
        for t in totientFactors{
            for e in eFactors{
                if e == t{
                    sign = 1
                    break
                }
            }
            if (sign == 1){
                break
            }
        }
        if (sign == 1){
            return false
        }
        else{
            return true
        }
    }
    
    func calculateD(){
        for i in 1...1000000{
            if (self.totient * i + 1) % self.e == 0{
                self.d = ((self.totient * i + 1) / self.e)
                break
            }
        }
    }
    
    func encryption(textfield: UITextField){
        var count = 0
        let cipher = textfield.text?.lowercased()
        let characters = [Character](cipher!)
        for i in characters{
            for k in alphabetToNum{
                if String(i) == k.key{
                    let num = pow(k.value, e) % n
                    encryptedText.append(String(num))
                    count += 1
                    if count != characters.count{
                        encryptedText.append(",")
                    }
                }
            }
        }
    }
    
    func decryption(textfield: UITextField){
        let cipherTextfieldArray = textfield.text!.components(separatedBy: ",")
        var cipherIntArray = [Int]()
        var cipherCharArray = [Character]()
        for i in cipherTextfieldArray{
            cipherIntArray.append(pow(Int(i)!, d) % n)
        }
        for i in cipherIntArray{
            for k in alphabetToNum{
                if k.value == i{
                    cipherCharArray.append(Character(k.key))
                }
            }
        }
        for i in cipherCharArray{
            decryptedText.append(i)
        }
    }
    
    func clearRSA(){
        self.p = 0
        self.q = 0
        self.n = 0
        self.totient = 0
        self.e = 0
        self.d = 0
        self.encryptedText = ""
        self.decryptedText = ""
    }
}


extension Rsa{
    func isPrime(_ number: Int) -> Bool {
        return number > 1 && !(2..<number).contains { number % $0 == 0 }
    }
    
    func factors(of n: Int) -> [Int] {
        precondition(n > 0, "n must be positive")
        let sqrtn = Int(Double(n).squareRoot())
        var factors: [Int] = []
        factors.reserveCapacity(2 * sqrtn)
        for i in 1...sqrtn {
            if n % i == 0 {
                factors.append(i)
            }
        }
        var j = factors.count - 1
        if factors[j] * factors[j] == n {
            j -= 1
        }
        while j >= 0 {
            factors.append(n / factors[j])
            j -= 1
        }
        return factors
    }
    
    func pow(_ x: Int, _ y: Int) -> Int {
      var result = 1
      for _ in 0..<y {
          result *= x
      }
      return result
    }
}
