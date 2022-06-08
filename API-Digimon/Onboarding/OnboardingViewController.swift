//
//  OnboardingViewController.swift
//  API-Digimon
//
//  Created by user220212 on 6/8/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let onboardingView = OnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    private func configureView() {
        self.view = onboardingView
        self.onboardingView.choiceAction = executeButton
    }
    
    private func executeButton() {
        let viewController = ViewController()
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension OnboardingViewController: SendImageDelegate {
    func getImage(image: UIImage) {
        onboardingView.setImage(image: image)
    }
    
    
}
