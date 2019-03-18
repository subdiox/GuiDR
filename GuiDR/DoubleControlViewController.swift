//
//  DoubleControlViewController.swift
//  GuiDR
//
//  Created by subdiox on 2019/03/18.
//  Copyright © 2019 Yuta Ooka. All rights reserved.
//

import UIKit

// IBOutlets, IBActions
class DoubleControlViewController: UIViewController {
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var poleHeightPercentLabel: UILabel!
    @IBOutlet var kickStandStateLabel: UILabel!
    @IBOutlet var batteryPercentLabel: UILabel!
    @IBOutlet var batteryIsFullyChargedLabel: UILabel!
    @IBOutlet var firmwareVersionLabel: UILabel!
    @IBOutlet var serialLabel: UILabel!
    @IBOutlet var leftEncoderLabel: UILabel!
    @IBOutlet var rightEncoderLabel: UILabel!
    @IBOutlet var driveForwardButton: UIButton!
    @IBOutlet var driveLeftButton: UIButton!
    @IBOutlet var driveRightButton: UIButton!
    @IBOutlet var driveBackwardButton: UIButton!
    
    @IBAction func poleUp(_ sender: Any) {
        DRDouble.shared()?.poleUp()
    }
    
    @IBAction func poleStop(_ sender: Any) {
        DRDouble.shared()?.poleStop()
    }
    
    @IBAction func poleDown(_ sender: Any) {
        DRDouble.shared()?.poleDown()
    }
    
    @IBAction func kickstandsRetract(_ sender: Any) {
        DRDouble.shared()?.retractKickstands()
    }
    
    @IBAction func kickstandsDeploy(_ sender: Any) {
        DRDouble.shared()?.deployKickstands()
    }
    
    @IBAction func headPowerOn(_ sender: Any) {
        DRDouble.shared()?.headPowerOn()
    }
    
    @IBAction func headPowerOff(_ sender: Any) {
        DRDouble.shared()?.headPowerOff()
    }
    
    @IBAction func encodersStart(_ sender: Any) {
        DRDouble.shared()?.startTravelData()
    }
    
    @IBAction func encodersStop(_ sender: Any) {
        DRDouble.shared()?.stopTravelData()
    }
}

// overrides
extension DoubleControlViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DRDouble.shared()?.delegate = self
        print("SDK Version: \(kDoubleBasicSDKVersion)")
    }
}

// DRDoubleDelegates
extension DoubleControlViewController: DRDoubleDelegate {
    func doubleDidConnect(_ theDouble: DRDouble!) {
        statusLabel.text = "Connected"
    }
    
    func doubleDidDisconnect(_ theDouble: DRDouble!) {
        statusLabel.text = "Disconnected"
    }
    
    func doubleStatusDidUpdate(_ theDouble: DRDouble!) {
        poleHeightPercentLabel.text = "\(theDouble.poleHeightPercent)"
        kickStandStateLabel.text = "\(theDouble.kickstandState)"
        batteryPercentLabel.text = "\(theDouble.batteryPercent)"
        batteryIsFullyChargedLabel.text = "\(theDouble.batteryIsFullyCharged)"
        firmwareVersionLabel.text = theDouble.firmwareVersion
        serialLabel.text = theDouble.serial
    }
    
    func doubleDriveShouldUpdate(_ theDouble: DRDouble!) {
        let drive: DRDriveDirection = driveForwardButton.isHighlighted ? .forward : (driveBackwardButton.isHighlighted ? .backward : .stop)
        let turn: Float = driveRightButton.isHighlighted ? 1.0 : (driveLeftButton.isHighlighted ? -1.0 : 0.0)
        theDouble.drive(drive, turn: turn)
    }
    
    func doubleTravelDataDidUpdate(_ theDouble: DRDouble!) {
        leftEncoderLabel.text = String(format: "%.02f", NSString(string: leftEncoderLabel.text!).floatValue + theDouble.leftEncoderDeltaInches)
        rightEncoderLabel.text = String(format: "%.02f", NSString(string: rightEncoderLabel.text!).floatValue + theDouble.rightEncoderDeltaInches)
        //print("Left Encoder: \(theDouble.leftEncoderDeltaInches), Right Encoder: \(theDouble.rightEncoderDeltaInches)")
    }
}
