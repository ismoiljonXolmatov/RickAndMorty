//
//  RMSettingsViewController.swift
//  RickAndMorty
//
//  Created by Apple on 07.07.1444 (AH).
//
import StoreKit
import SafariServices
import SwiftUI
import UIKit

/// Controller to show various app options and settings
final class RMSettingsViewController: UIViewController {

    
    
    private var settingsSwiftUIController: UIHostingController<RMSettingsView>?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        addSWiftUIController()
              
    }
    
    private func addSWiftUIController() {
        let settingsSwiftUIController =  UIHostingController(
            rootView: RMSettingsView(
                viewModel: RMSettingsViewViewModel(
                    cellViewModels: RMSettingsOption.allCases.compactMap({
                        return RMSettingCellViewModel(type: $0) { [weak self] option in
                            self?.handleTap(option: option)
                        }
        }
                    )
                )
            )
        )
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingsSwiftUIController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        self.settingsSwiftUIController = settingsSwiftUIController
        
    }
    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            //Open website
        } else if option == .rateApp {
            // Show rating propt
            if let windowScene = view.window?.windowScene {
           SKStoreReviewController.requestReview(in: windowScene)
           
           }
  
        }
        
    }
    
}
