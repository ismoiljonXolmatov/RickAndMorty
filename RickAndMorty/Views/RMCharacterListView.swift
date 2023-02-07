//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Apple on 09.07.1444 (AH).
//

import UIKit

protocol UICharacterListViewDelegate: AnyObject {
    func rmCharacterListView
}
/// View that handles showing list  of characters, loader, ect
class RMCharacterListView: UIView {
    
   private let viewModel = UICharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 1, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier:  RMCharacterCollectionViewCell.identifier)
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alpha = 0
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        viewModel.fetchCharacters()
        viewModel.delegate = self
        configureSpinner()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        addSubview(collectionView)
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
         
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
    
    
    private func configureSpinner() {
        addSubview(spinner)
        spinner.startAnimating()
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension RMCharacterListView: UICharacterListViewViewModelDelegate {
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        self.collectionView.isHidden = false
        collectionView.reloadData() // initial Fetch 
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
            
        }

        
    }
    
    
}
