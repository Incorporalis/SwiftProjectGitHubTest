//
//  RouterAsembly.swift
//  IvanKramCodeIT
//
//  Created by Ivan.Kramarenko on 11.09.2018.
//  Copyright © 2018 IvanKram. All rights reserved.
//

import UIKit

struct RouterDependencies {

    let routerAssembly: IRouterAssembly
    let searchService: ISearchService

}

protocol IRouterAssembly {
    
    func assembleMainScreen(on navigation: UINavigationController, with dependencies: RouterDependencies)
    func assembleMainScreenAsRoot(with dependencies: RouterDependencies)

}

class RouterAssembly: NSObject, IRouterAssembly {
    
    func assembleMainScreen(on navigation: UINavigationController, with dependencies: RouterDependencies) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
		let vm = RepositoriesViewModel(with: dependencies.searchService)
        vc.config(viewModel: vm)
        vm.config(with: vc)
        navigation.setViewControllers([vc], animated: false)
    }

    func assembleMainScreenAsRoot(with dependencies: RouterDependencies) {
        let rootNavController = UIApplication.shared.windows.first?.rootViewController as! UINavigationController
        assembleMainScreen(on: rootNavController, with: dependencies)
    }
    
}
