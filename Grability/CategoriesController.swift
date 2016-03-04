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
internal class CategoriesController: UITableViewController {
    
    // CONSTANTS ----------------------------------------------------------------------------------
    
    private let REUSABILITY_ID = "CategoryCellID"
    
    // PROPERTIES ---------------------------------------------------------------------------------
    
    /**
     * Specific domain layer object
     */
    private var _domain: CategoriesDomain =
        CategoriesDomain(coordinator: CategoriesCoordinator.shared)
    
    /**
     * The collection of categories to be displayed and served as UI app item cells
     */
    private var _categories: [Category] = [Category]()
    
    /**
     * Delegated object to handle when selected category is passed back to the caller controller
     */
    private var _delegate: CategoriesSelectionDelegate?;
    
    /**
     * Accesor for _delegate
     */
    internal var delegate: CategoriesSelectionDelegate? {
        get { return _delegate }
        set (val) {
            _delegate = val
        }
    }
    
    // LIFECYCLE ----------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        loadCategories()
    }
    
    // IMPLEMENTATION -----------------------------------------------------------------------------
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _categories.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
    -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(REUSABILITY_ID,
            forIndexPath: indexPath) as! CategoryTableCell
        cell.applyModel(_categories[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        close(withCategory: self._categories[indexPath.row])
    }
    
    // FUNCTIONS -----------------------------------------------------------------------------
    
    /**
     * Sets every view up according to the appearance and behaviour needs
     */
    private func configViews() {
        self.tableView.delegate = self
    }
    
    /**
     * Loads the categories from the right source to be displayed on the TableView
     */
    private func loadCategories() {
        
        _domain.getAll({(categories: [Category]) in
            if categories.count > 0 {
                self._categories.removeAll()
                self._categories = categories
            }
        }, thrower: {(error: ErrorWrapper) in
            SimplePopup.alert(error.readable, from: self)
        })
    }
    
    private func close() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: {});
    }
    
    /**
     * Close the categories window to get back to the apps collection, specifying a new
     * category to filter with if it has been chosen by the user
     */
    private func close(withCategory category: Category?) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: {() in
            self._delegate!.passValueBack(category)
        });
    }
    
    // ACTIONS ------------------------------------------------------------------------------------
    
    @IBAction func onCloseBarButtonItemAction(sender: UIBarButtonItem) {
        close()
    }
    
    @IBAction func onClearBarButtonItemAction(sender: UIBarButtonItem) {
        close(withCategory: nil)
    }

}