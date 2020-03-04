//
//  movieCell.swift
//  DemoMovies
//
//  Created by Vijay A on 03/03/20.
//  Copyright © 2020 Goalsr. All rights reserved.
//

import UIKit

class movieCell: UITableViewCell {

    //MARK: IBOutlets

    @IBOutlet weak var ratingView  : UIView!
    @IBOutlet weak var movieRating : UILabel!
    @IBOutlet weak var movieName   : UILabel!
    @IBOutlet weak var movieImage  : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.ratingView.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
