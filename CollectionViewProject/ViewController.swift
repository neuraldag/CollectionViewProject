//
//  ViewController.swift
//  CollectionViewProject
//
//  Created by Gamid Gapizov on 27.02.2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    enum Constants {
        static let itemSize = CGSize(width: 300, height: 450)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Vot eto collection"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupCollectionViewSettings()
    }
    
    func setupCollectionViewSettings() {
        view.addSubview(collectionView)
        let layout = SnapCells()
        layout.scrollDirection = .horizontal
        layout.itemSize = Constants.itemSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: collectionView.layoutMargins.left, bottom: 0, right: 0)
        
        collectionView.collectionViewLayout = layout
        collectionView.decelerationRate = .normal
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let collectionViewConstraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(collectionViewConstraints)
    }

    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 20 }
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
