//
//  CinemasTableViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 16.05.2022.
//

import UIKit
protocol CinemasTableViewControllerDelegate: AnyObject {
    func getCinema(cinemasData: CinemasData)
}

class CinemasTableViewController: UITableViewController {
    
    var cinemas: [CinemasData] = []
    weak var delegate: CinemasTableViewControllerDelegate?
    
    private let idetifier = "cinemas"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: idetifier)
        tableView.isScrollEnabled = false
    }
    
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 250, height: tableView.contentSize.height)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cinemas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idetifier, for: indexPath)
        let cinemasData = cinemas[indexPath.row]
        
        cell.textLabel?.text = cinemasData.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if tableView.indexPathForSelectedRow == indexPath {
            tableView.deselectRow(at:indexPath, animated:false)
            return nil
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let cinemasData = cinemas[indexPath.row]
        delegate?.getCinema(cinemasData: cinemasData)
        dismiss(animated: true)
    }
}
