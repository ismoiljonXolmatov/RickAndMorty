//
//  RMCharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Apple on 12.07.1444 (AH).
//

import UIKit

// Controller To show info about about single character
class RMCharacterDetailViewController: UIViewController {
    
    private let viewModel: RMCharacterDetailViewViewModel

    private let detailView: RMCharacterDetailView
    
    //MARK: - Init
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Lifecyce
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
        addConstraints()
        detailView.collectionView?.dataSource = self
        detailView.collectionView?.delegate  = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))

    }
    
    @objc
    private func didTapShare() {
        
        
        // share character info
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

// MARK: - CollectionView
extension RMCharacterDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episode(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.indentifier, for: indexPath) as? RMCharacterPhotoCollectionViewCell else {
                fatalError("Unsupported")
            }
            cell.configure(with: viewModel)
            cell.backgroundColor = .systemGray
            return cell
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCollectionViewCell.indentifier, for: indexPath) as? RMCharacterInfoCollectionViewCell else {
                fatalError("Unsupported")
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .episode(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.indentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
                fatalError("Unsupported")
            }
            cell.configure(with: viewModels[indexPath.row])
            cell.backgroundColor = .red
            return cell
            
        }
            
   }
    
}
