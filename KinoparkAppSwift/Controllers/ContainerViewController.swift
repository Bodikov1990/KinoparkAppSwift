//
//  ContainerViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 26.03.2022.
//

import UIKit


class ContainerViewController: UIViewController, UINavigationControllerDelegate {
    
    enum MenuState {
        case closed
        case opened
    }
    
    private var menuState: MenuState = .closed
    
    private let sideMenuViewController = SideMenuViewController()
    private let mainViewController = MainViewController()
    private let citiesViewController = CitiesTableViewController()
    private lazy var mainVC = generateNavController(
        rootViewcontroller: mainViewController,
        title: "Главная",
        image: "list.and.film",
        navBarIsHidden: false)
    private lazy var citiesVC = generateNavController(
        rootViewcontroller: citiesViewController,
        title: "Фильмы",
        image: "film",
        navBarIsHidden: false)
    private lazy var sideMenuVC = generateNavController(
        rootViewcontroller: sideMenuViewController,
        title: "Фильмы",
        image: "film",
        navBarIsHidden: false)
    private lazy var tabBarVC = setupTabBar(viewControllers: mainVC, citiesVC)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        mainViewController.delegate = self
        sideMenuViewController.delegate = self
        addChildVCs()
    }
    
    private func addChildVCs() {
        //        Menu
        sideMenuVC.view.frame = CGRect(x: +50, y: 0, width: sideMenuVC.view.frame.size.width - 50, height: self.view.frame.size.height)
        addChild(sideMenuVC)
        view.addSubview(sideMenuVC.view)
        sideMenuVC.didMove(toParent: self)
        
        //        TabBar
        tabBarVC.view.layer.shadowColor = UIColor.lightGray.cgColor
        tabBarVC.view.layer.shadowOpacity = 0.8
        tabBarVC.view.layer.shadowOffset = CGSize(width: 1, height: 3)
        tabBarVC.view.layer.shadowRadius = 5
        addChild(tabBarVC)
        view.addSubview(tabBarVC.view)
        tabBarVC.didMove(toParent: self)

    }
    
    private func setupTabBar(viewControllers: UIViewController...) -> UITabBarController {
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = viewControllers
        tabBarVC.tabBar.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
        return tabBarVC
    }
    
    private func generateNavController(rootViewcontroller: UIViewController,
                                       title: String,
                                       image: String,
                                       navBarIsHidden: Bool) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewcontroller)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(systemName: image)
        navigationVC.navigationBar.isHidden = navBarIsHidden
        return navigationVC
    }
}

extension ContainerViewController: MainViewControllerDelegate {
    func didTapSideMenu() {
        print("DID TAP")
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.tabBarVC.view.frame.origin.x -= self.tabBarVC.view.frame.width - 50
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }

        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.tabBarVC.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                }
            }
        }
    }
}

extension ContainerViewController: SideMenuViewControllerDelegate {
    func closeButton() {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.tabBarVC.view.frame.origin.x -= self.tabBarVC.view.frame.width - 50
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }

        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.tabBarVC.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                }
            }
        }
    }
}


/*
   private func setupTabBar() {
       let tabBarVC = UITabBarController()
       tabBarVC.viewControllers = [
           generateNavController(
               rootViewcontroller: mainViewController,
               title: "Главная",
               image: "list.and.film",
               navBarIsHidden: false),
           generateNavController(
               rootViewcontroller: citiesViewController,
               title: "Фильмы",
               image: "film",
               navBarIsHidden: false)
       ]
       
       tabBarVC.tabBar.tintColor = #colorLiteral(red: 0.7646051049, green: 0.1110634878, blue: 0.1571588814, alpha: 1)
       addChild(tabBarVC)
       view.addSubview(tabBarVC.view)
       tabBarVC.didMove(toParent: mainViewController)
   }
   
   private func generateNavController(rootViewcontroller: UIViewController,
                                      title: String,
                                      image: String,
                                      navBarIsHidden: Bool) -> UIViewController {
       let navigationVC = UINavigationController(rootViewController: rootViewcontroller)
       navigationVC.tabBarItem.title = title
       navigationVC.tabBarItem.image = UIImage(systemName: image)
       navigationVC.navigationBar.isHidden = navBarIsHidden
       return navigationVC
   }
 */
