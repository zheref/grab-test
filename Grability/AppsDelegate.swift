//
//  AppsDelegate.swift
//  Grability
//
//  Created by Sergio Daniel Leztark on 3/3/16.
//  Copyright © 2016 Sergio Daniel Leztark. All rights reserved.
//

import UIKit

internal class AppsDelegate : NSObject, UICollectionViewDelegate {
    
    var action: ItemAtIndexSelectedHandler
    
    init(action: ItemAtIndexSelectedHandler) {
        self.action = action
        super.init()
    }

    // IMPLEMENTATION -----------------------------------------------------------------------------

    internal func collectionView(collectionView: UICollectionView,
    didSelectCellAtIndexPath indexPath: NSIndexPath) {
        action(indexPath.row)
    }
    
}