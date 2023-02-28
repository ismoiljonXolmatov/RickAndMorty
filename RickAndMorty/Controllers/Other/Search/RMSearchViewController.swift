//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Apple on 23.07.1444 (AH).
//

import UIKit
/// configurable controllr to search
final class RMSearchViewController: UIViewController {

    /// Config for search section
    struct Config {
        enum `Type` {
            case character // naame | status | gender
            case episode // name
            case location // name // type
            
            var endpoint: RMEndPoint {
                switch self {
                case .character: return .character
                case .episode: return .episode
                case .location: return .location
                }
            }
            
            
            var title: String {
                switch self {
                case .location:
                    return "Search location"
                case .episode:
                    return "Search episode"
                case .character:
                    return "Search character"
               }
            }
        }
        
        let type: `Type`
    }
    private let viewModel: RMSearchViewViewModel
   private let searchView: RMSearchView
    
    
    init(config: Config) {
        let viewModel = RMSearchViewViewModel(config: config)
        self.viewModel = viewModel
    
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapExacuteSearch))
        addConstraints()
        searchView.delegate = self
       }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchView.presentKeyboard()

    }
     
    @objc private func didTapExacuteSearch() {
       viewModel.exacuteSerch()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension RMSearchViewController: RMSearchViewdelegate {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        let vc = RMSearchOptioonPickerViewController(option: option) { [weak self] selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
            }
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }
    
}
