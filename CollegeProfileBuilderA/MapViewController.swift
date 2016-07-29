//
//  MapViewController.swift
//  CollegeProfileBuilderA
//
//  Created by Saurav Desai on 7/27/16.
//  Copyright © 2016 Saurav Desai. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textField: UITextField!
    var university : College!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = university.name
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(textField.text!) { (placemarks, error) in
            if error != nil{
                print(error)
            }
            else{
                if placemarks?.count > 1{
                    let actionController = UIAlertController(title: "Select a Location", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
                    for i in 0..<placemarks!.count{
                        let anOption = UIAlertAction(title: "\(self.textField.text!), \(placemarks![i].administrativeArea!)", style: .Default) { (action) in
                            let placemark : CLPlacemark = placemarks![i] as CLPlacemark!
                            let center = placemark.location!.coordinate
                            let span = MKCoordinateSpanMake(0.1, 0.1)
                            self.displayMap(center, span: span, pinTitle: self.textField.text!)
                        }
                        actionController.addAction(anOption)
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                    actionController.addAction(cancelAction)
                    self.presentViewController(actionController, animated: true, completion: nil)
                }
                else{
                    let placemark : CLPlacemark = placemarks!.first as CLPlacemark!
                    let center = placemark.location!.coordinate
                    let span = MKCoordinateSpanMake(0.1, 0.1)
                    self.displayMap(center, span: span, pinTitle: self.textField.text!)
                }
            }
        }
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(textField.text!) { (placemarks, error) in
            if error != nil{
                print(error)
            }
            else{
                if placemarks!.count > 1{
                    let actionController = UIAlertController(title: "Select a Location", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
                    for i in 0..<placemarks!.count{
                        let anOption = UIAlertAction(title: "\(self.textField.text!), \(placemarks![i].administrativeArea!)", style: .Default) { (action) in
                            let placemark : CLPlacemark = placemarks![i] as CLPlacemark!
                            let center = placemark.location!.coordinate
                            let span = MKCoordinateSpanMake(0.1, 0.1)
                            self.displayMap(center, span: span, pinTitle: self.textField.text!)
                        }
                        actionController.addAction(anOption)
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                    actionController.addAction(cancelAction)
                    self.presentViewController(actionController, animated: true, completion: nil)
                }
                else{
                    let placemark : CLPlacemark = placemarks!.first as CLPlacemark!
                    let center = placemark.location!.coordinate
                    let span = MKCoordinateSpanMake(0.1, 0.1)
                    self.displayMap(center, span: span, pinTitle: self.textField.text!)
                }
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    func displayMap(center : CLLocationCoordinate2D, span : MKCoordinateSpan, pinTitle : String){
        let region = MKCoordinateRegionMake(center, span)
        let pin = MKPointAnnotation()
        pin.coordinate = center
        pin.title = pinTitle
        mapView.addAnnotation(pin)
        mapView.setRegion(region, animated: true)
    }
}
