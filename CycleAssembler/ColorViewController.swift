//
//  ColorViewController.swift
//  CycleAssembler
//
//  Created by Aditya Vyavahare(ヴィヤヴャハレ・アディティア) on 31/08/23.
//

import UIKit

class ColorViewController: UIViewController {

    var assembledPartImageViews: [UIImageView] = [] //to receive parts in the assembly area
    // Store the reference to the tapped image view
        var tappedImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Display the assembled part image views
        for imageView in assembledPartImageViews {
            view.addSubview(imageView)
            imageView.contentMode = .scaleToFill
            imageView.tintColor = .black
            imageView.isUserInteractionEnabled = true
            addTapGestureToImageView(imageView)
        }

        // ... Add color selection UI elements here
    }
}

extension ColorViewController: UIColorPickerViewControllerDelegate {
    func addTapGestureToImageView(_ imageView: UIImageView) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleColorPickerTap(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGesture)
        }

    // Present the color picker when an image view is tapped
        @objc func handleColorPickerTap(_ gesture: UITapGestureRecognizer) {
            if let imageView = gesture.view as? UIImageView {
                tappedImageView = imageView

                let colorPicker = UIColorPickerViewController()
                colorPicker.delegate = self
                colorPicker.selectedColor = imageView.tintColor

                present(colorPicker, animated: true, completion: nil)
            }
        }

        // Delegate method to handle color picker color changes
        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            if let imageView = tappedImageView {
                imageView.tintColor = viewController.selectedColor
            }
        }
}
