//
//  PartSelectionViewController.swift
//  CycleAssembler
//
//  Created by Aditya Vyavahare(ヴィヤヴャハレ・アディティア) on 30/08/23.
//

import UIKit

class PartSelectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // list of parts
    var parts: [PartDataModel] = [
        PartDataModel(image: UIImage(named: "img_frame")!, name: "Frame", description: "The bicycle frame is the core structure that holds all components together. Typically made from materials like steel, aluminum, carbon fiber, or titanium, it provides the bike's shape and stability. The frame's design influences factors such as ride comfort, handling, and overall performance. Different frame styles cater to various riding styles, from road racing to mountain biking."),
        PartDataModel(image: UIImage(named: "img_handle")!, name: "Handle", description: "The bicycle handle, also known as the handlebar, is the steering and control mechanism. It extends from the frame and provides the rider with a grip for maneuvering. Handlebars come in various styles, including drop bars for road bikes, flat bars for urban and mountain bikes, and more. They play a crucial role in determining the rider's posture and control while cycling."),
        PartDataModel(image: UIImage(named: "img_mudGuard")!, name: "Mud Guard", description: "A bicycle mudguard, also called a fender, is an accessory attached above the wheels. It prevents mud, water, and debris from splashing onto the rider and bike components. Mudguards come in different styles and lengths, catering to various bike types and weather conditions. They enhance rider comfort, reduce cleaning efforts, and help protect the bike's moving parts from debris damage."),
        PartDataModel(image: UIImage(named: "img_seat")!, name: "Seat", description: "The bicycle seat, or saddle, is the component where the rider sits. It's designed for comfort and support during cycling. Seats come in various shapes and sizes to accommodate different body types and riding styles. Proper adjustment and padding are important for a comfortable and ergonomic riding experience."),
        PartDataModel(image: UIImage(named: "img_sideStand")!, name: "Side Stand", description: "A bicycle side stand is a small device attached to the frame near the rear wheel. It allows the bike to stand upright when not in motion, providing convenience for parking and brief stops. Side stands come in different styles, including single-legged and double-legged designs. They offer stability and help prevent the bike from falling over when parked."),
        PartDataModel(image: UIImage(named: "img_wheel")!, name: "Wheel", description: "A bicycle wheel is a circular component with a rim at its outer edge, connected to a hub at its center. Spokes connect the hub to the rim, providing structural integrity. The wheel rotates around an axle, allowing the bike to move forward. Different wheel sizes and designs cater to various riding styles, such as road, mountain, and hybrid biking.")
    ]
    
    var selectedParts: [PartDataModel] = [] // To store selected parts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select parts for your cycle"
        
        //delegate declaration
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Register the custom cell class and XIB
        collectionView.register(UINib(nibName: "PartsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PartCell")
        
        // Set up the horizontal scrolling and paging layout
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0 // Adjust spacing as needed
            collectionView.collectionViewLayout = layout
            
            collectionView.isPagingEnabled = true
        
        // Add "Next" button to the navigation bar
            let nextButton = UIBarButtonItem(title: "Next＞", style: .plain, target: self, action: #selector(nextButtonTapped))
            navigationItem.rightBarButtonItem = nextButton
        nextButton.isEnabled = false
    }
    
    @objc func nextButtonTapped() {
        performSegue(withIdentifier: "segueToDragDropScreen", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDragDropScreen" {
            if let dragDropViewController = segue.destination as? AssemblyViewController {
                dragDropViewController.selectedParts = selectedParts
            }
        }
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

extension PartSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartCell", for: indexPath) as! PartsCollectionViewCell
            let part = parts[indexPath.item]
            cell.configure(with: part)
        
        // Set checkbox state based on whether part is selected
            cell.isChecked = selectedParts.contains(part)
            cell.checkboxButton.setImage(cell.isChecked ? UIImage(named: "ic_checked") : UIImage(named: "ic_unchecked"), for: .normal)
        

            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPart = parts[indexPath.item]
        
        if selectedParts.contains(selectedPart) {
            selectedParts.removeAll { $0 == selectedPart }
        } else {
            selectedParts.append(selectedPart)
        }
        
        print("Selected Items: \(selectedParts)")
        
        // Update UI or enable/disable the "Next" button based on selection count
        if selectedParts.count >= 3 && selectedParts.count <= parts.count {
            navigationItem.rightBarButtonItem?.isEnabled = true // Enable the button
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false // Disable the button
        }
        
        collectionView.reloadItems(at: [indexPath])
    }


}

extension PartSelectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

