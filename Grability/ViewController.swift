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
    @IBOutlet var variationsSegmentedControl: UISegmentedControl!
    @IBOutlet var appsTableView: UITableView!
    
    // PROPERTIES ---------------------------------------------------------------------------------
    
    /**
     * Specific domain layer object
     */
    private var _domain: Domain = Domain(coordinator: AppsCoordinator.shared)
    
    /**
     * Datasource of app items to be displayed on the table view
     */
    private var appsDatasource: AppsDatasource = {
        let ads = AppsDatasource(initialItems: [])
        return ads
    }()
    
    // LIFECYCLE ----------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        loadApps()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // FUNCTIONS ----------------------------------------------------------------------------------
    
    /**
     * Sets every view up according to the appearance and UX needs
     */
    private func configViews() {
        configAppsTableView()
        configVariationsToolBar()
    }
    
    /**
     * Configs everything related with the table view, its datasource, delegate and
     * everything related with its behaviour
     */
    private func configAppsTableView() {
        appsTableView.dataSource = appsDatasource
        appsTableView.delegate = AppsDelegate(action: self.onAppsTableViewSelectedItem)
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
            self.appsDatasource.apps = apps
            self.appsTableView.reloadData()
        }, thrower: {(error: ErrorWrapper) in
            LogErrorHandler().handle(error, whileDoing: "Loading apps from ViewController")
        })
    }
    
    // ACTIONS ------------------------------------------------------------------------------------
    
    /**
     * Triggered when user selects an app item on the TableView
     */
    private func onAppsTableViewSelectedItem(selectedIndex: Int) {
        
    }
    
    // UITOOLBARDELEGATE IMPLEMENTATION -----------------------------------------------------------
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }

}

