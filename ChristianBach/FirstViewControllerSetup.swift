//
//  FirstViewControllerSetup.swift
//  ChristianBach
//
//  Created by Christian Emil Bach on 13/11/2019.
//  Copyright © 2019 Christian Emil Bach. All rights reserved.
//

import UIKit

class FirstViewControllerSetup: UIViewController {

     @IBOutlet weak var profileImageView: UIView!
       @IBOutlet weak var nameLabel: UILabel!
       @IBOutlet weak var positionLabel: UILabel!
       @IBOutlet weak var phoneNumberView: UIView!
       @IBOutlet weak var emailView: UIView!
       @IBOutlet weak var aboutmeView: UIView!
       @IBOutlet weak var navigationBar: UINavigationBar!
       
       
       
       override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
           
           
           view.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.7, alpha: 1)
           nameLabel.font = UIFont(name: "Pacifico-Regular", size: 40.0)
           let tap = UITapGestureRecognizer(target: self, action: #selector(self.presentAboutMe(_:)))
           aboutmeView.addGestureRecognizer(tap)
           
           // profileImageView setup
           profileImageView?.layer.cornerRadius = (profileImageView?.frame.size.width ?? 0.0) / 2
           profileImageView?.clipsToBounds = true
           profileImageView?.layer.borderWidth = 40.0
           profileImageView?.layer.borderColor = UIColor.white.cgColor
           
           // Personal details setup
           phoneNumberView.layer.cornerRadius = 25.0
           emailView.layer.cornerRadius = 25.0
           aboutmeView.layer.cornerRadius = 25.0

           
           navigationBar.barTintColor = UIColor(red: 0.1, green: 0.4, blue: 0.7, alpha: 1)
           
           
           
           
           
       }
       
       @objc func presentAboutMe(_ sender: UITapGestureRecognizer? = nil) {
           let aboutmeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutMeView") as! AboutMeViewController
           self.addChild(aboutmeVC)
           aboutmeVC.view.frame = self.view.frame
           self.view.addSubview(aboutmeVC.view)
           aboutmeVC.didMove(toParent: self)
           
       }
       

}
