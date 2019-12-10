//
//  ViewController.swift
//  ChristianBach
//
//  Created by Christian Emil Bach on 03/11/2019.
//  Copyright © 2019 Christian Emil Bach. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var profileImageView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var aboutmeView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        nameLabel.font = UIFont(name: "Pacifico-Regular", size: 10.0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.presentAboutMe(_:)))
        aboutmeView.addGestureRecognizer(tap)
        
        let tapForNextVC = UITapGestureRecognizer(target: self, action: #selector(self.performSegueToNextVC(_:)))
        profileImageView.addGestureRecognizer(tapForNextVC)
        
        let mailTap = UITapGestureRecognizer(target: self, action: #selector(self.sendMail(_:)))
        emailView.addGestureRecognizer(mailTap)
        
        let callTap = UITapGestureRecognizer(target: self, action: #selector(self.phoneCall))
        phoneNumberView.addGestureRecognizer(callTap)
        
        // Personal details setup
        phoneNumberView.layer.cornerRadius = 25.0
        phoneNumberView.layer.borderColor = UIColor.white.cgColor
        phoneNumberView.layer.borderWidth = 2.0
        emailView.layer.cornerRadius = 25.0
        emailView.layer.borderColor = UIColor.white.cgColor
        emailView.layer.borderWidth = 2.0
        aboutmeView.layer.cornerRadius = 25.0

    }
    
    override func viewDidLayoutSubviews() {
                // profileImageView setup
                profileImageView?.layer.cornerRadius = (profileImageView?.frame.size.width ?? 0.0) / 2
                profileImageView?.clipsToBounds = true
                profileImageView?.layer.borderWidth = 40.0
                profileImageView?.layer.borderColor = UIColor.white.cgColor
                profileImageView.isUserInteractionEnabled = true
    }
    
    
    @objc func presentAboutMe(_ sender: UITapGestureRecognizer? = nil) {
        let aboutmeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AboutMeView") as! AboutMeViewController
        self.addChild(aboutmeVC)
        aboutmeVC.view.frame = self.view.frame
        self.view.addSubview(aboutmeVC.view)
        aboutmeVC.didMove(toParent: self)
        
    }
    
    @objc func performSegueToNextVC(_ sender: UITapGestureRecognizer? = nil) {
        self.performSegue(withIdentifier: "ShowNewVC", sender: self)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        view.setGradientBackground(colorOne: Colors.darkBlue, colorTwo: Colors.brightBlue)
        super.viewWillAppear(animated)
    }
    
    
    //MARK:- Send Email Function
    
    @objc func sendMail(_ sender: UITapGestureRecognizer? = nil) {
        let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                print("Not possible to send mail")
            }
        }

        func configuredMailComposeViewController() -> MFMailComposeViewController {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.delegate = self as? UINavigationControllerDelegate
            mailComposerVC.setToRecipients(["Christian.bach@live.dk"])
            mailComposerVC.setSubject("Junior iOS Developer")
            mailComposerVC.setMessageBody("", isHTML: false)

            return mailComposerVC
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true, completion: nil)
        }
    
    @objc func phoneCall(_ sender: UITapGestureRecognizer? = nil) {
        if let url = URL(string: "tel://\(31951415)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
