//
//  CollectionUIViewDetailViewController.m
//  YSLTransitionAnimatorDemo
//
//  Created by Wojciech Rutkowski 2016/02/04.
//  Copyright (c) 2016年 h.yamaguchi. All rights reserved.
//

#import "CollectionUIViewDetailViewController.h"

#import "YSLTransitionAnimator.h"
#import "UIViewController+YSLTransition.h"

@interface CollectionUIViewDetailViewController () <YSLTransitionAnimatorDataSource>

@property (nonatomic, weak) IBOutlet UIView *headerView;

@end

@implementation CollectionUIViewDetailViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self ysl_removeTransitionDelegate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self ysl_addTransitionDelegate:self];
    [self ysl_popTransitionAnimationWithCurrentScrollView:nil
                                    cancelAnimationPointY:0
                                        animationDuration:0.3
                                  isInteractiveTransition:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    // header
    // If you're using a xib and storyboard. Be sure to specify the frame
    _headerView.frame = CGRectMake(0, statusHeight + navigationHeight, rect.size.width, 250);
    
//    // custom navigation left item
//    __weak CollectionUIViewDetailViewController *weakself = self;
//    [self ysl_setUpReturnBtnWithColor:[UIColor lightGrayColor]
//                      callBackHandler:^{
//                          [weakself.navigationController popViewControllerAnimated:YES];
//                      }];
}

#pragma mark -- YSLTransitionAnimatorDataSource
- (UIImageView *)popTransitionImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    return imageView;
}

- (UIImageView *)pushTransitionImageView
{
    return nil;
}

@end
