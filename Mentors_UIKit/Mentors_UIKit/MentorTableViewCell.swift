//
//  MentorTableViewCell.swift
//  Mentors_UIKit
//
//  Created by Giovanni Monaco on 22/03/23.
//

import UIKit

class MentorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameSurnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code.
        // Shows the disclosure indicator in the row.
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state.
    }
    
    // Updates the lables and the image.
    func update(with mentor: Mentor) {
        nameSurnameLabel.text = mentor.name + " " + mentor.surname
        if let image = UIImage(named: mentor.imageName) {
            profileImageView.image = image
        } else {
            profileImageView.image = UIImage(named: "empty")
        }
    }

}
