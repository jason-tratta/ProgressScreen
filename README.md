# ProgressScreen


This is my recreation of the Casper Enrollment screen IBM showed at JAMFs user conference.

About: 
Simply, this is a full screen application that uses a Webview to display information to the user. This can either be an embedded html file or a website. The application monitors the jamf.log and in conjunction with waypoints and estimated time displays a progessbar to the user. When the last package is installed, the application quits.  The user can quit the screen any time with Command-Q.

Usage:
The application uses waypoints you set and monitors the jamf.log to give the user feedback. In the ViewController.swift file simply edit the esitmatedCompletionTime and the package waypoints. 

You can replace the files in "htmlFiles" with your own index.html, or, edit the url path in the "loadWebPage()" method.

NEW!
Applescript / JavaScript Support!

You can now setup ProgressScreen through scripting, no more coding needed.  

Examples:

Set HTML Content:
'''

tell application "ProgressScreen"
set htmlURL of every configuration to "/Users/username/Documents/TestHTML/index.html"
end tell
'''
Set Progress Bar Total Time: *Time is in seconds
'''

tell application "ProgressScreen"
set buildTime of every configuration to 2000
end tell 
'''

Set the current progress time: 
'''

tell application "ProgressScreen"
set currentTime of every configuration to 1000
end tell 
'''

