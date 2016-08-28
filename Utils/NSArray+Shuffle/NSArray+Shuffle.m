//
//  NSArray+Shuffle.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 27/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "NSArray+Shuffle.h"

@implementation NSArray (Shuffle)

- (NSArray *)shuffledArray
{
    NSUInteger count = [self count];
    NSMutableArray * mutable = [self mutableCopy];
    if (count < 1) return nil;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [mutable exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return [mutable copy];
}

@end
