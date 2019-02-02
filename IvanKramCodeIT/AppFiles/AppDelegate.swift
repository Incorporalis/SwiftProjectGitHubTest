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

    func decode(_ num: String) -> String {
        let alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"

        let len = Int(String(num.first!))

        let inverted = Array(num.dropFirst().compactMap {String($0)}.reversed()).joined(separator: "")

        let regex = try! NSRegularExpression(pattern: ".{1,2}")
        let regres = regex.matches(in: inverted, range: NSRange(inverted.startIndex..., in: inverted))
        let arr = regres.map { String(inverted[Range($0.range, in: inverted)!]) }

        let cleared = arr.map { $0.first == "0" ? String($0.last!) : $0 }

        let res = cleared.map { String(alphabet[alphabet.index(alphabet.startIndex, offsetBy: Int($0)! - len!)]) }.joined(separator: "")

        return res.prefix(1).uppercased() + res.dropFirst()
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

