//
//  AppCell.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/3/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

internal class AppCollectionCell : UICollectionViewCell {
    
    private let LOG_TAG = "AppCollectionCell"
    
    // OUTLETS ------------------------------------------------------------------------------------

    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var categoryNameLabel: UILabel!
    @IBOutlet var appIconImageView: UIImageView!
    
    // METHODS ------------------------------------------------------------------------------------
    
    /**
     * Applies a model data into the subviews of the cell according to the needs
     */
    internal func applyModel(model: App) {
        appNameLabel.text = model.name
        
        if let images = model.images {
            let firstImageLink = (images[2] as! AppImage).link!
            
            HTTPResources.getImage(firstImageLink, by: {(imageData: NSData) in
                self.appIconImageView.image = UIImage(data: imageData)
            }, orFailWith: {(error: ErrorWrapper) in
                
            })
        }
        
        let category = model.category!
        categoryNameLabel.text = category.label
    }
    
    // OVERRIDE -----------------------------------------------------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
    }
    
}