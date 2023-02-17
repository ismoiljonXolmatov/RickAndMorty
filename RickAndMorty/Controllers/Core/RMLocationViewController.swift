//
//  RNLocationViewController.swift
//  RickAndMorty
//
//  Created by Apple on 07.07.1444 (AH).
//

import UIKit

///Controller to show and search Locations
final class RMLocationViewController: UIViewController {
    
    private let premiryView = RMLocationView()
    
    private let viewModel = RMLocationViewViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(premiryView)
        view.backgroundColor = .systemBackground
        title = "Locations"
        addSearchButton()
        addConstraints()
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            premiryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            premiryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            premiryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            premiryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    @objc
    private func didTapSearch() {
        let vc = RMSearchViewController(config: RMSearchViewController.Config(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
    }
    
    

 
}
