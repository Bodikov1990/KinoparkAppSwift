//
//  ContainerViewController.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 26.03.2022.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState {
        case expanded
        case collapsed
    }
    
    var navVC: UINavigationController?
    let mainVC = MainViewController()
    var sideMenuVC: SideMenuViewController!
    var visualEffectView: UIVisualEffectView!
    
    let sideMenuWidth: CGFloat = 300
    let sideMenuHandleAreaWidth: CGFloat = 0
    let duratioForAnimation = 0.5
    
    var menuVisible = false
    var nextState: MenuState {
        return menuVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterupted: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        mainVC.delegate = self
        
        setupMenu()
        
    }
    
    private func setupNavVC() {
        let navVC = UINavigationController(rootViewController: mainVC)
        addChild(navVC)
        view.addSubview(navVC.view)
    }
    
    private func setupMenu() {
        setupNavVC()
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.isHidden = true
        
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        sideMenuVC = SideMenuViewController()
        self.addChild(sideMenuVC)
        self.view.addSubview(sideMenuVC.view)
        sideMenuVC.view.frame = CGRect(x: self.view.frame.width - sideMenuHandleAreaWidth, y: 0, width: sideMenuWidth, height: self.view.bounds.height)
        
        sideMenuVC.view.clipsToBounds = true
        
        let panGestureRecognizier = UIPanGestureRecognizer(target: self, action: #selector(ContainerViewController.handleSideMenuPanGesture(recognizier:)))
        sideMenuVC.view.addGestureRecognizer(panGestureRecognizier)
        
    }
    
    
    @objc private func handleSideMenuPanGesture(recognizier: UIPanGestureRecognizer) {
        switch recognizier.state {
            
        case .began:
            startInteractiveTransition(state: nextState, duration: duratioForAnimation)
        case .changed:
            let translation = recognizier.translation(in: self.sideMenuVC.view)
            var fractionComplete = translation.x / sideMenuWidth
            fractionComplete = menuVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTtransition()
        case .possible:
            break
        case .cancelled:
            break
        case .failed:
            break
        @unknown default:
            break
        }
    }
    
    
    private func animateTransitionIfNeed(state: MenuState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8) {
                switch state {
                case .expanded:
                    self.sideMenuVC.view.frame.origin.x = self.view.frame.width - self.sideMenuWidth
                case .collapsed:
                    self.sideMenuVC.view.frame.origin.x = self.view.frame.width - self.sideMenuHandleAreaWidth
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.menuVisible = !self.menuVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            let cornerRaduisAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.sideMenuVC.view.layer.cornerRadius = 10
                case .collapsed:
                    self.sideMenuVC.view.layer.cornerRadius = 0
                }
            }
            
            cornerRaduisAnimator.startAnimation()
            runningAnimations.append(cornerRaduisAnimator)
            
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    if #available(iOS 13.0, *) {
                        self.visualEffectView.effect = UIBlurEffect(style: .systemChromeMaterial)
                        self.visualEffectView.isHidden.toggle()
                    } else {
                        self.visualEffectView.effect = UIBlurEffect(style: .light)
                    }
                case .collapsed:
                    self.visualEffectView.effect = nil
                    DispatchQueue.main.asyncAfter(deadline: .now()+duration) {
                        self.visualEffectView.isHidden.toggle()
                    }
                }
            }

            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    
    private func startInteractiveTransition(state: MenuState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeed(state: state, duration: duration)
        }
        
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterupted = animator.fractionComplete
        }
        
    }
    
    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterupted
        }
    }
    
    private func continueInteractiveTtransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
        
    }
    
}

extension ContainerViewController: MainViewControllerDelegate {
    func didTapSideMenu() {
        animateTransitionIfNeed(state: nextState, duration: duratioForAnimation)
    }
}
