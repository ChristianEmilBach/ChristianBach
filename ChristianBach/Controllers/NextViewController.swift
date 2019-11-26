//
//  NextViewController.swift
//  ChristianBach
//
//  Created by Christian Emil Bach on 14/11/2019.
//  Copyright © 2019 Christian Emil Bach. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    

    @IBOutlet weak var firstApp: UIButton!
    @IBOutlet weak var secondApp: UIButton!
    @IBOutlet weak var thirdApp: UIButton!

    
    
    @IBAction func returnToFirstVC(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
    }
    
    func setupAppViews() {
        firstApp.layer.cornerRadius = (firstApp.frame.size.width ) / 6
        firstApp.clipsToBounds = true
        
        secondApp.layer.cornerRadius = (secondApp.frame.size.width ) / 6
        secondApp.clipsToBounds = true
        
        thirdApp.layer.cornerRadius = (thirdApp.frame.size.width ) / 6
        thirdApp.clipsToBounds = true
        
    }
    
    
    
    
    @IBAction func bmiBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ShowBMICalculator", sender: self)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        setupAppViews()
    }
    
    @IBAction func MLBtn(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToImageRecognizer", sender: self)
    }
    
    
    @IBAction func climaButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToClima", sender: self)
    }
    
}
