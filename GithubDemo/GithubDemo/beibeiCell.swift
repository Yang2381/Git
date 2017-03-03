//
//  beibeiCell.swift
//  GithubDemo
//
//  Created by Yawen on 16/2/2017.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class beibeiCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forkImage: UIImageView!
    
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var owner: UILabel!
    
    //Another way to set values
    var github: GithubRepo!{
        didSet{
            titleLabel.text = github.name
            starLabel.text = String(describing: github.stars!)
            forkLabel.text = String(describing: github.forks!)
            descriptionLabel.text = github.descript!
            forkImage.image = UIImage(named: "fork")
            
        }
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
               // Initialization code
        pictureView.layer.cornerRadius = 5
        pictureView.clipsToBounds = true
        starImage.image = UIImage(named: "star")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
       

}
