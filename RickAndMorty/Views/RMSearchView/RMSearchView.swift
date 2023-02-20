//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Apple on 30.07.1444 (AH).
//

import UIKit

class RMSearchView: UIView {
    
    private let viewModel: RMSearchViewViewModel
    
    //MARK: - SubViews
    
    // SearchInputView(bar, selections buttons)
    
    
    // No results view
    
    
    // REsults CollectionView
    
    
    
    
    
    
    
    
    //MARK: - Init
      init(frame: CGRect,viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
         super.init(frame: frame)
         translatesAutoresizingMaskIntoConstraints = false
         backgroundColor = .systemIndigo
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
}

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}