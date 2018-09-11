//
//  File.swift
//  IvanKramCodeIT
//
//  Created by Ivan.Kramarenko on 11.09.2018.
//  Copyright © 2018 IvanKram. All rights reserved.
//

import UIKit
import Foundation

protocol ShowAlertController {

    func showFailureRequestAlert(with message: String?, completion: (()->())?)
    
}

protocol ShowActivityController {
    
    func showHUD()
    func hideHUD()
    
}

class BaseViewController: UIViewController, ShowActivityController {

    private var hudView: UIView {
        guard _hudView == nil else {
            return _hudView!
        }
        
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .lightGray
        activityIndicator.center = view.center
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        _hudView = view
        
        return view
    }

    private var _hudView: UIView?

    func showHUD() {
        if (_hudView == nil) {
            self.view.addSubview(hudView)
        }
    }

    func hideHUD() {
        self.hudView.removeFromSuperview()
        self._hudView = nil
    }

}

extension BaseViewController: ShowAlertController {

    func showFailureRequestAlert(with message: String?, completion: (()->())?) {
		UIAlertController.showErrorAlert(with: message, actionTitle: "Retry", completion: completion, from: self)
    }
    
}
