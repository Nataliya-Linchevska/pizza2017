//
//  SettingsViewController.swift
//  pizza2017
//
//  Created by user on 22.02.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit
import MapKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        SettingsFirebase.getTasksFromFirebase {
            self.reloadView(taskSettings: SettingsFirebase.taskSettings!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
        // заповнення полів на екрані
    func reloadView(taskSettings: SettingsModel) {
        let taskSettings = taskSettings
        lblAddress.text = taskSettings.address
        lblEmail.text = "Email: " + taskSettings.email
        lblPhone.text = "Телефон: " + taskSettings.phone
        
        // карта
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.1, 0.1)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(taskSettings.latitude), CLLocationDegrees(taskSettings.longitude))
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        map.setRegion(region, animated: true)
        
        // надпис на карті
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "BEST PIZZA"
        annotation.subtitle = "самая вкусная пицца"
        map.addAnnotation(annotation)
    }
}
