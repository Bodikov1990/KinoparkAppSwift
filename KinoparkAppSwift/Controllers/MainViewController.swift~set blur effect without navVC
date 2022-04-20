//
//  MainVC.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 22.03.2022.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func didTapSideMenu()
}

class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupNavBar()
        addLogoToNav()
    }
}


// MARK: - Setup Navigation Bar
extension MainViewController {
    private func setupNavBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearence = UINavigationBarAppearance()
            navBarAppearence.configureWithOpaqueBackground()
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "line.3.horizontal"),
                style: .plain,
                target: self,
                action: #selector(sideMenu)
            )
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(named: "line.3.horizontal"),
                style: .plain,
                target: self,
                action: #selector(sideMenu)
            )
        }
        
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func sideMenu(){
        delegate?.didTapSideMenu()
    }
    
    private func addLogoToNav() {
        if let navController = navigationController {
            let imageLogo = UIImage(named: "kinopark")
            
            let widthNav = navController.navigationBar.frame.width
            let heightNav = navController.navigationBar.frame.height
            
            let widthForView = widthNav * 0.4
            
            let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: widthForView, height: heightNav))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: widthForView, height: heightNav))
            imageView.image = imageLogo
            imageView.contentMode = .scaleAspectFit
            logoContainer.addSubview(imageView)
            
            navigationItem.titleView = logoContainer
        }
    }
}
