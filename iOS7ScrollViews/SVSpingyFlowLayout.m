//
//  SVSpingyFlowLayout.m
//  iOS7ScrollViews
//
//  Created by Kyle Fang on 9/3/13.
//  Copyright (c) 2013 Pierre Felgines. All rights reserved.
//

#import "SVSpingyFlowLayout.h"

@implementation SVSpingyFlowLayout{
    UIDynamicAnimator *_dynamicAnimator;
}

- (void)prepareLayout{
    [super prepareLayout];
    CGSize contentSize = [self collectionViewContentSize];
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
    
    if (!_dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        for (UICollectionViewLayoutAttributes *item in items) {
            UIAttachmentBehavior *spring = [[[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center] retain];
            spring.length = 0.f;
            spring.damping = 0.5;
            spring.frequency = 0.8;
            [_dynamicAnimator addBehavior:spring];
        }
        
    }
    

}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return [_dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [_dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrolledDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    CGPoint touchPoint = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    for (UIAttachmentBehavior *spring in _dynamicAnimator.behaviors) {
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabsf(anchorPoint.y - touchPoint.y);
        CGFloat scrollResistance = distanceFromTouch / 500.f;
        
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        CGPoint center = item.center;
        center.y += scrolledDelta * MIN(1, scrollResistance);
        item.center = center;
        
        [_dynamicAnimator updateItemUsingCurrentState:item];
        
    }
    
    return NO;
}

- (void)dealloc{
    _dynamicAnimator = nil;
    [super dealloc];
}

@end
