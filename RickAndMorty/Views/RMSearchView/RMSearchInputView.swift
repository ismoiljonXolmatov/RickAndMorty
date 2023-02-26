//
//  RMSearchInputView.swift
//  RickAndMorty
//
//  Created by Apple on 30.07.1444 (AH).
//

import UIKit

protocol RMSearchInputViewDelegate: AnyObject {
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}
 final class RMSearchInputView: UIView {
     
     weak var delegate: RMSearchInputViewDelegate?
     
     private let searchBar: UISearchBar = {
         let searchBar = UISearchBar()
         searchBar.translatesAutoresizingMaskIntoConstraints = false
         searchBar.placeholder = "Search"
         return searchBar
     }()
     private var viewModel: RMSearchInputViewViewModel? {
         didSet {
             guard let viewModel = viewModel, viewModel.hasDynamicOption else {
                 return
             }
             let options = viewModel.options
             creaOptionSelectionViews(options: options)
         }
     }
     
     private var stackView: UIStackView?
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         translatesAutoresizingMaskIntoConstraints = false
         addSubview(searchBar)
         addConstraint()
     }
          
     required init?(coder: NSCoder) {
         fatalError("Unsupported")
     }
     
     private func addConstraint() {
         NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 55)
         ])
  }
     
     private func createStackViewOptions() -> UIStackView {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.distribution = .fillEqually
         stackView.spacing = 10
         stackView.alignment = .center
         addSubview(stackView)
         NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: -15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
         ])
         
         return stackView
     }
     private func creaOptionSelectionViews(options: [RMSearchInputViewViewModel.DynamicOption]) {
       let stackView = createStackViewOptions()
         self.stackView = stackView
         for x in 0..<options.count {
             let option = options[x]
             let button = creatButton(with: option, tag: x)
             stackView.addArrangedSubview(button)
         }
         
     }
     private func creatButton(with option: RMSearchInputViewViewModel.DynamicOption, tag: Int) -> UIButton {
         let button = UIButton()
         button.setAttributedTitle(
            NSAttributedString(
                string: option.rawValue,
                attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .medium),
            .foregroundColor: UIColor.label
         ]),  for: .normal)
         button.backgroundColor = .systemIndigo
         button.setTitleColor(.label, for: .normal)
         button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
         button.tag = tag
         button.layer.cornerRadius = 6
         return button
     }
     @objc private func didTapButton(_ sender: UIButton) {
         guard let options = viewModel?.options else {
             return
         }
         
         let tag = sender.tag
         let selected = options[tag]
         delegate?.rmSearchInputView(self, didSelectOption: selected)
         
     }
     
     
     public func configure( with viewModel: RMSearchInputViewViewModel) {
         searchBar.placeholder = viewModel.placeHolderText
         self.viewModel = viewModel
         
     }
     public func presentKeyboard() {
         searchBar.becomeFirstResponder()
     }
     
     public func update(option: RMSearchInputViewViewModel.DynamicOption, value: String) {
         // Update option
         guard let buttons = stackView?.arrangedSubviews as? [UIButton],
               let alloptions = viewModel?.options,
               let index = alloptions.firstIndex(of: option) else {
             return
         }
         let button: UIButton = buttons[index]
         button.setAttributedTitle(
            NSAttributedString(
                string: value.uppercased(),
                attributes: [
            .font: UIFont.systemFont(ofSize: 18, weight: .medium),
            .foregroundColor: UIColor.systemMint
         ]),  for: .normal)
     }
     

 
}
