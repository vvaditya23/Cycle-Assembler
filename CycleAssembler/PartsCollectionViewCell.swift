//
//  PartsCollectionViewCell.swift
//  CycleAssembler
//
//  Created by Aditya Vyavahare(ヴィヤヴャハレ・アディティア) on 30/08/23.
//

import UIKit

class PartsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var partImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ProductDescription: UITextView!
    @IBOutlet weak var checkBoxView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with part: PartDataModel) {
        partImageView.image = part.image
        nameLabel.text = part.name
        ProductDescription.text = part.description
    }
}
