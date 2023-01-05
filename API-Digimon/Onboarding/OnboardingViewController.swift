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
        let digimonService = APIManager()
        let digimonViewModel = DigimonViewModel(digimonService: digimonService)
        let viewController = DigimonListViewController(viewModel: digimonViewModel)
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension OnboardingViewController: DigimonListViewControllerDelegate {
    func getImageUrl(url: URL?) {
        guard let url = url else { return }
        onboardingView.setImageFromUrl(url: url)
    }
}
