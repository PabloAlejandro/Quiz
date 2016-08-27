//
//  ApplicationStateUtils.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Class to get/set properties that are stored to NSUserDefaults
 */
@interface ApplicationStateUtils : NSObject

+ (BOOL)getBoolProperty:(const NSString *)propertyName orDefault:(BOOL)defaultValue;
+ (void)setBoolProperty:(const NSString *)propertyName value:(BOOL)value;

+ (int)getIntProperty:(const NSString *)propertyName orDefault:(NSInteger)defaultValue;
+ (void)setIntProperty:(const NSString *)propertyName value:(NSInteger)value;

+ (float)getFloatProperty:(const NSString *)propertyName orDefault:(float)defaultValue;
+ (void)setFloatProperty:(const NSString *)propertyName value:(float)value;

+ (double)getDoubleProperty:(const NSString *)propertyName orDefault:(float)defaultValue;
+ (void)setDoubleProperty:(const NSString *)propertyName value:(double)value;

+ (NSString *)getStringProperty:(const NSString *)propertyName orDefault:(NSString *)defaultValue;
+ (void)setStringProperty:(const NSString *)propertyName value:(NSString *)value;

+ (NSDate *)getDateProperty:(const NSString *)propertyName orDefault:(NSDate *)defaultValue;
+ (void)setDateProperty:(const NSString *)propertyName value:(NSDate *)value;

// Note: Despite we just need two of these methods, it is good to provide the whole
// suit of methods in case we need some of them in the future.

@end
