//
//  AppDetailsController.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/4/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

internal class AppDetailsController: UIViewController {
    
    // OUTLETS ------------------------------------------------------------------------------------
    
    @IBOutlet var appIconImageView: UIImageView!
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var appCategoryLabel: UILabel!
    @IBOutlet var appSummaryLabel: UILabel!
    
    // PROPERTIES ---------------------------------------------------------------------------------
    
    /**
     * Specific domain layer object
     */
    private var _domain: DetailsDomain = DetailsDomain()
    
    /**
     * Shortcut to the app model inside the domain
     */
    internal var model: App? {
        get { return _domain.model }
        set (val) {
            _domain.model = val
        }
    }
    
    // LIFECYCLE ----------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDetails()
    }
    
    // FUNCTIONS ----------------------------------------------------------------------------------
    
    private func loadDetails() {
        if let model = model {
            appNameLabel.text = model.name
            appCategoryLabel.text = model.category!.label
            appSummaryLabel.text = model.summary!
            
            ImagesHelper.applyIOSMask(appIconImageView)
            
            if let images = model.images {
                let firstImageLink = (images[2] as! AppImage).link!
                
                HTTPResources.getImage(firstImageLink, by: {(imageData: NSData) in
                    self.appIconImageView.image = UIImage(data: imageData)
                    
                    UIView.animateWithDuration(1.5, delay: 0, options: .CurveEaseInOut, animations:
                        { () -> Void in
                            self.appIconImageView?.alpha = 1
                        }) { (completed) -> Void in }
                    
                    }, orFailWith: {(error: ErrorWrapper) in
                        
                })
            }
        }
    }
    
}