//
//  ViewController.swift
//  SwiftCap
//
//  Created by kenny on 6/4/14.
//  Copyright (c) 2014 Kendrick Ledet. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var mPathCtrl : NSPathControl
    var mPath : NSURL = NSURL.fileURLWithPath(NSHomeDirectory().stringByAppendingPathComponent("/Desktop/"))
    let mRecorder = Recorder()

    
    @IBAction func startRecord(sender : NSButton) {

        let recordTime = NSTimeInterval(5)
        
        mRecorder.startCapture(mPath, recordTime: recordTime)
    }
    
    @IBAction func stopRecord(sender : AnyObject) {
        mRecorder.stopCapture()
        mRecorder.convert(nil)
    }
    
    @IBAction func choosePath(sender : AnyObject) {
        let openPanel = NSOpenPanel()
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = false
        if openPanel.runModal() == NSOKButton {
            mPathCtrl.URL = openPanel.URL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mPathCtrl.URL = mPath
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
                                    
    }


}

