//
//  CollectionCell.m
//  Quiz
//
//  Created by Pablo Alejandro Perez Martinez on 27/08/2016.
//  Copyright © 2016 Pau. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    self.transform = CGAffineTransformMakeScale(.95, .95);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:.15f animations:^{
        weakSelf.transform = CGAffineTransformIdentity;
    }];
}

@end
