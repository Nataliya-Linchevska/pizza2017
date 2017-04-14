
import UIKit
import MapKit

class SettingsViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    private var firebaseHelper = SettingsFirebase()
    
    //MARK: Virtual functions
    
    override func viewDidLoad() {
       super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //activityIndicator.startAnimating()
        firebaseHelper.initFirebaseObserve { (settings) in
            self.reloadView(taskSettings: settings)
            //self.activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        firebaseHelper.deinitObserve()
    }
    
    //MARK: General functions
    
    // заповнення полів на екрані
    private func reloadView(taskSettings: SettingsModel) {
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
