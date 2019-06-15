//
//  GalleryViewController.swift
//  SimpleGallery2
//
//  Created by Истина on 27/04/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate {
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var itemGalleryArray: [String] = ["pic (1).jpg", "pic (2).jpg", "pic (3).jpg", "pic (5).jpg","pic (6).jpg","pic (7).jpg","pic (8).jpg" ,"pic (9).jpg","pic (10).jpg","pic (11).jpg","pic (12).jpg","pic (13).jpg","pic (14).jpg","pic (15).jpg","pic (16).jpg", "pic (17).jpg", "pic (18).jpg", "pic (19).jpg", "pic (20).jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        
        collectionView.frame = UIScreen.main.bounds
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    //how many items in row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collectionView.frame.width-8)/3), height: ((collectionView.frame.width-8)/3))
    }
    //how many items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemGalleryArray.count
    }
    //Customize CELL
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? GalleryCollectionViewCell {
            itemCell.backgroundColor = UIColor.white
            
            let image = UIImageView(image: UIImage(named: itemGalleryArray[indexPath.row])!)
            image.translatesAutoresizingMaskIntoConstraints = false
            itemCell.contentView.addSubview(image)
            
            //Constraints
            NSLayoutConstraint.activate([
                image.topAnchor.constraint(equalTo: itemCell.contentView.topAnchor, constant: 4),
                image.leadingAnchor.constraint(equalTo: itemCell.contentView.leadingAnchor, constant: 4),
                image.trailingAnchor.constraint(equalTo: itemCell.contentView.trailingAnchor, constant: -4),
                image.bottomAnchor.constraint(equalTo: itemCell.contentView.bottomAnchor, constant: -4)
                ])
            
            image.contentMode = .scaleAspectFill
            image.layer.masksToBounds = true
            
            return itemCell
        }
        return UICollectionViewCell()
    }
    

    }
 //Dragging the item
extension GalleryViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = self.itemGalleryArray[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }
}
//Dropping the item
extension GalleryViewController: UICollectionViewDropDelegate {
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag{
           return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexPath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexPath = IndexPath(item: row-1, section: 0)
        }
        if coordinator.proposal.operation == .move {
            self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        }
    }
    
    func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView){
        if let item = coordinator.items.first,
            let sourseIndexPath = item.sourceIndexPath {
            
            collectionView.performBatchUpdates({
                self.itemGalleryArray.remove(at: sourseIndexPath.item)
                self.itemGalleryArray.insert(item.dragItem.localObject as! String, at: destinationIndexPath.item)
                
                collectionView.deleteItems(at: [sourseIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            }, completion: nil)
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        }
    }
}

