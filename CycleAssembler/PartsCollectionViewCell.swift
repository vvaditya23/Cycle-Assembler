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
    @IBOutlet weak var checkboxButton: UIButton!
    
    var isChecked: Bool = false // Keep track of checkbox state
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkboxButton.setImage(UIImage(named: "ic_unchecked"), for: .normal)
        partImageView.tintColor = .black
        // Customize cell selection style
                selectedBackgroundView = UIView()
                selectedBackgroundView?.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2) // Customize the highlight color
    }
    
    func configure(with part: PartDataModel) {
        partImageView.image = part.image
        nameLabel.text = part.name
        ProductDescription.text = part.description
    }
    
    @IBAction func checkboxButtonTapped(_ sender: UIButton) {
            isChecked = !isChecked
            checkboxButton.setImage(isChecked ? UIImage(named: "ic_checked") : UIImage(named: "ic_unchecked"), for: .normal)
        }
}
