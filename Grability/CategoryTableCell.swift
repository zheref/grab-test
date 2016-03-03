//
//  CategoryTableCell.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/3/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

internal class CategoryTableCell : UITableViewCell {
    
    private let LOG_TAG = "CategoryTableCell"
    
    // OUTLETS ------------------------------------------------------------------------------------
    
    @IBOutlet var categoryNameLabel: UILabel!
    
    // METHODS ------------------------------------------------------------------------------------
    
    /**
     * Applies a model data into the subviews of the cell according to the needs
     */
    internal func applyModel(model: Category) {
        categoryNameLabel.text = model.label
    }
    
    // OVERRIDE -----------------------------------------------------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
    }
    
}