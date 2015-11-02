# ProgressScreen


This is my recreation of the Casper Enrollment screen IBM showed at JAMFs user conference.

About: 
Simply, this is a full screen application that uses a Webview to display information to the user. This can either be an embedded html file or a website. The application monitors the jamf.log and in conjunction with waypoints and estimated time displays a progessbar to the user. When the last package is installed, the application quits.  The user can quit the screen any time with Command-Q.

Usage:
The application uses waypoints you set and monitors the jamf.log to give the user feedback. In the ViewController.swift file simply edit the esitmatedCompletionTime and the package waypoints. 

You can replace the files in "htmlFiles" with your own index.html, or, edit the url path in the "loadWebPage()" method.

![alt tag](https://github.com/jason-tratta/ProgressScreen/blob/master/ProgressScreen/ScreenShot.png)
