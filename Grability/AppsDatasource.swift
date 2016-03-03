//
//  AppsDatasource.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/3/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

internal class AppsDatasource : NSObject, UITableViewDataSource {
    
    // CONSTANTS ----------------------------------------------------------------------------------
    
    private let REUSABILITY_ID = "AppCellID"
    
    // PROPERTIES ---------------------------------------------------------------------------------
    
    /**
     * The collection of apps to be displayed and served as UI app item cells
     */
    private var _apps: [App]
    
    /**
     * Accesor for collection of apps
     */
    internal var apps: [App] {
        get { return _apps }
        set(items) {
            _apps = items
        }
    }
    
    // INITIALIZERS -------------------------------------------------------------------------------
    
    /**
     * Initializer
     */
    init(initialItems apps: [App]) {
        _apps = apps
    }
    
    // METHODS ------------------------------------------------------------------------------------
    
    /**
     * Adds a new item to the datasource to be later displayed into a table view
     * - Parameter app App: App item to be appended to the datasource
     */
    internal func add(item: App) {
        _apps.append(item)
    }
    
    /**
     * Adds a new item to the datasource to be later displayed into a table view
     * - Parameter apps [App]: App items to be appended to the datasource
     */
    internal func addCollection(items: [App]) {
        _apps.appendContentsOf(items)
    }
    
    // IMPLEMENTATION -----------------------------------------------------------------------------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _apps.count
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
        let cell: AppCell = tableView.dequeueReusableCellWithIdentifier(
            REUSABILITY_ID, forIndexPath: indexPath) as! AppCell;
        
        cell.applyModel(_apps[indexPath.row])
        
        return cell
    }
    
    internal func tableView(tableView: UITableView, titleForHeaderInSection section: Int)
    -> String? {
        return nil;
    }
    
}