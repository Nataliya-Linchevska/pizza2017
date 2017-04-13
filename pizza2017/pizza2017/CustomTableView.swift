//
//  CustomTableView.swift
//  pizza2017
//
//  Created by Sergiy Sobol on 12.04.17.
//  Copyright © 2017 GeekHub. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTableView: UIView {
    
    var backgroundImageView = UIImageView()
    var selectedImageView = UIImageView()
    
    @IBInspectable var isSelected : Bool = false {
        didSet {
            selectedImageView.isHidden = !isSelected
        }
    }
    
    @IBInspectable var backgroundImage: UIImage? {
        didSet{
            backgroundImageView.frame.origin = CGPoint(x: 0, y: 0)
            backgroundImageView.frame.size = self.frame.size
            backgroundImageView.image = backgroundImage
            backgroundImageView.contentMode = .scaleAspectFit
            self.addSubview(backgroundImageView)
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
        isSelected = !isSelected
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
