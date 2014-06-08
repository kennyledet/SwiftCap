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
    
    var mOutputPath = ""
    
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
        mOutputPath = outputPath.path
        
        //let selector = Selector("finishRecord:")
        //mTimer = NSTimer.scheduledTimerWithTimeInterval(recordTime, target: self, selector: selector, userInfo: nil, repeats: false)
        //mTimer.fire()
        
    }
    
    func stopCapture() {
        mScreenCapOutput.stopRecording()
    }
    
    func finishRecord(timer: NSTimer) {
        stopCapture()
        mTimer.invalidate()
    }
    
    func convert(type: String?) {
        let tempCmd = "ffmpeg -i \(mOutputPath) -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis /Users/user/Desktop/test.webm"
        let task = NSTask()
        task.launchPath = "/usr/bin/ffmpeg"
        task.arguments = ["-i", "\(mOutputPath)", "-c:v", "libvpx", "-crf", "10", "-b:v", "1M", "-c:a", "libvorbis", "/Users/user/Desktop/test.webm"]
        task.launch()


        
    }
    
    
    // AVCaptureFileOutputRecording Delegate methods
    /* Called when recording is finished */
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: AnyObject[]!, error: NSError!) {
        if error != nil {
            NSLog("Stopped recording due to error: \(error.description)")
        }
        mSession.stopRunning()
    }
}






