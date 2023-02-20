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
            
            var title :String {
                switch self {
                case .location:
                    return "Search location"
                case .episode:
                    return "Search episode"
                case .character:
                    return "Search character  "
        }
            }
        }
        let type: `Type`
        
        
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        view.backgroundColor = .systemBackground

       }
}
