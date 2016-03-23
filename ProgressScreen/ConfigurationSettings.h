//
//  ConfigurationSettings.h
//  ProgressScreen
//
//  Created by Tratta, Jason A on 3/17/16.
//  Copyright © 2016 Indiana University. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ConfigurationSettings : NSObject

@property (nonatomic) NSString *uniqueID;
@property (nonatomic) NSNumber *buildTime;
@property (nonatomic) NSString *htmlLocation;
@property (nonatomic) NSString *configName;


@end
