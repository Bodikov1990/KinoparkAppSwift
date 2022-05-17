//
//  StartTableViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 16.05.2022.
//

import UIKit

protocol StartTableViewControllerDelegate: AnyObject {
    func cityData(cityData: CityData)
}

class StartTableViewController: UITableViewController {

    weak var delegate: StartTableViewControllerDelegate?
    
    private var cityList: [CityData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "showCities")
        
        showCities()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showCities", for: indexPath)
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
        delegate?.cityData(cityData: city)
        
        
        let containerViewController = ContainerViewController()
        
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
//                print(cities)
                self.cityList = cities.data ?? []
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
