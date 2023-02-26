//
//  RMSearchOptioonPickerViewController.swift
//  RickAndMorty
//
//  Created by Apple on 01.08.1444 (AH).
//

import UIKit

final class RMSearchOptioonPickerViewController: UIViewController {
    
    private let option: RMSearchInputViewViewModel.DynamicOption
    private let selectionBlock: ((String)-> Void)
    
    private let tableView: UITableView = {
       let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()

    init(option: RMSearchInputViewViewModel.DynamicOption, selection: @escaping(String)-> Void) {
        self.option = option
        self.selectionBlock = selection
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setUpTable()
        addConstraint()

    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         ])
    }
    
    
    private func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }

}
extension RMSearchOptioonPickerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option.choises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let choice = option.choises[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = choice.uppercased()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let choice = option.choises[indexPath.row]
        self.selectionBlock(choice)
        dismiss(animated: true)
    }
}

