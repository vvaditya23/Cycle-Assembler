//
//  FinalProductViewController.swift
//  CycleAssembler
//
//  Created by Aditya Vyavahare(ヴィヤヴャハレ・アディティア) on 31/08/23.
//

import UIKit

class FinalProductViewController: UIViewController {

    var finalPartImageViews: [UIImageView] = [] // Assembled image views with colors
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Your final product"
        
        // Add "Close" button to the right side of the navigation bar
            let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeButtonTapped))
            navigationItem.rightBarButtonItem = closeButton
        
        // Display the final assembled part image views
                for imageView in finalPartImageViews {
                    view.addSubview(imageView)
                    imageView.contentMode = .scaleAspectFill
                    imageView.isUserInteractionEnabled = false
                }
    }
    
    @objc func closeButtonTapped() {
        exit(0)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
