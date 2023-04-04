//
//  Composor.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import UIKit

class Composor{
    
    func composeImageOfTheDayFeature() -> UINavigationController {
        let rootNavigation = UINavigationController()
        let commonService = CommonService(withApiService: ApiClient.shared, offlineStore: OfflineStore.shared)
        let landingViewBuilderDependency = LandingViewBuilderDependency(service: commonService)
        
        let coordinatorDependency = ImageOftheDayCoordinatorDependency(withService: commonService, landingViewBuilder: LandingViewBuilder(dependency: landingViewBuilderDependency))
        
        let imageFeatureCoordinator = ImageOftheDayFeatureCoordinator(withDependency: coordinatorDependency, rootVC: rootNavigation)
        
        if let startVC = imageFeatureCoordinator.startFlow() as? LandingViewController{
            rootNavigation.viewControllers = [startVC]
        }
        return rootNavigation
    }
}
