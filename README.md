# ProgressScreen


This is my recreation of the Casper Enrollment screen IBM showed at JAMFs user conference.

About: 
Simply, this is a full screen application that uses a Webview to display information to the user. This can either be an embedded html file or a website. The application monitors the jamf.log and in conjunction with waypoints and estimated time displays a progessbar to the user. When the last package is installed, the application quits.  The user can quit the screen any time with Command-Q.

Usage:

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
Set Progress Bar Total Time: *Time is in seconds
```

tell application "ProgressScreen"
set buildTime of every configuration to 2000
end tell 
```

Set the current progress time: 
```

tell application "ProgressScreen"
set currentTime of every configuration to 1000
end tell 
```

Configure FullScreen Mode: *This is set to FullScreen by default.
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
