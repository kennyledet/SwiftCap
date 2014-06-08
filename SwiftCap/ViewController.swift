//
//  ViewController.swift
//  SwiftCap
//
//  Created by kenny on 6/4/14.
//  Copyright (c) 2014 Kendrick Ledet. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet var startRecord : NSButtonCell
    @IBOutlet var stopRecord : NSButton
    
    let recorder = Recorder()
    
    @IBAction func startRecord(sender : NSButton) {
        let outputPath = NSURL.fileURLWithPath("/Users/user/Desktop/test.mov")
        let recordTime = NSTimeInterval(5)
        
        recorder.startCapture(outputPath, recordTime: recordTime)
    }
    
    @IBAction func stopRecord(sender : AnyObject) {
        recorder.stopCapture()
        
        recorder.convert(nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                                    
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
                                    
    }


}

