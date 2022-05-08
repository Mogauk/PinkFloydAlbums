//
//  AlbumTableViewCell.swift
//  PinkFloydAlbums
//
//  Created by Alexey on 5/4/22.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var albumCoverImageView: UIImageView! {
        didSet {
            albumCoverImageView.layer.cornerRadius = albumCoverImageView.bounds.width / 2
            albumCoverImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet var favoriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // change checkmark color
        self.tintColor = .systemYellow
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
