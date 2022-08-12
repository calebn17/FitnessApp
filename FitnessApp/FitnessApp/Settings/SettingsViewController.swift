//
//  SettingsViewController.swift
//  FitnessApp
//
//  Created by Caleb Ngai on 8/11/22.
//

import UIKit

final class SettingsViewController: UIViewController {

//MARK: - Properties
    weak var coordinator: SettingsCoordinator?
    private let sections: [SettingsSection] = SettingsViewModel.sections
    
//MARK: - SubViews
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        configureTableFooter()
    }
    
    private func configureTableFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        let button = UIButton(frame: footer.bounds)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        footer.addSubview(button)
        tableView.tableFooterView = footer
    }
    
//MARK: - Actions
    @objc private func didTapSignOut() {
        coordinator?.presentLogOutSheet(sender: self)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sections[indexPath.section].options[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

