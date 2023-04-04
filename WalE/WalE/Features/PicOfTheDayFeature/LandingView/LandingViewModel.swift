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
    func renderRecordToUI()
}

protocol LandingViewModelProtocol{
    var dependency: LandingViewModelDependencyProtocol { get set }
    var delegate: LandingViewModelDelegateProtocol? { get set }
    var todayImageRecord: ImageDataModel? { get set }
    
    func getImageOfTheDay()
}
class LandingViewModel: LandingViewModelProtocol{
    
    weak var delegate: LandingViewModelDelegateProtocol?
    var dependency: LandingViewModelDependencyProtocol
    var todayImageRecord: ImageDataModel?{
        didSet{
            delegate?.renderRecordToUI()
        }
    }
    
    init(withDependency dependency: LandingViewModelDependencyProtocol){
        self.dependency = dependency
    }
    
    func getImageOfTheDay() {
        dependency.service.getImageOfTheDay {[weak self] imageRecord in
            DispatchQueue.main.async {
                self?.todayImageRecord = imageRecord
            }
        }
    }
}
