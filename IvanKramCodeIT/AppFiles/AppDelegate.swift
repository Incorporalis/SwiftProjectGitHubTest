//
//  AppDelegate.swift
//  IvanKramCodeIT
//
//  Created by Ivan.Kramarenko on 10.09.2018.
//  Copyright © 2018 IvanKram. All rights reserved.
//

import UIKit

import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy private var dependencies: RouterDependencies = {
		return loadDependencies()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        dependencies.routerAssembly.assembleMainScreenAsRoot(with: dependencies)
        return true
    }

    func loadDependencies() -> RouterDependencies {
        let env                = Environment(.PROD)
        let errorHandler       = NetworkErrorHandler()
        let networkDispatcher  = NetworkDispatcher(environment: env, errorHandler: errorHandler)
        let searchService      = SearchService(with: networkDispatcher)
        let routerAssembly	   = RouterAssembly()

        return RouterDependencies(
            routerAssembly: routerAssembly,
            searchService: searchService
        )
    }

}

