//
//  ViewController.swift
//  ProgressScreen
//
//  Created by Jason Tratta on 10/16/15.
//  Copyright © 2015 Indiana University. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
    

    @IBOutlet var webView: WebView!
    @IBOutlet var feedbackLabel: NSTextField!
    @IBOutlet var progressBar: NSProgressIndicator!
    
    var theTimer = NSTimer()
    var quarter = false
    var half = false
    var threeQuarter = false
    var end = false
    
    
    // Cutomization Variables
    let estimatedCompletionTime = NSTimeInterval(1800)   //Change 1800 to a time in seconds your installation process averages.
    
    // Determine which installer packages should happen in what order in your installation 
    //This will update the progres bar for a more accurate time estimate.
    let quarterProgress = "GLOBAL_Cyberduck4.7.2.pkg"
    let halfProgress = "packageName"
    let threeQuartersProgress = "packageName"
    let lastPackage = "packageName"
    
    
    override func viewDidAppear() {
        
        self.view.window?.backgroundColor = NSColor.whiteColor()
        self.view.window?.collectionBehavior = NSWindowCollectionBehavior.FullScreenPrimary
        //self.view.window?.toggleFullScreen(self)
        
        progressBar.controlTint = NSControlTint.BlueControlTint
        progressBar.minValue = 0
        progressBar.maxValue = estimatedCompletionTime
        progressBar.startAnimation(self)
        
        loadWebPage()
        progress()
  
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


    
    func loadWebPage() {
        
        // Uncomment the line below to use a URL instead of embeded HTML
        // You must then comment out the other var thePath
        //let thePath = NSURL(string: "http://yourURLhere.com")
        
        let thePath = NSBundle.mainBundle().URLForResource("index", withExtension: "html")
        webView.mainFrame.loadRequest(NSURLRequest(URL: thePath!))
        
        
    }
    

    
    
    func progress() {
        
        let timerInterval = NSTimeInterval(0.05)
        theTimer = NSTimer.scheduledTimerWithTimeInterval(timerInterval, target: self, selector: "refreshData", userInfo: nil, repeats: true)
        theTimer.fire()
        
    }
    
    
    func refreshData() {
        
        //refresh the feedback label
        feedbackLabel.stringValue = logFileLastRecord()
        
        
        //setup the progressbar logic 
        progressBar.controlTint = NSControlTint.BlueControlTint
        progressBar.incrementBy(0.05)

        
        let logString = logFileLastRecord()
        
        if (logString.rangeOfString("Successfully installed " + quarterProgress) != nil) {
            
            
            if quarter == false  {
                
                quarter = true
                progressBar.doubleValue = estimatedCompletionTime / 4 }
            
    }
        
        if (logString.rangeOfString("Successfully installed " + halfProgress) != nil) {
            
            
            if half == false  {
                
                half = true
                progressBar.doubleValue = estimatedCompletionTime / 2 }
            
        }

        
        if (logString.rangeOfString("Successfully installed " + threeQuartersProgress) != nil) {
            
            
            if threeQuarter == false  {
                
                threeQuarter = true
                progressBar.doubleValue = estimatedCompletionTime / 1.33 }
            
        }

        
        
        if (logString.rangeOfString("Successfully installed " + lastPackage) != nil) {
            
            
            if end == false  {
                
                //When the last package is installed, quit this application.
                end = true
                NSApplication.sharedApplication().terminate(self)
            
            }
            
        }

}
    
    
    
    
    
    func  logFileLastRecord() -> String {
        
        //This method reads the jamf.log and returns the last line edited into a easy to read format for the user feedback.
        
        let log = NSData(contentsOfFile: "/private/var/log/jamf.log")
        let logString =  NSString(data: log!, encoding: NSUTF8StringEncoding)
        //debugPrint(logString)
        
      
        let theRange = logString?.rangeOfString("]:", options: NSStringCompareOptions.BackwardsSearch)
        let scanner = NSScanner(string: logString as! String)
        scanner.scanLocation = (theRange?.location)!
        
        let lineReturn = NSMutableCharacterSet.newlineCharacterSet()
        
        var logLine = NSString?()
        while scanner.scanUpToCharactersFromSet(lineReturn, intoString: &logLine),
        let logLine = logLine
        
        {
            //debugPrint("Log Line")
            //debugPrint(logLine)
            
        }
        
        
        let trimTimeStamp = logLine!.stringByReplacingOccurrencesOfString("]:", withString: "")
        let removedSlash =  trimTimeStamp.stringByReplacingOccurrencesOfString("\"", withString: "")
        let trimedWhiteSpace = removedSlash.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        //debugPrint("Trimmed")
        //debugPrint(trimedWhiteSpace)
        
        
        return trimedWhiteSpace
    }
    
    // End of Class
    
}

