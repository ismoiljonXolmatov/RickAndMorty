//
//  EpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Apple on 20.07.1444 (AH).
//

import UIKit
/// VC for to show episode single episode
class EpisodeDetailViewController: UIViewController {
    
    private let viewModel: RMEpisodeDetailViewModel
    // MARK: - Init
    init(url: URL?) {
        self.viewModel = .init(endPointURL: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifescyle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "Episode".uppercased()

    }
    

}
