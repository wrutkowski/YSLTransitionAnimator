//
//  CollectionUIViewViewController.m
//  YSLTransitionAnimatorDemo
//
//  Created by Wojciech Rutkowski on 2016/02/04..
//  Copyright (c) 2016年 h.yamaguchi. All rights reserved.
//

#import "CollectionUIViewViewController.h"
#import "CollectionUIViewCell.h"
#import "CollectionUIViewDetailViewController.h"

#import "YSLTransitionAnimator.h"
#import "UIViewController+YSLTransition.h"

@interface CollectionUIViewViewController () <UICollectionViewDelegateFlowLayout, YSLTransitionAnimatorDataSource>

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation CollectionUIViewViewController

static NSString * const reuseIdentifier = @"CollectionUIViewCell";

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
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    [self ysl_addTransitionDelegate:self];
    [self ysl_pushTransitionAnimationWithToViewControllerImagePointY:statusHeight + navigationHeight
                                                   animationDuration:0.3];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionUIViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionUIViewCell *cell = (CollectionUIViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.itemLabel.text = [NSString stringWithFormat:@"Item #%ld",(long)indexPath.row];
    cell.itemLabel2.text = [NSString stringWithFormat:@"Item Index %ld",(long)indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     CollectionUIViewDetailViewController *vc = [[CollectionUIViewDetailViewController alloc]init];
     [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width / 2) - 9, (self.view.frame.size.width / 2) - 9);
}

#pragma mark -- YSLTransitionAnimatorUIViewDataSource

- (UIImageView *)pushTransitionImageView
{
    CollectionUIViewCell *cell = (CollectionUIViewCell *)[self.collectionView cellForItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] firstObject]];
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] firstObject]];
    CGRect cellRect = attributes.frame;
    CGRect cellFrameInSuperview = [self.collectionView convertRect:cellRect toView:[self.collectionView superview]];
    CGRect rect = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [cell.backgroundColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = cellFrameInSuperview;
    return imageView;
}

- (UIImageView *)popTransitionImageView
{
    return nil;
}


@end
