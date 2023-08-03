//
//  MainAssembly.swift
//  Food
//
//  Created by Денис Набиуллин on 03.08.2023.
//

import UIKit

final class MainModuleAssembly {
    
    class func configuredModule() -> UIViewController {
        let view = MainViewController()
        let viewModel = MainViewModel()
        
        view.viewModel = viewModel
        
        return view
    }
}
