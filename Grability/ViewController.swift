//
//  ViewController.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 2/23/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

/**
 * Main view controller responsible of UI logic of main apps listing view
 */
class ViewController: UIViewController, UIToolbarDelegate {
    
    // OUTLETS ------------------------------------------------------------------------------------

    @IBOutlet var variationsToolBar: UIToolbar!
    
    // PROPERTIES ---------------------------------------------------------------------------------
    
    /**
     * Specific domain layer object
     */
    private var _domain: Domain = Domain(coordinator: AppsCoordinator.shared)
    
    // LIFECYCLE ----------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        loadApps()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // FUNCTIONS ----------------------------------------------------------------------------------
    
    /**
     * Sets every view up according to the appearance needs
     */
    private func configViews() {
        
        configVariationsToolBar()
    }
    
    /**
     * Sets the variations toolbar to the needed appearance
     */
    private func configVariationsToolBar() {
        variationsToolBar.delegate = self
        
        self.navigationController?.navigationBar.subviews[2].hidden = true
        self.navigationController?.navigationBar.clipsToBounds = true
    }
    
    /**
     * Start the data loading of the items to show
     */
    private func loadApps() {
        _domain.getTopFreeApps(20, returner: {(apps: [App]) in
            
        }, thrower: {(error: ErrorWrapper) in
            LogErrorHandler().handle(error, whileDoing: "Loading apps from ViewController")
        })
    }
    
    // UITOOLBARDELEGATE IMPLEMENTATION -----------------------------------------------------------
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }

}

