//
//  LandingViewModel.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import Foundation

protocol LandingViewModelDependencyProtocol{
    var service: CommonServiceProtocol { get set }
}
protocol LandingViewModelDelegateProtocol: AnyObject{
    
}

protocol LandingViewModelProtocol{
    var dependency: LandingViewModelDependencyProtocol { get set }
    var delegate: LandingViewModelDelegateProtocol? { get set }
}
class LandingViewModel: LandingViewModelProtocol{
    
    weak var delegate: LandingViewModelDelegateProtocol?
    var dependency: LandingViewModelDependencyProtocol
    
    init(withDependency dependency: LandingViewModelDependencyProtocol){
        self.dependency = dependency
    }
    
}
