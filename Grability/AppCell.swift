//
//  AppCell.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/3/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

internal class AppCell : UITableViewCell {
    
    private let LOG_TAG = "AppCell"
    
    // OUTLETS ------------------------------------------------------------------------------------
    
    @IBOutlet var appNameLabel: UILabel!
    
    // METHODS ------------------------------------------------------------------------------------
    
    /**
     * Applies a model data into the subviews of the cell according to the needs
     */
    internal func applyModel(model: App) {
        Log.debug(LOG_TAG, print: "Assigning name: \(model.name) to cell")
        appNameLabel.text = model.name
    }
    
    // OVERRIDE -----------------------------------------------------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
    }
    
}