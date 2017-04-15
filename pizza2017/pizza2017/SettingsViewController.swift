
import UIKit
import MapKit

class SettingsViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var shadowMapView: UIView!
    
    
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
            
            // фон
            let gradient = CAGradientLayer()
            gradient.frame = self.gradientView.bounds
            gradient.colors = [UIColor(colorLiteralRed: 21/255.0, green: 136/255.0, blue: 18/255.0, alpha: 1).cgColor, UIColor(colorLiteralRed: 254/255.0, green: 244/255.0, blue: 85/255.0, alpha: 1).cgColor]
            self.gradientView.layer.addSublayer(gradient)
            
            // заокруглення
            self.shadowMapView.layer.shadowOpacity = 0.8
            self.shadowMapView.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
            self.shadowMapView.layer.cornerRadius = 22
            self.map.layer.cornerRadius = 22


            
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
