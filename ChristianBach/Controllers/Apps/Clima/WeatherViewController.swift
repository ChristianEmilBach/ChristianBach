//
//  WeatherViewController.swift
//  ChristianBach
//
//  Created by Christian Emil Bach on 19/11/2019.
//  Copyright © 2019 Christian Emil Bach. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextfield: UITextField!

    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextfield.delegate = self
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
        
    }
    

    @IBAction func returnToApps(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
}

//MARK:- UITextfieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
           searchTextfield.endEditing(true)
           
       }
       
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           searchTextfield.endEditing(true)
           print(searchTextfield.text!)
           return true
       }
       
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           if textField.text != "" {
               return true
           } else {
               textField.placeholder = "Type something"
               return false
           }
       }
       
       func textFieldDidEndEditing(_ textField: UITextField) {
           // Use searchfield.text to get weather for city.
           if let city = searchTextfield.text {
               weatherManager.fetchWeather(cityName: city)
           }
           
           searchTextfield.text = ""
       }
    
}



//MARK:- Weather Manager Delegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            if #available(iOS 13.0, *) {
                self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK:- CLLocation Manager Delegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

extension WeatherViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WeatherViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
