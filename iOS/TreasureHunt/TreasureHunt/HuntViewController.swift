//
//  HuntViewController.swift
//  TreasureHunt
//
//  Created by Tim Colla on 05/11/2016.
//  Copyright © 2016 Marinosoftware. All rights reserved.
//

import UIKit
import CoreLocation

class HuntViewController: UIViewController, LocationManagerDelegate {
    @IBOutlet weak var hintLabel: UILabel!
    
    let locationManager = LocationManager()
    
    override func viewDidLoad() {
        locationManager.delegate = self
    }
    
    @IBAction func tryLocationButton(_ sender: UIButton) {
        /*UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
        message:@"This is an alert."
        preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];*/
        
        let alert = UIAlertController(title: "Fee", message: "Trying a location will cost a 40000 Satoshi fee.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("API call")
            
            self.locationManager.requestLocation()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: {})
        }
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true) {}
    }
    
    func didUpdate(location: CLLocation) {
        let ourSession = URLSession(configuration: .default)
        var someRequest = URLRequest(url: URL(string:"http://46.101.80.224/")!)
        
        someRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        someRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        someRequest.httpMethod = "POST"
        someRequest.httpBody = try! JSONSerialization.data(withJSONObject: ["latitude":location.coordinate.latitude, "longitude":location.coordinate.longitude], options: [])
        
        let task = ourSession.dataTask(with: someRequest) {
            (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                print(response)
            } else {
                
                if let error = error {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func didFail() {
        
    }
}
