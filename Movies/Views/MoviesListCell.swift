//
//  MoviesListCell.swift
//  Movies
//
//  Created by Mujahid Ali on 17/12/21.
//

import UIKit
import SDWebImage

class MoviesListCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var ivLeft: UIImageView!
    @IBOutlet weak var btnRating: UIButton!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 16.0
        selectionStyle = .none
    }
    func cellConfig(res: MoviesList?) {
        if let url = res?.poster_path, let finalUrl = URL(string: "\(Constants.IMAGE_BASE_URL)\(url)") {
            ivLeft.sd_setImage(with: finalUrl, placeholderImage: UIImage(named: Constants.Images.PLACEHOLDER_IMAGE), completed: nil)
        }
        lblHeading.setValue(val: res?.title)
        lblDescription.setValue(val: res?.overview)
        if let rating = res?.vote_average {
            btnRating.isHidden = false
            btnRating.setImage(UIImage(named: Constants.Images.RATING_IAMGE), for: .normal)
            let ratingOneDecimalPlace = (((rating * 10)).rounded())/10
            btnRating.setTitle("\(ratingOneDecimalPlace)", for: .normal)
            
        }else {
            btnRating.isHidden = true
        }
    }
}

extension UILabel {
    func setValue(val: String?) {
        if let unwrappedValue = val {
            self.isHidden = false
            self.text = unwrappedValue
        }else {
            self.isHidden = true
        }
    }
}
