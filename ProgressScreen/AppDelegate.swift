
//
//  AppDelegate.swift
//  ProgressScreen
//
//  The MIT License (MIT)
//
//Copyright (c) 2015 Jason Tratta
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.
//


import Cocoa
import WebKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var webView: WebView!
    @IBOutlet var feedbackLabel: NSTextField!
    @IBOutlet var progressBar: NSProgressIndicator!
    @IBOutlet weak var theWindow: NSWindow!
    @IBOutlet weak var quitButton: NSButton!
    var theTimer = Timer()
    
    var quarter = false
    var half = false
    var threeQuarter = false
    var end = false
    var numberOfPolices = 0
    @objc dynamic var ready = NSNumber(value: false)
    
    
    var configurations = NSMutableArray()
    
    
    // ************************************************************************************************************************
    // ************************************************************************************************************************
    // Cutomization Variables
    
    var useWayPointMessages = false
    var estimatedCompletionTime = TimeInterval(1800)   //Change 1800 to a time in seconds your installation process averages.
    
    // Determine which installer packages should happen in what order in your installation
    //This will update the progres bar for a more accurate time estimate.
    var quarterProgress = "defaultPackageName"
    var halfProgress = "defaultPackageName"
    var threeQuartersProgress = "defaultPackageName"
    var lastPackage = "defaultPackageName"
    
    // ************************************************************************************************************************
    // ************************************************************************************************************************


    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        //Kiosk Mode Settings
        NSApp.presentationOptions = [.hideMenuBar, .hideDock, .disableHideApplication]
     
    }

    
    

  func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        debugPrint("applicationDidFinishLaunching")
        // Insert code here to initialize your application
        theWindow.backgroundColor = NSColor.white
        theWindow.collectionBehavior = NSWindow.CollectionBehavior.fullScreenPrimary
        theWindow.toggleFullScreen(self)
        
        let app = NSApplication.shared as! PSApplication
        configurations = app.configurations
    
        
        self.addObserver(self, forKeyPath: "configurations", options:.new, context: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(AppDelegate.changeBuildTime(_:)), name:NSNotification.Name.PSBuildTime, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(AppDelegate.changeHTMLURL(_:)), name:NSNotification.Name(rawValue: PSURLChange), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(AppDelegate.changeCurrentTime(_:)), name:NSNotification.Name(rawValue: PSCurrentTimeChange), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(AppDelegate.adjustFullScreen(_:)), name:NSNotification.Name(rawValue: PSFullScreen), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(AppDelegate.hideQuitButton(_:)), name:NSNotification.Name(rawValue: PSHideQuit), object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(AppDelegate.enableWayPointMethod(_:)), name:NSNotification.Name(rawValue: PSHWayPointMethod), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(AppDelegate.setWaypointOne(_:)), name:NSNotification.Name(rawValue: PSHWayPointOne), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(AppDelegate.setWaypointTwo(_:)), name:NSNotification.Name(rawValue: PSHWayPointTwo), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(AppDelegate.setWaypointThree(_:)), name:NSNotification.Name(rawValue: PSHWayPointThree), object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(AppDelegate.setWaypointFour(_:)), name:NSNotification.Name(rawValue: PSHWayPointFour), object: nil)
        
        progressBar.isHidden = false
        progressBar.minValue = 0
        progressBar.maxValue = estimatedCompletionTime
        progressBar.startAnimation(self)
        
        
        loadWebPage()
        progress()
        
        
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        
       return super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        
        
    }
 
 
    
    //MARK: Scripting Methods
    
    
    @objc func changeBuildTime(_ note: Notification) {
        
        
        let object = note.object as! ConfigurationSettings
    
        estimatedCompletionTime = TimeInterval(truncating: object.buildTime)
        progressBar.maxValue = estimatedCompletionTime
        
    }
    
    
    @objc func changeHTMLURL(_ note: Notification)  {
        debugPrint("Changing HTML")
        let object = note.object as! ConfigurationSettings
         let newURL = NSURL(string: object.htmlLocation)
          webView.mainFrame.load(NSURLRequest(url: newURL! as URL) as URLRequest!)
        
    }
    
    @objc func changeCurrentTime(_ note: Notification) {
        
        let object = note.object as! ConfigurationSettings
        progressBar.doubleValue = object.currentTime.doubleValue
        
    }

    @objc func adjustFullScreen(_ note: Notification) {
     
        let object = note.object as! ConfigurationSettings
        let screenBool = object.fullscreen
        

        
        if screenBool == true {
            
            if inFullScreenMode() == false {
                theWindow.toggleFullScreen(self) }
            
        } else {
            
            if inFullScreenMode() == true {
                theWindow.toggleFullScreen(self)
                
            }

            
        }
        
        
    }
    
    
    func inFullScreenMode() -> Bool {
        
        
        
     let options = NSApplication.shared.presentationOptions
    
        if options == NSApplication.PresentationOptions.fullScreen {
            
         return true
            
        }
        
        return false
    }
    
    
    
    
    @objc func hideQuitButton(_ note: Notification) {
        
        let object = note.object as! ConfigurationSettings
        let quitBool = object.hideQuitButton
        
        if quitBool == true {
            
           quitButton.isHidden = true
            
        }
        
        else if quitBool == false {
           
            quitButton.isHidden = false
            
        }
        
        
    }
    
    //Set the WayPoints from Scripting 
    @objc func enableWayPointMethod(_ note: Notification) {
        
        
      
        let object = note.object as! ConfigurationSettings
        useWayPointMessages = object.useWayPointMethod
        
    }
    
    
    @objc func setWaypointOne(_ note: Notification) {
        
     
        let object = note.object as! ConfigurationSettings
        quarterProgress = object.wayPointOne
        
    }
    
    @objc func setWaypointTwo(_ note: Notification) {
        
        
        let object = note.object as! ConfigurationSettings
        halfProgress = object.wayPointTwo
        
    }
    
    @objc func setWaypointThree(_ note: Notification) {
        
       
        let object = note.object as! ConfigurationSettings
        threeQuartersProgress = object.wayPointThree
        
    }
    
    @objc func setWaypointFour(_ note: Notification) {
        
    
        let object = note.object as! ConfigurationSettings
        lastPackage = object.wayPointFour
        
    }
    
    //MARK: PG Methods
    
    func loadWebPage() {
        
        // Uncomment the line below to use a URL instead of embeded HTML
        // You must then comment out the other var thePath
        //let thePath = NSURL(string: "http://yourURLhere.com")
        
        let thePath = Bundle.main.url(forResource: "index", withExtension: "html")
        webView.mainFrame.load(NSURLRequest(url: thePath!) as URLRequest!)
        
        
    }
    
 

    
    func progress() {
        
        let timerInterval = TimeInterval(0.05)
        theTimer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(AppDelegate.refreshData), userInfo: nil, repeats: true)
        theTimer.fire()
        
    }
    
    
    
    
    
    @objc func refreshData() {
       
     
       //debugPrint(buildTime)
        //refresh the feedback label
        feedbackLabel.stringValue = logFileLastRecord()
        
        
        //setup the progressbar logic
        progressBar.controlTint = NSControlTint.blueControlTint
        progressBar.increment(by: 0.05)
        
        
        if useWayPointMessages {
            
            updateWaypointMethod()
            
        }
        
    }
    
    

    
    func updateWaypointMethod() {
        
 
        let logString = logFileLastRecord()
        
        if (logString.range(of: "Successfully installed " + quarterProgress) != nil) {
            
            
            if quarter == false  {
                
                quarter = true
                progressBar.doubleValue = estimatedCompletionTime / 4 }
            
        }
        
        if (logString.range(of: "Successfully installed " + halfProgress) != nil) {
            
            
            if half == false  {
                
                half = true
                progressBar.doubleValue = estimatedCompletionTime / 2 }
            
        }
        
        
        if (logString.range(of: "Successfully installed " + threeQuartersProgress) != nil) {
            
            
            if threeQuarter == false  {
                
                threeQuarter = true
                progressBar.doubleValue = estimatedCompletionTime / 1.33 }
            
        }
        
        
        
        if (logString.range(of: "Successfully installed " + lastPackage) != nil) {
            
            
            if end == false  {
                
                //When the last package is installed, quit this application.
                end = true
                NSApplication.shared.terminate(self)
                
            }

        }
        
    }
    
    
    
    
    
    @IBAction func quitButton(sender: AnyObject) {
        
        debugPrint("Quit")
        NSApplication.shared.terminate(self)

    }
    
    
    
    func  logFileLastRecord() -> String {
        
        //This method reads the jamf.log and returns the last line edited into a easy to read format for the user feedback.
        
        if let log = NSData(contentsOfFile: "/private/var/log/jamf.log") {
            
            
            let logString =  NSString(data: log as Data, encoding: String.Encoding.utf8.rawValue)
     
            
            let theRange = logString?.range(of: "]:", options: .backwards)
            let scanner = Scanner(string: logString! as String)
            scanner.scanLocation = (theRange?.location)!
            
            let lineReturn = NSMutableCharacterSet.newline()
            
            var logLine: NSString?
            while scanner.scanUpToCharacters(from: lineReturn as CharacterSet, into: &logLine),
                let logLine = logLine
                
            {
                debugPrint("Log Line: \(logLine)")
                
            }
            
            
            let trimTimeStamp = logLine!.replacingOccurrences(of: "]:", with: "")
            let removedSlash =  trimTimeStamp.replacingOccurrences(of: "\"", with: "") as NSString!
            let trimedWhiteSpace = removedSlash?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
            //debugPrint("Trimmed")
            //debugPrint(trimedWhiteSpace)
            
            
            return trimedWhiteSpace!
        
        } else {
            
            return "No jamf.log found." }
        
    }
    
    // End of Class

    override func indicesOfObjects(byEvaluatingObjectSpecifier specifier: NSScriptObjectSpecifier) -> [NSNumber]? {
        
        
        debugPrint(specifier)
        
        return super.indicesOfObjects(byEvaluatingObjectSpecifier: specifier)
        
    }
    
    

    
    
    

}

