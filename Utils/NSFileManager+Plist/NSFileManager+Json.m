//
//  NSFileManager+Json.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "NSFileManager+Json.h"

@implementation NSFileManager (Json)

#pragma mark - Public class methods

- (id)readJson:(NSString *)fileName
{
    return [self readJson:fileName extension:@"json"];
}

- (void)readJsonAsync:(NSString *)fileName completion:(void (^)(id content, NSError * error))completion
{
    [self readJsonAsync:fileName extension:@"json" completion:completion];
}

#pragma mark - Private class methods

- (id)readJson:(NSString *)fileName extension:(NSString *)fileExtension
{
    // Get NSString with file path
    NSString *strPath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension];
    
    // read property list into memory as an NSData  object
    NSData * fileData = [[NSFileManager defaultManager] contentsAtPath:strPath];
    
    if(!fileData) {return nil;}
    
    NSError *error = nil;
    
    return [NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:&error];
}

- (void)readJsonAsync:(NSString *)fileName extension:(NSString *)fileExtension completion:(void (^)(id content, NSError * error))completion
{
    // If there is no completion we don't run anything
    if (!completion) {return;}
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Get NSString with file path
        NSString *strPath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileExtension];
        
        // read property list into memory as an NSData  object
        NSData * fileData = [[NSFileManager defaultManager] contentsAtPath:strPath];
        
        NSError *error = nil;
        id content = [NSJSONSerialization JSONObjectWithData:fileData options:kNilOptions error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(content, error);
        });
        
    });
}

@end

