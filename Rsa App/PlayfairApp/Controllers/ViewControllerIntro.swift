//
//  ViewController.swift
//  PlayfairApp
//
//  Created by Yakup on 15.12.2022.
//

import UIKit

class ViewControllerIntro: UIViewController {

    var timer = Timer()
    var myTime = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
    }

    @objc func timerFunc(){
        myTime -= 1
        if (myTime == 0)
        {
            timer.invalidate()
            performSegue(withIdentifier: "toStart", sender: nil)
            myTime = 2
        }
    }
}

