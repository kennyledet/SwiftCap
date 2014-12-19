//
//  ViewController.swift
//  SwiftCap
//
//  Created by kenny on 6/4/14.
//  Copyright (c) 2014 Kendrick Ledet. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var mPathCtrl : NSPathControl?

    let mDefaultSavePath = NSURL(fileURLWithPath: NSHomeDirectory().stringByAppendingPathComponent("/Desktop"), isDirectory: true)
    
    let mRecorder = Recorder()

    @IBOutlet weak var statusLabel: NSTextField!

    @IBOutlet weak var conversionProgress: NSProgressIndicator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.window?.title = "SwiftCap - Capture Your Mac Screen in .webm"
        
        mPathCtrl!.URL = mDefaultSavePath!
    }

    
    @IBAction func startRecord(sender : NSButton) {
        self.statusLabel.stringValue = "Started recording...."
        
        mRecorder.startCapture(mPathCtrl!.URL!, recordTime: nil)

    }
    
    @IBAction func stopRecord(sender : AnyObject) {
        self.statusLabel.stringValue = "Stopping recording...."
        
        mRecorder.stopCapture()
        
        self.statusLabel.stringValue = "Starting conversion to webm...."
        self.conversionProgress.startAnimation(self)
        
        mRecorder.convert(nil)
        

    }
    
    @IBAction func choosePath(sender : AnyObject) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = false

        if openPanel.runModal() == NSOKButton {
            mPathCtrl!.URL = openPanel.URL
        }
    }



}

