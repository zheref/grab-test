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
internal class ViewController: UIViewController, UICollectionViewDelegate, UIToolbarDelegate, CategoriesSelectionDelegate {
    
    private let LOG_TAG = "ViewController"
    
    // OUTLETS ------------------------------------------------------------------------------------

    @IBOutlet var variationsToolBar: UIToolbar!
    @IBOutlet var variationsSegmentedControl: UISegmentedControl!
    @IBOutlet var appsCollectionView: UICollectionView!
    
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
    
    /**
     * Middleware called just in the moment of the segue transition
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segues.AppsToCategories {
            if let navController = segue.destinationViewController as? UINavigationController {
                if let controller = navController.topViewController as? CategoriesController {
                    controller.delegate = self
                }
            }
        } else if segue.identifier == Segues.AppToDetails {
            if let controller = segue.destinationViewController as? AppDetailsController {
                controller.model = _domain.lastTappedVar
            }
        }
    }

    // FUNCTIONS ----------------------------------------------------------------------------------
    
    /**
     * Sets every view up according to the appearance and UX needs
     */
    private func configViews() {
        configAppsCollectionView()
        configVariationsToolBar()
        animate()
    }
    
    /**
     * Configs everything related with the table view, its datasource, delegate and
     * everything related with its behaviour
     */
    private func configAppsCollectionView() {
        appsCollectionView.registerClass(AppCollectionCell.self,
            forCellWithReuseIdentifier: "groupcell")
        
        appsCollectionView.dataSource = appsDatasource
        appsCollectionView.delegate = self
    }
    
    /**
     * Sets the variations toolbar to the needed appearance
     */
    private func configVariationsToolBar() {
        variationsToolBar.delegate = self
        
        self.navigationController?.navigationBar.clipsToBounds = true
    }
    
    /**
     * Start the data loading of the items to show
     */
    private func loadApps() {
        _domain.getApps(63, returner: {(apps: [App]) in
            self.appsDatasource.clear()
            
            for app in apps {
                self.appsDatasource.add(app)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                self.appsCollectionView.reloadData()
            }
        }, thrower: {(error: ErrorWrapper) in
            LogErrorHandler().handle(error, whileDoing: "Loading apps from ViewController")
        })
    }
    
    private func toggleCategoriesPopover() {
        
    }
    
    private func changeNavigationTitle(to newTitle: String) {
        self.navigationController?.navigationBar.topItem?.title = newTitle
    }
    
    private func animate() {
        view.frame = CGRectMake(-600, view.frame.origin.y, view.frame.width, view.frame.height)
        
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.view.backgroundColor = UIColor.whiteColor()
        
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.60,
            initialSpringVelocity: 0, options: .CurveLinear, animations: { () -> Void in
            self.view.frame = CGRectMake(0, self.view.frame.origin.y, self.view.frame.width,
                self.view.frame.height)
            }) { (completed) -> Void in }
    }
    
    private func changeTitleBasedOnVariation() {
        var title: String = ""
        
        switch _domain.selectedVariation {
        case .NewFreeApplications:
            title = "New Free"
        case .TopFreeApplications:
            title = "Top Charts"
        case .NewPaidApplications:
            title = "New Paid"
        default:
            title = "Top Charts"
        }
        
        changeNavigationTitle(to: title)
    }
    
    // ACTIONS ------------------------------------------------------------------------------------
    
    /**
     * Triggered when the "Categories" button item is tapped
     */
    @IBAction func onCategoriesBarButtonItemAction(sender: UIBarButtonItem) {
        switch (UIDevice.currentDevice().userInterfaceIdiom) {
        case .Pad:
            toggleCategoriesPopover()
        case .Phone:
            performSegueWithIdentifier(Segues.AppsToCategories, sender: self)
        default:
            SimplePopup.alert("Defaulting. Why is this even happening?", from: self)
        }
    }
    
    /**
     * Triggered when user switches the variation from the top segmented control
     */
    @IBAction func onVariationsSegmentedControlValueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            _domain.selectedVariation = AppVariation.NewPaidApplications
        case 1:
            _domain.selectedVariation = AppVariation.TopFreeApplications
        case 2:
            _domain.selectedVariation = AppVariation.NewFreeApplications
        default:
            _domain.selectedVariation = AppVariation.TopFreeApplications
        }
        
        changeTitleBasedOnVariation()
        loadApps()
    }
    
    // UITOOLBARDELEGATE IMPLEMENTATION -----------------------------------------------------------
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
    
    // CATEGORIESSELECTIONDELEGATE IMPLEMENTATION -------------------------------------------------
    
    func passValueBack(category: Category?) {
        let changed = _domain.selectedCategory != category
        
        _domain.selectedCategory = category
        
        if changed {
            if category != nil {
                changeNavigationTitle(to: category!.label!)
            } else {
                changeTitleBasedOnVariation()
            }
            
            loadApps()
        }
    }
    
    // UICOLLECTIONVIEWDELEGATE  IMPLEMENTATION ---------------------------------------------------
    
    func collectionView(collectionView: UICollectionView,
        didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        _domain.lastTappedVar = appsDatasource[indexPath.row]
        performSegueWithIdentifier(Segues.AppToDetails, sender: self)
    }

}

