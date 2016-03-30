//
//  ConfigurationSettings.h
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

#import <Cocoa/Cocoa.h>

extern NSString * const PSBuildTimeNotification;
extern NSString * const PSURLChange;
extern NSString * const PSCurrentTimeChange;
extern NSString * const PSFullScreen;
extern NSString * const PSHideQuit;
extern NSString * const PSHWayPointMethod;
extern NSString * const PSHWayPointOne;
extern NSString * const PSHWayPointTwo;
extern NSString * const PSHWayPointThree;
extern NSString * const PSHWayPointFour;
extern NSString * const PSAirWatch;

@interface ConfigurationSettings : NSObject

@property (nonatomic) NSString *uniqueID;
@property (nonatomic) NSNumber *buildTime;
@property (nonatomic) NSNumber *currentTime;
@property (nonatomic) NSString *htmlLocation;
@property (nonatomic) NSString *configName;
@property (nonatomic) BOOL fullscreen;
@property (nonatomic) BOOL hideQuitButton;
@property (nonatomic) BOOL useWayPointMethod;
@property (nonatomic) NSString *wayPointOne;
@property (nonatomic) NSString *wayPointTwo;
@property (nonatomic) NSString *wayPointThree;
@property (nonatomic) NSString *wayPointFour;

@property (nonatomic) BOOL useAirWatchLog;

@end
