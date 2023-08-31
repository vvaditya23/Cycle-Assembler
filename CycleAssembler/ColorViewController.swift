//
//  ColorViewController.swift
//  CycleAssembler
//
//  Created by Aditya Vyavahare(ヴィヤヴャハレ・アディティア) on 31/08/23.
//

import UIKit

class ColorViewController: UIViewController {

    var assembledPartImageViews: [UIImageView] = [] //to receive parts in the assembly area

    override func viewDidLoad() {
        super.viewDidLoad()

        // Display the assembled part image views
        for imageView in assembledPartImageViews {
            view.addSubview(imageView)
        }

        // ... Add color selection UI elements here
    }
}
