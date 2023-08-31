//
//  DragDropViewController.swift
//  CycleAssembler
//
//  Created by ヴィヤヴャハレ・アディティア on 30/08/23.
//

import UIKit
import MobileCoreServices

class AssemblyViewController: UIViewController {
    

    @IBOutlet weak var scrollView: UIScrollView!
        @IBOutlet weak var assemblyAreaView: UIView!
    @IBOutlet weak var dragDropInstructionLabel: UILabel!
    
    var selectedParts: [PartDataModel] = [] // To receive selected parts
    var assembledPartImageViews: [UIImageView] = [] //store the parts added to the assembly area
    
    override func viewWillAppear(_ animated: Bool) {
        assembledPartImageViews.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Assemble"
        
        assemblyAreaView.layer.cornerRadius = 10
        
        // Add "Next" button to the navigation bar
            let nextButton = UIBarButtonItem(title: "Next＞", style: .plain, target: self, action: #selector(nextButtonTapped))
            navigationItem.rightBarButtonItem = nextButton
        
        assemblyAreaView.isUserInteractionEnabled = true
        
        // Enable drop interaction for assembly area view
            let dropInteraction = UIDropInteraction(delegate: self)
            assemblyAreaView.addInteraction(dropInteraction)
        
        // Implement UIDropInteractionDelegate methods
           func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
               // Check if the session has a drag item that contains images
               return session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String])
           }
        // Disable horizontal scrolling
                scrollView.isDirectionalLockEnabled = true
        
//        print("Received data: \(selectedParts)")
        for part in selectedParts {
            let imageView = UIImageView(image: part.image)
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            imageView.isUserInteractionEnabled = true
            imageView.tintColor = .black
            // Position the image view within the scroll view
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: CGFloat(selectedParts.firstIndex(of: part)! * 100)).isActive = true
            
            // Add constraints for image view size (adjust as needed)
            imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            
            // Set content size of the scroll view
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: CGFloat(selectedParts.count) * 100)
            //
            // Enable drag interaction for each image view within the scroll view
            for imageView in scrollView.subviews.compactMap({ $0 as? UIImageView }) {
                let dragInteraction = UIDragInteraction(delegate: self)
                imageView.addInteraction(dragInteraction)
            }
        }
    }
    
    @objc func nextButtonTapped() {
        let colorVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ColorViewController") as! ColorViewController
        colorVC.assembledPartImageViews = assembledPartImageViews // Pass the data
        navigationController?.pushViewController(colorVC, animated: true)
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

extension AssemblyViewController: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let imageView = interaction.view as? UIImageView,
              let image = imageView.image else {
            return []
        }
        
        let provider = NSItemProvider(object: image)
        let dragItem = UIDragItem(itemProvider: provider)
        dragItem.localObject = imageView
        
        return [dragItem]
    }
}

extension AssemblyViewController: UIDropInteractionDelegate {

    // ... Previous code
    
    // Implement UIDropInteractionDelegate methods
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        // Check if the session has a drag item that contains images
        return session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String])
    }

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }

    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        // Handle the drop here
        if let item = session.items.first, item.itemProvider.canLoadObject(ofClass: UIImage.self) {
            item.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        // Create a new UIImageView for the dropped image
                        let droppedImageView = UIImageView(image: image)
                        droppedImageView.isUserInteractionEnabled = true
                        // Calculate the position in assemblyAreaView
                        let location = session.location(in: (self?.assemblyAreaView)!)
                        droppedImageView.center = location
                        
                        // Add the image view to the assembly area view
                        self?.assemblyAreaView.addSubview(droppedImageView)
                        droppedImageView.tintColor = .black
                        
                        // After adding the image to the assemblyAreaView
//                        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self!.handlePanGesture(_:)))
//                        droppedImageView.addGestureRecognizer(panGesture)
                        
                        // Add the image view to the assembledPartImageViews array
                                            self?.assembledPartImageViews.append(droppedImageView)
                    }
                }
            }
        }
    }
//    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
//        guard let draggedImageView = gesture.view as? UIImageView else {
//            return
//        }
//
//        let translation = gesture.translation(in: assemblyAreaView)
//        let newX = draggedImageView.center.x + translation.x
//        let newY = draggedImageView.center.y + translation.y
//
//        // Calculate the bounding rectangle
//        let minX = draggedImageView.bounds.width / 2
//        let maxX = assemblyAreaView.bounds.width - draggedImageView.bounds.width / 2
//        let minY = draggedImageView.bounds.height / 2
//        let maxY = assemblyAreaView.bounds.height - draggedImageView.bounds.height / 2
//
//        // Restrict the new position within the bounds
//        draggedImageView.center.x = min(max(newX, minX), maxX)
//        draggedImageView.center.y = min(max(newY, minY), maxY)
//
//        gesture.setTranslation(.zero, in: assemblyAreaView)
//    }
}
