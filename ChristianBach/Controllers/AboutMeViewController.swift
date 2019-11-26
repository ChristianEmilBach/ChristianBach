//
//  AboutMeViewController.swift
//  ChristianBach
//
//  Created by Christian Emil Bach on 12/11/2019.
//  Copyright © 2019 Christian Emil Bach. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {
    
    @IBOutlet weak var aboutmeView: UIView!
    @IBOutlet weak var aboutmeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.85)
        
        aboutmeView.layer.cornerRadius = 30.0
        
        self.showAnimate()
        
        aboutmeTextView.text = "Hi! My name is Christian and I am a first-semester student in Global Business Informatics at the IT-University. \n\nMy interest for programming and iOS, in particular, came during my second gap year when the greatest idea for an app just popped into my head, but when I later discovered how expensive they were to make I decided to buy an online course that promised to make me a professional iOS developer in just a matter of weeks. To make a long story short, the app idea didn't seem as clever after further reflection, and it wasn't quite as easy to learn programming as expected but what started as just a boring skill actually became a bit of a hobby. \n\nBecause of this I applied to be enrolled at ITU and thankfully did. \n\nIt's in no way only the coding part that interests me. The whole way IT shapes our society today, in good or bad, fascinates me and I am sure a part-time job within the area would benefit me immensely. As well as I would love the opportunity to put my skills into practice."
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.aboutmeTextView.setContentOffset(CGPoint.zero, animated: false)
    }

}
