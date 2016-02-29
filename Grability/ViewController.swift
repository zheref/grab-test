//
//  ViewController.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/23/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // LIFECYCLE ----------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // FUNCTIONS ----------------------------------------------------------------------------------
    
    private func loadApps() {
        AppsCoordinator.getInstance().getTopFreeApps(20, returner: {
            (apps: [App]) in
            
        }, thrower: {
            (error: ErrorWrapper) in
            LogErrorHandler().handle(error, whileDoing: "Loading apps from ViewController")
        })
    }

}

