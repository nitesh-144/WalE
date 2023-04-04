//
//  Composor.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import UIKit

class Composor{
    
    var rootNavigationVC: UINavigationController?
    
    func composeImageOfTheDayFeature() -> UINavigationController {
        let rootNavigation = UINavigationController()
        let commonService = CommonService(withApiService: ApiClient.shared, offlineStore: OfflineStore.shared)
        commonService.delegate = self
        let landingViewBuilderDependency = LandingViewBuilderDependency(service: commonService)
        
        let coordinatorDependency = ImageOftheDayCoordinatorDependency(withService: commonService, landingViewBuilder: LandingViewBuilder(dependency: landingViewBuilderDependency))
        
        let imageFeatureCoordinator = ImageOftheDayFeatureCoordinator(withDependency: coordinatorDependency, rootVC: rootNavigation)
        
        if let startVC = imageFeatureCoordinator.startFlow() as? LandingViewController{
            rootNavigation.viewControllers = [startVC]
        }
        self.rootNavigationVC = rootNavigation
        return rootNavigation
    }
}
extension Composor: CommonServiceListenerProtocol{
    func showLoader() {
        
    }
    
    func hideLoader() {
        
    }
    
    func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.modalPresentationStyle = .overFullScreen
        
        let okAlertAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAlertAction)
        
        if let navVC = self.rootNavigationVC{
            DispatchQueue.main.async { [weak self] in
                self?.navVC.present(alertController, animated: true)
            }
        }
    }
}
