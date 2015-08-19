//
//  PostAvailabilityViewController.swift
//  Swolemates
//
//  Created by PATRICK PERINI on 8/18/15.
//  Copyright (c) 2015 AppCookbook. All rights reserved.
//

import UIKit
import RMDateSelectionViewController

class PostAvailabilityViewController: PostViewController {
    // MARK: Properties
    var postTitle: String!
    var postStreetAddress: String!
    var postZipCode: String!
    var postPrice: Int!
    var postPhoto: UIImage!
    var postEquipment: String!
    
    @IBOutlet var doneButton: UIButton!
    
    private var pendingAvailability: (date: NSDate?, times: (start: NSDate?, end: NSDate?)) = (nil, (nil, nil))
    private var availabilities: [(date: NSDate, times: (start: NSDate, end: NSDate))] = []
    
    private var inputValid: Bool {
        return (self.availabilities.count > 0)
    }
    
    // MARK: Mutators
    func updateValue(sender: BorderedButton!, pickerMode: UIDatePickerMode) {
        let cancelAction = RMAction(title: "Cancel", style: .Cancel, andHandler: nil)
        let selectAction = RMAction(title: "Select", style: .Done) { (controller: RMActionController!) in
            let newDate = (controller.contentView as! UIDatePicker).date
            
            if sender.associatedIndex != nil && sender.associatedIndex! < self.availabilities.count {
                var availability = self.availabilities[sender.associatedIndex!]
                
                switch sender.tag {
                case 1:
                    availability.date = newDate
                    sender.setTitle(newDate.stringWithFormat(dateFormat: .ShortStyle), forState: .Normal)
                    
                case 2:
                    availability.times.start = newDate
                    sender.setTitle(newDate.stringWithFormat(timeFormat: .ShortStyle), forState: .Normal)
                    
                case 3:
                    availability.times.end = newDate
                    sender.setTitle(newDate.stringWithFormat(timeFormat: .ShortStyle), forState: .Normal)
                    
                default:
                    break
                }
                
                self.availabilities[sender.associatedIndex!] = availability
            } else {
                switch sender.tag {
                case 1:
                    self.pendingAvailability.date = newDate
                    sender.setTitle(newDate.stringWithFormat(dateFormat: .ShortStyle), forState: .Normal)
                    
                case 2:
                    self.pendingAvailability.times.start = newDate
                    sender.setTitle(newDate.stringWithFormat(timeFormat: .ShortStyle), forState: .Normal)
                    
                case 3:
                    self.pendingAvailability.times.end = newDate
                    sender.setTitle(newDate.stringWithFormat(timeFormat: .ShortStyle), forState: .Normal)
                    
                default:
                    break
                }
            }
            
            sender.setTitleColor(UIColor.blackColor(), forState: .Normal)
            self.inputDidChange()
        }
        
        let dateSelectionController = RMDateSelectionViewController(style: RMActionControllerStyle.White,
            selectAction: selectAction,
            andCancelAction: cancelAction)
        dateSelectionController.datePicker.datePickerMode = pickerMode
        
        self.presentViewController(dateSelectionController,
            animated: true,
            completion: nil)
    }
    
    // MARK: Responders
    func dateButtonWasPressed(sender: BorderedButton!) {
        self.updateValue(sender,
            pickerMode: .Date)
    }
    
    func startTimeButtonWasPressed(sender: BorderedButton!) {
        self.updateValue(sender,
            pickerMode: .Time)
    }
    
    func endTimeButtonWasPressed(sender: BorderedButton!) {
        self.updateValue(sender,
            pickerMode: .Time)
    }
    
    @IBAction func doneButtonWasPressed(sender: UIButton!) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        let gymListing = GymListing(title: self.postTitle,
            streetAddress: self.postStreetAddress,
            zipCode: self.postZipCode,
            price: self.postPrice,
            equipment: self.postEquipment)
        
        for availability in self.availabilities {
            gymListing.availabilities[availability.date] = availability.times
        }
        
        gymListing.setPhoto(self.postPhoto) { (url: NSURL?) in
            gymListing.saveAndNotify()
        }
    }
    
    func inputDidChange() {
        if let date = pendingAvailability.date,
           let startTime = pendingAvailability.times.start,
           let endTime = pendingAvailability.times.end {
            self.availabilities.append((date: date, times: (start: startTime, end: endTime)))
                self.pendingAvailability = (nil, (nil, nil))
                self.tableView.reloadData()
        }
        
        self.doneButton.enabled = self.inputValid
        self.doneButton.backgroundColor = self.doneButton.enabled ? self.doneButton.tintColor : UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0)
    }
}

extension PostAvailabilityViewController: UITableViewDataSource {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.availabilities.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Availability") as! UITableViewCell
        
        let dateButton = cell.viewWithTag(1) as! BorderedButton
        let startTimeButton = cell.viewWithTag(2) as! BorderedButton
        let endTimeButton = cell.viewWithTag(3) as! BorderedButton
        
        if indexPath.row < self.availabilities.count {
            let availability = self.availabilities[indexPath.row]
            
            dateButton.setTitle(availability.date.stringWithFormat(dateFormat: .ShortStyle), forState: .Normal)
            startTimeButton.setTitle(availability.times.start.stringWithFormat(timeFormat: .ShortStyle), forState: .Normal)
            endTimeButton.setTitle(availability.times.end.stringWithFormat(timeFormat: .ShortStyle), forState: .Normal)
        }
        
        dateButton.associatedIndex = indexPath.row
        startTimeButton.associatedIndex = indexPath.row
        endTimeButton.associatedIndex = indexPath.row
        
        dateButton.addTarget(self,
            action: "dateButtonWasPressed:",
            forControlEvents: .TouchUpInside)
        startTimeButton.addTarget(self,
            action: "startTimeButtonWasPressed:",
            forControlEvents: .TouchUpInside)
        endTimeButton.addTarget(self,
            action: "endTimeButtonWasPressed:",
            forControlEvents: .TouchUpInside)
        
        return cell
    }
}
