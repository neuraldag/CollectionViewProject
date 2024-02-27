//
//  CollectionViewCell.swift
//  CollectionViewProject
//
//  Created by Gamid Gapizov on 27.02.2024.
//

import Foundation
import UIKit


class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    private func setUp() {
        layer.cornerRadius = 15
        backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class SnapCells: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        
        let nextCell: CGFloat
        var offsetMagnitude = CGFloat.greatestFiniteMagnitude
        
        if proposedContentOffset.x <= 0 || collectionView.contentOffset == proposedContentOffset { nextCell = proposedContentOffset.x }
        else { nextCell = collectionView.contentOffset.x + (velocity.x > 0 ? collectionView.bounds.size.width : -collectionView.bounds.size.width) }
        
        let targetRect = CGRect(x: nextCell, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left + collectionView.layoutMargins.left

        let attributesArray = super.layoutAttributesForElements(in: targetRect)
        attributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetMagnitude)) { offsetMagnitude = itemOffset - horizontalOffset }
        })
        
        return CGPoint(x: proposedContentOffset.x + offsetMagnitude, y: proposedContentOffset.y)
    }
}
