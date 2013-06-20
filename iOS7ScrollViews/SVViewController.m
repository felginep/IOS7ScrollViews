//
//  SVViewController.m
//  iOS7ScrollViews
//
//  Created by Pierre Felgines on 20/06/13.
//  Copyright (c) 2013 Pierre Felgines. All rights reserved.
//

#import "SVViewController.h"
#import "SVScrollingCell.h"

static NSString * cellIdentifier = @"CellIdentifier";

@interface SVViewController (Private)
- (CGFloat)_random;
@end

@implementation SVViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.collectionView.dataSource = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.collectionView registerClass:[SVScrollingCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    self.scrollView.contentSize = CGSizeMake(2 * self.view.frame.size.width, self.view.frame.size.height);
    
}

- (void)dealloc {
    [_collectionView release];
    [_flowLayout release];
    [_scrollView release];
    [_otherView release];
    [super dealloc];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SVScrollingCell * cell = (SVScrollingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    CGFloat red = [self _random];
    CGFloat green = [self _random];
    CGFloat blue = [self _random];
    cell.color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    return cell;
}

@end

@implementation SVViewController (Private)

- (CGFloat)_random {
    return (float)rand() / (float)RAND_MAX;
}

@end
