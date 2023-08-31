//
//  ColorViewController.swift
//  CycleAssembler
//
//  Created by Aditya Vyavahare(ヴィヤヴャハレ・アディティア) on 31/08/23.
//

import UIKit

class ColorViewController: UIViewController {

    var assembledPartImageViews: [UIImageView] = [] //to receive parts in the assembly area
    var finalPartImageViews: [UIImageView] = [] // Assembled image views with colors
    // Store the reference to the tapped image view
        var tappedImageView: UIImageView?
    
    override func viewWillAppear(_ animated: Bool) {
        // Display the assembled part image views
        for imageView in finalPartImageViews {
            view.addSubview(imageView)
            imageView.contentMode = .scaleToFill
            imageView.tintColor = .black
            imageView.isUserInteractionEnabled = true
            addTapGestureToImageView(imageView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Change color of parts"
        
        // Add "Next" button to the navigation bar
            let nextButton = UIBarButtonItem(title: "Next＞", style: .plain, target: self, action: #selector(nextButtonTapped))
            navigationItem.rightBarButtonItem = nextButton
        
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
    
    @objc func nextButtonTapped() {
        let finalVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FinalProductViewController") as! FinalProductViewController
        finalVC.finalPartImageViews = finalPartImageViews // Pass the data
        navigationController?.pushViewController(finalVC, animated: true)
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
                
                // Add the image view to the finalPartImageViews array
                        finalPartImageViews.append(imageView)
            }
        }

//        // Delegate method to handle color picker color changes
//        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
//            if let imageView = tappedImageView {
//                imageView.tintColor = viewController.selectedColor
//            }
//        }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        if let imageView = tappedImageView {
            imageView.tintColor = viewController.selectedColor
            
            if let index = assembledPartImageViews.firstIndex(of: imageView) {
                print("Selected index:", index)
                print("assembledPartImageViews count:", assembledPartImageViews.count)
                print("finalPartImageViews count:", finalPartImageViews.count)
                
                if index < finalPartImageViews.count {
                    finalPartImageViews[index].image = imageView.image?.withRenderingMode(.alwaysTemplate)
                    finalPartImageViews[index].tintColor = viewController.selectedColor
                } else {
                    print("Index is out of range for finalPartImageViews")
                }
            }
        }
    }

}
