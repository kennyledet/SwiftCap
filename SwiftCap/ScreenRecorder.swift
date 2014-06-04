//
//  ScreenRecorder.swift
//  SwiftCap
//
//  Created by kenny on 6/4/14.
//  Copyright (c) 2014 Kendrick Ledet. All rights reserved.
//
import Cocoa
import Foundation
import AVFoundation

class Recorder : NSObject, AVCaptureFileOutputRecordingDelegate {
    let mFileManager = NSFileManager.defaultManager()
    
    // AVCaptureSession holds inputs and outputs for real-time capture
    var mSession = AVCaptureSession()
    var mScreenCapOutput = AVCaptureMovieFileOutput()
    
    // Just capture main display for now
    let mMainDisplayId = CGMainDisplayID()
    
    var mTimer : NSTimer = NSTimer()
    
    init() {

    }
    
    func startCapture(outputPath: NSURL, recordTime: NSTimeInterval) {
        mSession.sessionPreset = AVCaptureSessionPresetHigh;
        
        var screenInput = AVCaptureScreenInput(displayID: mMainDisplayId)
        if screenInput == nil {
            return;
        }
        
        if mSession.canAddInput(screenInput) {
            mSession.addInput(screenInput)
        }
        
        if mSession.canAddOutput(mScreenCapOutput) {
            mSession.addOutput(mScreenCapOutput)
        }
        
        mSession.startRunning()
        
        // TODO: Check for file overwrites
        
        mScreenCapOutput.startRecordingToOutputFileURL(outputPath, recordingDelegate: self)
        
        //let selector = Selector("finishRecord:")
        
        //mTimer = NSTimer.scheduledTimerWithTimeInterval(recordTime, target: self, selector: selector, userInfo: nil, repeats: false)
//        mTimer.fire()
        
    }
    
    func stopCapture() {
        mScreenCapOutput.stopRecording()
    }
    
    func finishRecord(timer: NSTimer) {
        mScreenCapOutput.stopRecording()
        mTimer.invalidate()
    }
    
    
    // AVCaptureFileOutputRecording Delegate methods
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: AnyObject[]!, error: NSError!) {
        if error != nil {
            NSLog("Stopped recording due to error: \(error.description)")
        }
        mSession.stopRunning()
    }
}

//let outputPath = NSURL.fileURLWithPath("/Users/user/Desktop/test.mov")
//let recordTime = NSTimeInterval(5)

//var recorder = Recorder()
//recorder.screenCapture(outputPath, recordTime: recordTime)






