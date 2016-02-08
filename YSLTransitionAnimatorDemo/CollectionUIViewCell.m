//
//  CollectionUIViewCell.m
//  YSLTransitionAnimatorDemo
//
//  Created by Wojciech Rutkowski on 2016/02/04.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "CollectionUIViewCell.h"

@implementation CollectionUIViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius = 7.0f;
    self.clipsToBounds = YES;
}

@end
