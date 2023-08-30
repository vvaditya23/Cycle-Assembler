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
    
    var selectedParts: [PartDataModel] = [] // To receive selected parts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            //            // Enable drag interaction for each image view within the scroll view
            for imageView in scrollView.subviews.compactMap({ $0 as? UIImageView }) {
                let dragInteraction = UIDragInteraction(delegate: self)
                imageView.addInteraction(dragInteraction)
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
                        
                        // Calculate the position in assemblyAreaView
                        let location = session.location(in: (self?.assemblyAreaView)!)
                        droppedImageView.center = location
                        
                        // Add the image view to the assembly area view
                        self?.assemblyAreaView.addSubview(droppedImageView)
                    }
                }
            }
        }
    }
}
