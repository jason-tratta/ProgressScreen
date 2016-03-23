//
//  PSApplication.m
//  ScriptingTest
//
//  Created by Tratta, Jason A on 3/22/16.
//  Copyright © 2016 Jason Tratta. All rights reserved.
//

#import "PSApplication.h"
#import "ConfigurationSettings.h"

@interface PSApplication ()

@property (nonatomic) NSMutableArray *configurations;


@end


@implementation PSApplication

@synthesize configurations = _configurations;



- (NSMutableArray *)configurations {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
    ConfigurationSettings *defaultSettings = [ConfigurationSettings new];

    
    _configurations = [@[defaultSettings]mutableCopy];
    
    	});
    
    return _configurations;
    
}

- (void)insertObject:(ConfigurationSettings *)object inNotesAtIndex:(NSUInteger)index {
    
    [self.configurations insertObject:object atIndex:index];
}


- (void)removeObjectFromNotesAtIndex:(NSUInteger)index {
    
    [self.configurations removeObjectAtIndex:index];
}


@end
