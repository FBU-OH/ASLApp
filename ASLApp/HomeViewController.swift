//
//  HomeViewController.swift
//  ASLApp
//
//  Created by Olivia Koshy on 7/5/16.
//  Copyright © 2016 Olivia Koshy. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {

    //CameraView variables
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var homeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makeGrayscalePressed(sender: AnyObject) {
        homeImageView.image = OpenCVWrapper.makeGrayFromImage(homeImageView.image)
        
    }

    @IBAction func moveToCameraPressed(sender: AnyObject) {
        //Initialize/setup session
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSessionPresetPhoto
        
        //Select input device
        let backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        //Prepare input:
        var error: NSError?
        var input: AVCaptureDeviceInput!
        
        
        do {    //try to access camera
            input = try AVCaptureDeviceInput(device: backCamera)
        } catch let error1 as NSError {
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        //if camera available
        if error == nil && session!.canAddInput(input) {
            
            //attach input
            session!.addInput(input)
            
            //configure output
            stillImageOutput = AVCaptureStillImageOutput()
            stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
            
            //attach output
            if session!.canAddOutput(stillImageOutput) {
                session!.addOutput(stillImageOutput)

            // Configure the Live Preview:
                
                //Create an AVCaptureVideoPreviewLayer and associate it with our session
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
                
                //Configure the Layer to resize while maintaining it's original aspect.
                videoPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspect
                
                //Fix the orientation to portrait
                videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.Portrait
                
                //Add the preview layer as a sublayer of our previewView
                previewView.layer.addSublayer(videoPreviewLayer!)
                
                
                //Set size and origin of PreviewLayer to fit inside PreviewView
                videoPreviewLayer!.frame = previewView.bounds    //THIS SHOULD BE DONE IN VIEWDIDAPPEAR
                homeImageView.alpha = 0
                
                //Start the session!
                session!.startRunning()
            }
        }
    }

    @IBAction func didTakePhoto(sender: AnyObject) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
