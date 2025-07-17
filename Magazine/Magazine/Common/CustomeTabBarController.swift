//
//  ViewController.swift
//  Magazine
//
//  Created by Lee on 7/18/25.
//

import UIKit

class CustomeTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: viewController) else {
            return true
        }

        if index == 4 {
            let sb = UIStoryboard(name: "CollectionTravelViewController", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CollectionTravelViewController")

            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen

            present(nav, animated: true)
            return false
        }

        return true
    }
}
