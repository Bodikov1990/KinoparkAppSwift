//
//  StartTableViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 16.05.2022.
//

import UIKit

class StartTableViewController: UITableViewController {
    
    private let identifier = "showCities"
    private var cityList: [CityData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
        showCities()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let city = cityList[indexPath.row]
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = city.name
            cell.contentConfiguration = content
            return cell
        } else {
            cell.textLabel?.text = city.name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let city = cityList[indexPath.row]

        let containerViewController = ContainerViewController()
        containerViewController.cityData = city
        containerViewController.modalPresentationStyle = .fullScreen
        present(containerViewController, animated: true)
        
    }
    
    private func showCities() {
        NetworkManager.shared.fetchWithBearerToken(
            dataType: CityList.self,
            from: NetworkManager.shared.startingUrl,
            convertFromSnakeCase: true) { result in
                switch result {
                case .success(let cities):
                    self.cityList = cities.data ?? []
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
