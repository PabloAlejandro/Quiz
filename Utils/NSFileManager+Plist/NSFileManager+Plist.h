//
//  NSFileManager+Plist.h
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 26/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Plist)

// Method to get content of plis file as an array of NSDictionary 
- (id)readPlist:(NSString *)fileName;

- (void)readPlistAsync:(NSString *)fileName completion:(void (^)(id content, NSError * error))completion;

@end
