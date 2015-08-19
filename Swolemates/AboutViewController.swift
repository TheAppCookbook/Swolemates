//
//  AboutViewController.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import ACBInfoPanel

class AboutViewController: UIViewController {
    // MARK: Responders
    @IBAction func doneButtonWasPressed(sender: UIButton!) {
        self.presentingViewController?.dismissViewControllerAnimated(true,
            completion: nil)
    }
    
    @IBAction func infoButtonWasPressed(sender: UIButton!) {
        let infoPanel = ACBInfoPanelViewController()
        infoPanel.ingredient = "Bodyweight Workouts"
        
        self.presentViewController(infoPanel,
            animated: true,
            completion: nil)
    }
}
