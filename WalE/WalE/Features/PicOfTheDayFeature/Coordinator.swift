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
    func startFlow()
}

class ImageOftheDayFeatureCoordinator: CoordinatorProtocol{
    
    var dependency: CoordinatorDependencyProtocol
    var rootNavigationVC: UINavigationController
    
    init(withDependency dependency: CoordinatorDependencyProtocol, rootVC root: UINavigationController){
        self.dependency = dependency
        self.rootNavigationVC = root
    }
    func startFlow() {
        
    }
}
