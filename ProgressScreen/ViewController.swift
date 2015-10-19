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
    
    
    override func viewDidAppear() {
        
        self.view.window?.backgroundColor = NSColor.whiteColor()
        self.view.window?.collectionBehavior = NSWindowCollectionBehavior.FullScreenPrimary
        self.view.window?.toggleFullScreen(self)
        
        loadWebPage()
        jssProgress()
       // logFileTracking()
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
        
        let thePath = NSBundle.mainBundle().URLForResource("index", withExtension: "html")
        webView.mainFrame.loadRequest(NSURLRequest(URL: thePath!))
        
        
    }
    
    
    func jssProgress() {
        
        feedbackLabel.stringValue = "Starting Downloads..."
        self.progressBar.startAnimation(self)
        
        
        
        
    }
    
    
    
    func progress() {
        
        
        let estimatedTime = 60
        
        
        
        
    }
    
    
    
    func  logFileLastRecord() -> String {
        
        
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
            debugPrint("Log Line")
            debugPrint(logLine)
            
        }
        
        
        let trimTimeStamp = logLine!.stringByReplacingOccurrencesOfString("]:", withString: "")
        let removedSlash =  trimTimeStamp.stringByReplacingOccurrencesOfString("\"", withString: "")
        let trimedWhiteSpace = removedSlash.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        debugPrint("Trimmed")
        debugPrint(trimedWhiteSpace)
        
        
        return trimedWhiteSpace
    }
    
    // End of Class
    
}

