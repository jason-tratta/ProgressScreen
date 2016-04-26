//
//  ConfigurationSettings.m
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


#import "ConfigurationSettings.h"

NSString * const PSBuildTimeNotification = @"PSBuildTimeNotification";
NSString * const PSURLChange = @"PSURLChange";
NSString * const PSCurrentTimeChange = @"PSCurrentTimeChange";
NSString * const PSFullScreen = @"PSFullScreen";
NSString * const PSHideQuit = @"PSHideQuit";
NSString * const PSHWayPointOne = @"PSHWayPointOne";
NSString * const PSHWayPointTwo = @"PSHWayPointTwo";
NSString * const PSHWayPointThree = @"PSHWayPointThree";
NSString * const PSHWayPointFour = @"PSHWayPointFour";
NSString * const PSHWayPointMethod = @"PSHWayPointMethod";





@implementation ConfigurationSettings



- (instancetype)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _uniqueID = [[NSUUID UUID] UUIDString];
    _buildTime = [NSNumber numberWithInt:167];
    _configName = [NSString stringWithFormat:@"Default"];
    _htmlLocation = [NSString stringWithFormat:@"/Path/To/HTML"];
    _fullscreen = YES;
    _hideQuitButton = NO;
    _useWayPointMethod = NO;
    
    [self addObserver:self forKeyPath:@"configName" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"buildTime" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"htmlLocation" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"currentTime" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"fullscreen" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"hideQuitButton" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"useWayPointMethod" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"wayPointOne" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"wayPointTwo" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"wayPointThree" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"wayPointFour" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    
    
    return self;
}






- (NSUniqueIDSpecifier *)objectSpecifier {
    
 
    NSScriptClassDescription *appDescription = (NSScriptClassDescription *)[NSApp classDescription];
    return [[NSUniqueIDSpecifier alloc] initWithContainerClassDescription:appDescription containerSpecifier:nil key:@"configuration" uniqueID:self.uniqueID];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context  {
    
    
    NSLog(@"%@",keyPath);
    
    if ([keyPath isEqualToString:@"buildTime"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PSBuildTimeNotification" object:self];
    }
    
    if ([keyPath isEqualToString:@"htmlLocation"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PSURLChange" object:self];
    }
    
    if ([keyPath isEqualToString:@"currentTime"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PSCurrentTimeChange" object:self];
    }
    
    if ([keyPath isEqualToString:@"fullscreen"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PSFullScreen" object:self];
    }
    
    if ([keyPath isEqualToString:@"hideQuitButton"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PSHideQuit" object:self];
    }
    
    if ([keyPath isEqualToString:@"useWayPointMethod"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PSHWayPointMethod" object:self];
    }
    
    if ([keyPath isEqualToString:@"wayPointOne"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PSHWayPointOne" object:self];
    }
    
    if ([keyPath isEqualToString:@"wayPointTwo"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PSHWayPointTwo" object:self];
    }
    
    if ([keyPath isEqualToString:@"wayPointThree"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PSHWayPointThree" object:self];
    }
    
    
    if ([keyPath isEqualToString:@"wayPointFour"]) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"PSHWayPointFour" object:self];
    }
    
    
}



@end
