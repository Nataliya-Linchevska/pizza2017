

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tvNews: UITextView!
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
