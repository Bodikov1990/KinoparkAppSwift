//
//  SideMenuViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 26.03.2022.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum MenuOptions: String, CaseIterable {
        case city = "Город"
        case language = "Язык"
        case FAQ = "Часто задаваемые вопросы"
        case rules = "Пользовательское соглашение"
        case confidence = "Политика конфиденциальности"
        case contacts = "Связаться с нами"
        case empty1 = ""
        case darkMode = "Перейти в темный режим"
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menu")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOptions.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath)
        
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        
        return cell
    }
}
