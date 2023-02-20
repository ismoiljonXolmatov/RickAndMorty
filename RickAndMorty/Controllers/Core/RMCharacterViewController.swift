//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Apple on 07.07.1444 (AH).
//

import UIKit
///Controller to show and search Characters
final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate {
  
    private let characterListView = RMCharacterListView()
    override func viewDidLoad() {
        super.viewDidLoad()
        characterListView.delegate = self
        view.backgroundColor = .systemBackground
        title = "Characters"
        addSearchButton()
        setUpView()
         }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    @objc
    private func didTapSearch() {
        let vc = RMSearchViewController(config: RMSearchViewController.Config(type: .character))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""

        
    }

    private func setUpView() {
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
      // MARK:  - RMCharacterListViewDelegate
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""


    }
}
