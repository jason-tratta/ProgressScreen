# ProgressScreen


This is a full screen application that uses a web view to display information to the user. This is intended to show information to the end user during builds using JAMF’s Casper, though you may find other uses for it. This application was inspired by IBM’s build process shown at JAMFs user conference in 2015.

The web view can either be embedded or set via scripting.  Embedding the HTML will require you to recompile the application. 

The application monitors the jamf.log and in conjunction with optional waypoints an estimated time displays a progessbar to the user. When the last package is installed, the application quits.  The user can quit the screen any time with Command-Q.


Usage:

- Create and Set your own HTML Content. Pages can continually be changed via scripting if desired.
- Set the estimated build time, this will allow the progress bar to display a more accurate estiamed completion time.
- Update the progess bar by editing currentTime via scripting along side an optional waypoint method.

NEW!
Applescript / JavaScript Support!

You can now setup ProgressScreen through scripting, no more coding needed.  

Examples:

Set HTML Content:
```

tell application "ProgressScreen"
set htmlURL of every configuration to "/Users/username/Documents/TestHTML/index.html"
end tell
```
Set Progress Bar Total Time: (in seconds)
```

tell application "ProgressScreen"
set buildTime of every configuration to 2000
end tell 
```

Set the current progress time: (in Seconds)
```

tell application "ProgressScreen"
set currentTime of every configuration to 1000
end tell 
```

Configure FullScreen Mode:  (FullScreen default)
```
tell application "ProgressScreen"
set fullscreen of every configuration to true
end tell
```
Show / Hide the Quit Button on the Screen:  (Shows by default) 
```
tell application "ProgressScreen"
	set hideQuitButton of every configuration to true
end tell
```

Waypoints:
You can enable the waypoint method to help position the progress bar display a more accurate completion time. You MUST know the order in which your packages will be delivered for this to work. There are four waypoints which will adjust the progress bar in the following order: 1/4, 1/2, 3/4, and completion. 

Example Script:
```

tell application "ProgressScreen"
	set useWayPointMethod of every configuration to true
	set wayPointOne of every configuration to "Chrome.pkg"
	set wayPointTwo of every configuration to "FireFox.pkg"
	set wayPointThree of every configuration to "Office.pkg"
	set wayPointFour of every configuration to "CyberDuck.pkg"
end tell
```





![alt tag](https://github.com/jason-tratta/ProgressScreen/blob/master/ProgressScreen/ScreenShot.png)
