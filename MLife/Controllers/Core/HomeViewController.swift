//
//  HomeViewController.swift
//  MLife
//
//  Created by Nguyễn Hữu Toàn on 28/07/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        
        let compositionalLayout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            return createBasicListLayout(section: sectionNumber)
        }
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar() 

        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
                
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func configureNavigationBar() {
        
        let settingImage = UIImage(systemName: "gear")
        let notificationImage = UIImage(systemName: "bell.badge.fill")
        let searchImage = UIImage(systemName: "magnifyingglass")
        
        let settingButton   = UIBarButtonItem(image: settingImage,  style: .plain, target: self, action: #selector(didTapEditButton(sender:)))
        let notificationButton = UIBarButtonItem(image: notificationImage,  style: .plain, target: self, action: #selector(didTapNotificationButton(sender:)))
        let searchButton = UIBarButtonItem(image: searchImage,  style: .plain, target: self, action: #selector(didTapSearchButton(sender:)))
        
        navigationItem.rightBarButtonItems = [notificationButton, settingButton, searchButton]
    }
    
    @objc func didTapEditButton(sender: AnyObject){
        
    }
    
    @objc func didTapNotificationButton(sender: AnyObject){
        
    }
    
    @objc func didTapSearchButton(sender: AnyObject){
        
    }

}

extension HomeViewController {
    
    static func createBasicListLayout(section: Int) -> NSCollectionLayoutSection { 
        
        switch section {
                
            case 0:
                
                return createNestedGround(widthItem: .fractionalWidth(1.0), heightItem: .fractionalHeight(1.0), top: 5, leading: 5, bottom: 5, trailing: 5, widthVertical: .fractionalWidth(1.0), heightVertical: .fractionalHeight(1.0), widthHorizotal: .absolute(220), heightHorizotal: .absolute(300), countVertical: 3, countHorizotal: 1)!
                
            case 1:
                
                return createBasicCompositionLayout(widthItem: .absolute(200), heightItem: .absolute(200), top: 5, leading: 5, bottom: 5, trailing: 5, widthHorizotal: .absolute(100), heightHorizotal: .absolute(200))!
                
            case 2: 
                
                return createBasicCompositionLayout(widthItem: .fractionalWidth(1.0), heightItem: .absolute(100), top: 5, leading: 5, bottom: 5, trailing: 5, widthHorizotal: .absolute(100), heightHorizotal: .absolute(100))!
                
            case 3: 
                
                return createBasicCompositionLayout(widthItem: .fractionalWidth(1.0), heightItem: .fractionalWidth(1.0), top: 5, leading: 5, bottom: 5, trailing: 5, widthHorizotal: .absolute(200), heightHorizotal: .absolute(200))!
            case 4: 
                return createBasicCompositionLayout(widthItem: .fractionalWidth(1.0), heightItem: .absolute(100), top: 5, leading: 5, bottom: 5, trailing: 5, widthVertical: .fractionalWidth(1.0), heightVertical: .absolute(100))!
                
            default:
                
                return createNestedGround(widthItem: .fractionalWidth(1.0), heightItem: .fractionalHeight(1.0), top: 5, leading: 5, bottom: 5, trailing: 5, widthVertical: .fractionalWidth(1.0), heightVertical: .fractionalHeight(1.0), widthHorizotal: .absolute(220), heightHorizotal: .absolute(300), countVertical: 3, countHorizotal: 1)!
                
        }
    }
    
}

// MARK: - DELEGATE && DATASOURCE

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        switch indexPath.section {
            case 0:
                cell.backgroundColor = .systemPurple
                    // create radius for item
                cell.layer.cornerRadius = 8
            case 1: 
                cell.backgroundColor = .systemRed
                cell.layer.cornerRadius = 8
            case 2: 
                cell.backgroundColor = .systemTeal
                cell.layer.cornerRadius = 8
            case 3:
                cell.backgroundColor = .systemBlue
                cell.layer.cornerRadius = 8
            case 4:
                cell.backgroundColor = .systemPink
                cell.layer.cornerRadius = 8
            default: 
                cell.backgroundColor = .systemFill
                cell.layer.cornerRadius = 8
        }
        return cell 
    }
}

