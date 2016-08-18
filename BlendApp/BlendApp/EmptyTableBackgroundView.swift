//
//  EmptyTableBackgroundView.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 8/18/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import Foundation
import UIKit

extension SavedBlendsTableViewController {
    
    func setupEmptyBackgroundView() {
        let emptyView = UIView(frame: view.bounds)
        let topLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 20))
        topLabel.text = "You haven't saved any Blends yet!"
        topLabel.textAlignment = .center
        topLabel.font = UIFont.systemFont(ofSize: 20)
        topLabel.textColor = UIColor.darkGray
        emptyView.addSubview(topLabel)
        topLabel.center = view.center
        tableView.backgroundView = emptyView
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
}
