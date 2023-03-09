//
//  RMEpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Apple on 20.07.1444 (AH).
//

import UIKit

protocol RMEpisodeDetailViewDelegate: AnyObject {
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didselect character: RMCharacter)
        
}

final class RMEpisodeDetailView: UIView {

    public weak var delegate: RMEpisodeDetailViewDelegate?
    
    private var viewModel: RMEpisodeDetailViewViewModel?
    {
        didSet {
            spinner.stopAnimating()
            self.collectionView?.isHidden = false
            self.collectionView?.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.alpha = 1
            }
        }
    }

    private var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
       let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        addSubview(collectionView)
        self.collectionView = collectionView
        configureSpinner()
        spinner.startAnimating()
        addCollectioViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addCollectioViewConstraints() {
        guard let collectionView = collectionView else {
            return
        }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
     ])
    }
    
    private func configureSpinner() {
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
      ])
    }
    

    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(RMEpisodeInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeInfoCollectionViewCell.identifier)
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier)
        return collectionView
    }
    
    public func configure(with viewModel: RMEpisodeDetailViewViewModel) {
        self.viewModel  = viewModel
    }
}

extension RMEpisodeDetailView {
    
    func layout(for section: Int) -> NSCollectionLayoutSection {
        guard let sections = viewModel?.cellViewModels else {
            return createInfoLayout()
        }
        switch sections[section] {
            
        case .information:
            return createInfoLayout()
            
        case .characters:
            return createCharacterLayout()
        }
        
    }
    
    func createInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        
      item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(80)),
            subitems: [item]
        )
         let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
    func createCharacterLayout () -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1))
        )
        
     item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(280)),
            subitems: [item, item]
        )
         let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
}

    //MARK: - CollectionView Functions



extension RMEpisodeDetailView: UICollectionViewDataSource, UICollectionViewDelegate {
    
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return viewModel?.cellViewModels.count ?? 0
        }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            guard let sections = viewModel?.cellViewModels else {
                return 0
            }
            let sectionType = sections[section]
            switch sectionType {
            case .information(let viewModels):
                return viewModels.count
            case .characters(let viewModels):
                return viewModels.count
             }
        }
    
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let section = viewModel?.cellViewModels else {
               fatalError("No viewModels")
           }
           let sectionType = section[indexPath.section]
           switch sectionType {
           case .information(let viewModels):
               let cellViewModel = viewModels[indexPath.row]
               guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMEpisodeInfoCollectionViewCell.identifier,
                for: indexPath) as? RMEpisodeInfoCollectionViewCell else {
                   fatalError()
               }
               cell.configure(with: cellViewModel)
               return cell
           case .characters(let viewModels):
               let cellViewModel = viewModels[indexPath.row]
               guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterCollectionViewCell.identifier,
                for: indexPath) as? RMCharacterCollectionViewCell else {
                   fatalError()
               }
               cell.configure(with: cellViewModel)
               return cell
           }
           
       }
    
          func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
              guard let viewModel = viewModel else {
                  fatalError("no ViewModel ")
              }
              let sections = viewModel.cellViewModels
              let sectionType = sections[indexPath.section]
              
              switch sectionType {
              case .information:
                 break
              case .characters:
                  guard let character = viewModel.character(at: indexPath.row) else {
                      return
                  }
                  delegate?.rmEpisodeDetailView(self, didselect: character)
                   
              }
        }
    
}
