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

+ (id)getObjectProperty:(const NSString *)propertyName orDefault:(id)defaultValue;
+ (void)setObjectProperty:(const NSString *)propertyName value:(id)value;

@end
