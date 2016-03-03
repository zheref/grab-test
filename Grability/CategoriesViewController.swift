//
//  CategoriesViewController.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/3/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

/**
 * Main view controller responsible of UI logic of main apps listing view
 */
internal class CategoriesViewController: UITableViewController {
    
    // CONSTANTS ----------------------------------------------------------------------------------
    
    private let REUSABILITY_ID = "CategoryCellID"
    
    // PROPERTIES ---------------------------------------------------------------------------------
    
    /**
    * The collection of categories to be displayed and served as UI app item cells
    */
    private var _categories: [Category]
    
    // LIFECYCLE ----------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _categories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithReuseIdentifier(REUSABILITY_ID,
                forIndexPath: indexPath) as! AppCollectionViewCell
            cell.configureCellWithApp(_categories[indexPath.row])
            return cell
    }
    
}