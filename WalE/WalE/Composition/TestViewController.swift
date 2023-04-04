//
//  TestViewController.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .green
        
        let service = CommonService(withApiService: ApiClient.shared, offlineStore: OfflineStore.shared)
        let model = service.offlineStoreService.getImageData()
        print(model)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
