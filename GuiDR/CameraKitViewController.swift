//
//  CameraKitViewController.swift
//  GuiDR
//
//  Created by subdiox on 2019/03/18.
//  Copyright © 2019 Yuta Ooka. All rights reserved.
//

import UIKit

class CameraKitViewController: UIViewController {
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var connectionStatusLabel: UILabel!
    @IBOutlet var firmwareVersionLabel: UILabel!
    @IBOutlet var serialLabel: UILabel!
    
    @IBAction func low(_ sender: Any) {
        
    }
    
    @IBAction func medium(_ sender: Any) {
        
    }
    
    @IBAction func high(_ sender: Any) {
        
    }
}

// overrides
extension CameraKitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        DRCameraKit.shared()?.connectionDelegate = self
        DRCameraKit.shared()?.imageDelegate = self
        print("SDK Version: \(kCameraKitSDKVersion)")
    }
}

extension CameraKitViewController: DRCameraKitConnectionDelegate {
    func cameraKitConnectionStatusDidChange(_ theKit: DRCameraKit!) {
        connectionStatusLabel.text = theKit.isConnected() ? "Connected" : "Not Connected"
        firmwareVersionLabel.text = theKit.isConnected() ? "\(theKit.firmwareVersion)" : "-"
        serialLabel.text = theKit.isConnected() ? theKit.iAPSerialNumber() : "-"
    }
}

extension CameraKitViewController: DRCameraKitImageDelegate {
    func cameraKit(_ theKit: DRCameraKit!, didReceive theImage: UIImage!, sizeInBytes length: Int) {
        mainImageView.image = theImage
    }
}
