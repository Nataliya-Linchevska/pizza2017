
import UIKit

protocol TableSelectDelegate {
    func tableSelected(tableId: String)
}

@IBDesignable
class CustomTableView: UIView {
    
    var backgroundImageView = UIImageView()
    var selectedImageView = UIImageView()
    var reservedImageView = UIImageView()
    
    var tableId: String?
    
    var delegate: TableSelectDelegate?
    var lblTableNumber: UILabel?
    
    @IBInspectable var isSelected : Bool = false {
        didSet {
            selectedImageView.isHidden = !isSelected
        }
    }
    
    @IBInspectable var isReserved : Bool = false {
        didSet {
            reservedImageView.isHidden = !isReserved
        }
    }
    
    @IBInspectable var backgroundImage: UIImage? {
        didSet{
            backgroundImageView.frame.origin = CGPoint(x: 0, y: 0)
            backgroundImageView.frame.size = self.frame.size
            backgroundImageView.image = backgroundImage
            backgroundImageView.contentMode = .scaleAspectFit
            
            lblTableNumber = UILabel(frame: backgroundImageView.frame)
            lblTableNumber?.textAlignment = .center
            
            self.addSubview(backgroundImageView)
            self.addSubview(lblTableNumber!)
        }
    }
    
    @IBInspectable var selectedImage: UIImage? {
        didSet{
            selectedImageView.frame.origin = CGPoint(x: self.frame.size.width - 40, y: self.frame.size.height - 40)
            selectedImageView.frame.size = CGSize(width: 30, height: 30)
            selectedImageView.image = selectedImage
            selectedImageView.contentMode = .scaleAspectFit
            self.addSubview(selectedImageView)
        }
    }
    
    @IBInspectable var reservedImage: UIImage? {
        didSet{
            reservedImageView.frame = backgroundImageView.frame
            reservedImageView.image = reservedImage
            reservedImageView.contentMode = .scaleAspectFit
            self.addSubview(reservedImageView)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapOnView))
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapOnView() {
        if(isReserved) {return}
        
        isSelected = !isSelected
        delegate?.tableSelected(tableId: tableId!)
    }

}
