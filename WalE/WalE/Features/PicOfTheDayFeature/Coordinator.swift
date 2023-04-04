//
//  Coordinator.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import UIKit

protocol CoordinatorDependencyProtocol{
    var service: CommonServiceProtocol { get set }
    var landingViewBuilder: LandingViewBuilderProtocol { get set }
}

protocol CoordinatorProtocol{
    var dependency: CoordinatorDependencyProtocol { get set }
    var rootNavigationVC: UINavigationController { get set }
    func startFlow() -> LandingViewControllerProtocol
}

class ImageOftheDayCoordinatorDependency: CoordinatorDependencyProtocol{
    
    var service: CommonServiceProtocol
    var landingViewBuilder: LandingViewBuilderProtocol
    
    init(withService service: CommonServiceProtocol, landingViewBuilder landingBuilder: LandingViewBuilderProtocol){
        self.service = service
        self.landingViewBuilder = landingBuilder
    }
}

class ImageOftheDayFeatureCoordinator: CoordinatorProtocol{
    
    var dependency: CoordinatorDependencyProtocol
    var rootNavigationVC: UINavigationController
    
    init(withDependency dependency: CoordinatorDependencyProtocol, rootVC root: UINavigationController){
        self.dependency = dependency
        self.rootNavigationVC = root
    }
    func startFlow() -> LandingViewControllerProtocol {
        return dependency.landingViewBuilder.build()
    }
}
