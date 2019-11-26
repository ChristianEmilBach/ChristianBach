//
//  MLViewController.swift
//  ChristianBach
//
//  Created by Christian Emil Bach on 19/11/2019.
//  Copyright © 2019 Christian Emil Bach. All rights reserved.
//

import UIKit
import CoreML
import Vision

class MLViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var tryAgainArrow: UIImageView!
    @IBOutlet weak var tapToTryAgain: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var MLImageView: UIImageView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var isItCorrectLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground(colorOne: UIColor.white, colorTwo: UIColor.white)
        
        //Hide show again scene
        tapToTryAgain.isHidden = true
        tryAgainArrow.isHidden = true
        
        isItCorrectLabel.font = UIFont(name: "FjallaOne-Regular", size: 25.0)
        tapToTryAgain.font = UIFont(name: "FjallaOne-Regular", size: 15.0)
        
        resultLabel.font = UIFont(name: "FjallaOne-Regular", size: 20.0)
        resultLabel.text = "Take a image of something and I will tell you exactly what it is. \n\nBut do keep in mind that I am just a phone, so please don't turn me off if I'm wrong..\n"
        
        questionView.isHidden = true
        questionView.layer.cornerRadius = 30.0
        questionView.layer.masksToBounds = true
        questionView.setGradientBackground(colorOne: Colors.darkOrange, colorTwo: Colors.brightOrange)

        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        iconImage.layer.cornerRadius = iconImage.frame.width / 2
        iconImage.layer.masksToBounds = true
        
        MLImageView.layer.masksToBounds = false
        MLImageView.layer.shadowColor = UIColor.black.cgColor
        MLImageView.isHidden = true
    
     MLImageView.layer.shadowPath = UIBezierPath(rect: MLImageView.bounds).cgPath
     MLImageView.layer.shadowRadius = 20
     MLImageView.layer.shadowOffset = .zero
     MLImageView.layer.shadowOpacity = 1
        
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            MLImageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert UIImage to CIImage")
            }
            
            detect(image: ciimage)
            
            MLImageView.isHidden = false

            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    
    }
    
  
            
     func setView(view: UIView, hidden: Bool) {
         UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
             view.isHidden = hidden
         })
     }
    
    
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
        
            if let firstResult = results.first {
                if firstResult.confidence >= 0.65 {
                    self.resultLabel.text = ("I am pretty sure this is a \n" + (firstResult.identifier))
                    print(firstResult.confidence)
                    //Make question appear
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.setView(view: self.questionView, hidden: false)
                }
                } else if firstResult.confidence <= 0.64 && firstResult.confidence >= 0.10 {
                    self.resultLabel.text = ("I think this is a \n" + (firstResult.identifier))
                    print(firstResult.identifier)
                    print(firstResult.confidence)
                    //Make question appear
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.setView(view: self.questionView, hidden: false)
                    }
                    
                } else {
                    self.resultLabel.text = ("I have no idea what that is. Please try again")
                    print(firstResult.identifier)
                    print(firstResult.confidence)
                    self.questionView.isHidden = true
                    self.showTryAgain()
                }
                
            }
            

           
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
            try handler.perform([request])
        }
        catch {
            print(error)
        }
        
        tryAgainArrow.isHidden = true
        tapToTryAgain.isHidden = true
        
    }
    

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func returnToApps(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
   
    @IBAction func correctButton(_ sender: UIButton) {
        self.resultLabel.text = "Too easy😎"
        setView(view: questionView, hidden: true)
        let knewItGif = UIImage.gif(name: "giphy.knewit")
        MLImageView.image = knewItGif
        MLImageView.layer.shadowOpacity = 0.4
        showTryAgain()
    }
    
    
    @IBAction func wrongButton(_ sender: UIButton) {
        self.resultLabel.text = "..."
        setView(view: questionView, hidden: true)
        let dammitGif = UIImage.gif(name: "giphy.damnit")
        MLImageView.image = dammitGif
        MLImageView.layer.shadowOpacity = 0.4
        showTryAgain()
        
    }
    
    func showTryAgain() {
        tryAgainArrow.isHidden = false
        tapToTryAgain.isHidden = false
    }
    
    
}


