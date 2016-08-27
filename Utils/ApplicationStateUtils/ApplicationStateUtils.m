//
//  ApplicationStateUtils.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "ApplicationStateUtils.h"

@implementation ApplicationStateUtils

+ (BOOL)getBoolProperty:(const NSString *)propertyName orDefault:(BOOL)defaultValue {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id property = [defaults objectForKey:(NSString *)propertyName];
    return property != nil ? [property boolValue] : defaultValue;
}

+ (void)setBoolProperty:(const NSString *)propertyName value:(BOOL)value {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:(NSString *)propertyName];
    [defaults synchronize];
}

+ (int)getIntProperty:(const NSString *)propertyName orDefault:(NSInteger)defaultValue {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id property = [defaults objectForKey:(NSString *)propertyName];
    return property != nil ? [property intValue] : (int)defaultValue;
}

+ (void)setIntProperty:(const NSString *)propertyName value:(NSInteger)value {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:value forKey:(NSString *)propertyName];
    [defaults synchronize];
}


+ (float)getFloatProperty:(const NSString *)propertyName orDefault:(float)defaultValue {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id property = [defaults objectForKey:(NSString *)propertyName];
    return property != nil ? [property floatValue] : defaultValue;
}

+ (void)setFloatProperty:(const NSString *)propertyName value:(float)value {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:value forKey:(NSString *)propertyName];
    [defaults synchronize];
}

+ (double)getDoubleProperty:(const NSString *)propertyName orDefault:(float)defaultValue {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id property = [defaults objectForKey:(NSString *)propertyName];
    return property != nil ? [property floatValue] : defaultValue;
}

+ (void)setDoubleProperty:(const NSString *)propertyName value:(double)value {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:value forKey:(NSString *)propertyName];
    [defaults synchronize];
}

+ (NSString *)getStringProperty:(const NSString *)propertyName orDefault:(NSString *)defaultValue {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *property = [defaults objectForKey:(NSString *)propertyName];
    return property != nil ? property : defaultValue;
}

+ (void)setStringProperty:(const NSString *)propertyName value:(NSString *)value {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:(NSString *)propertyName];
    [defaults synchronize];
}

+ (NSDate *)getDateProperty:(const NSString *)propertyName orDefault:(NSDate *)defaultValue {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *property = [defaults objectForKey:(NSString *)propertyName];
    return property != nil ? property : defaultValue;
}

+ (void)setDateProperty:(const NSString *)propertyName value:(NSDate *)value {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:(NSString *)propertyName];
    [defaults synchronize];
}

@end
