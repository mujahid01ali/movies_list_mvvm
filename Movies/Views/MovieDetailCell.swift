//
//  MovieDetailCell.swift
//  Movies
//
//  Created by Mujahid Ali on 17/12/21.
//

import UIKit

class MovieDetailCell: UITableViewCell {
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var ivBanner: UIImageView!
    @IBOutlet weak var lblBy: UILabel!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var ivTop: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivBanner.layer.cornerRadius = 8.0
        ivTop.layer.cornerRadius = 8.0
    }
    
    func cellConfig(res: MoviesList?) {
        lblHeading.setValue(val: res?.title)
        lblBy.setValue(val: Constants.Release_Date + "\(res?.release_date ?? "")")
        lblOverview.setValue(val: res?.overview)
        if let url = res?.backdrop_path, let finalUrl = URL(string: "\(Constants.IMAGE_BASE_URL)\(url)") {
            ivTop.sd_setImage(with: finalUrl, placeholderImage: UIImage(named: Constants.Images.PLACEHOLDER_IMAGE), completed: nil)
        }
        if let url = res?.poster_path, let finalUrl = URL(string: "\(Constants.IMAGE_BASE_URL)\(url)") {
            ivBanner.sd_setImage(with: finalUrl, placeholderImage: UIImage(named: Constants.Images.PLACEHOLDER_IMAGE), completed: nil)
        }
        
    }
    
}
