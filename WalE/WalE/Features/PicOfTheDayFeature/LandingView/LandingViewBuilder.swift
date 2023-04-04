//
//  LandingViewBuilder.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import Foundation

protocol LandingViewBuilderProtocol{
    
    var dependency: LandingViewModelDependencyProtocol { get set }
    func build() -> LandingViewControllerProtocol
}

class LandingViewBuilder: LandingViewBuilderProtocol{
    
    var dependency: LandingViewModelDependencyProtocol
    
    init(dependency: LandingViewModelDependencyProtocol) {
        self.dependency = dependency
    }
    
    func build() -> LandingViewControllerProtocol {
        let viewModel = LandingViewModel(withDependency: self.dependency)
        let vc = LandingViewController(viewModel: viewModel)
        viewModel.delegate = vc
        return vc
    }
}

class LandingViewBuilderDependency: LandingViewModelDependencyProtocol{
    
    var service: CommonServiceProtocol
    
    init(service: CommonServiceProtocol) {
        self.service = service
    }
}
