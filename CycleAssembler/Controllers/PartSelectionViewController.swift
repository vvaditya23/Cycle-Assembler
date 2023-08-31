//
//  PartSelectionViewController.swift
//  CycleAssembler
//
//  Created by Aditya Vyavahare(ヴィヤヴャハレ・アディティア) on 30/08/23.
//

import UIKit

class PartSelectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let parts = Parts()
    var selectedParts: [PartsDataModel] = [] // To store selected parts
    
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
}

extension PartSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parts.partsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartCell", for: indexPath) as! PartsCollectionViewCell
        let part = parts.partsArray[indexPath.item]
        cell.configure(with: part)
        
        // Set checkbox state based on whether part is selected
        cell.isChecked = selectedParts.contains(part)
        cell.checkboxButton.setImage(cell.isChecked ? UIImage(named: "ic_checked") : UIImage(named: "ic_unchecked"), for: .normal)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPart = parts.partsArray[indexPath.item]
        
        if selectedParts.contains(selectedPart) {
            selectedParts.removeAll { $0 == selectedPart }
        } else {
            selectedParts.append(selectedPart)
        }
        
        print("Selected Items: \(selectedParts)")
        
        // Update UI or enable/disable the "Next" button based on selection count
        if selectedParts.count >= 3 && selectedParts.count <= parts.partsArray.count {
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

