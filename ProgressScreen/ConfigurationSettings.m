//
//  ConfigurationSettings.m
//  ProgressScreen
//
//  Created by Tratta, Jason A on 3/17/16.
//  Copyright © 2016 Indiana University. All rights reserved.
//

#import "ConfigurationSettings.h"




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
    
    [self addObserver:self forKeyPath:@"configName" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"buildTime" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    [self addObserver:self forKeyPath:@"hmtlLocation" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    
    return self;
}






- (NSUniqueIDSpecifier *)objectSpecifier {
    
 
    NSScriptClassDescription *appDescription = (NSScriptClassDescription *)[NSApp classDescription];
    return [[NSUniqueIDSpecifier alloc] initWithContainerClassDescription:appDescription containerSpecifier:nil key:@"configuration" uniqueID:self.uniqueID];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context  {
    
    
    NSLog(@"%@",keyPath);
    
}



@end
