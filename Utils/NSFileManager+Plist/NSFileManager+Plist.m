//
//  NSFileManager+Plist.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "NSFileManager+Plist.h"

@implementation NSFileManager (Plist)

#pragma mark - Public class methods

- (id)readPlist:(NSString *)fileName
{
    return [self readPlist:fileName extension:@"plist"];
}

- (void)readPlistAsync:(NSString *)fileName completion:(void (^)(id content, NSError * error))completion
{
    [self readPlistAsync:fileName extension:@"plist" completion:completion];
}

#pragma mark - Private class methods

- (id)readPlist:(NSString *)fileName extension:(NSString *)fileExtension
{
    // Get NSString with file path
    NSString *strplistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension];
    
    // read property list into memory as an NSData  object
    NSData * fileData = [[NSFileManager defaultManager] contentsAtPath:strplistPath];
    
    if(!fileData) {return nil;}
    
    NSError *error = nil;
    NSPropertyListFormat plistFormat;
    return [NSPropertyListSerialization
            propertyListWithData:fileData
            options:NSPropertyListMutableContainersAndLeaves
            format:&plistFormat error:&error];
}

- (void)readPlistAsync:(NSString *)fileName extension:(NSString *)fileExtension completion:(void (^)(id content, NSError * error))completion
{
    // If there is no completion we don't run anything
    if (!completion) {return;}
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Get NSString with file path
        NSString *strplistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension];
        
        // read property list into memory as an NSData  object
        NSData * fileData = [[NSFileManager defaultManager] contentsAtPath:strplistPath];
        
        NSError *error = nil;
        NSPropertyListFormat plistFormat;
        // convert static property liost into dictionary object
        id temp = [NSPropertyListSerialization
                   propertyListWithData:fileData
                   options:NSPropertyListMutableContainersAndLeaves
                   format:&plistFormat error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(temp, error);
        });
    });
}

@end

