//
//  SVScrollingCell.m
//  iOS7ScrollViews
//
//  Created by Pierre Felgines on 20/06/13.
//  Copyright (c) 2013 Pierre Felgines. All rights reserved.
//

#import "SVScrollingCell.h"

@interface SVScrollingCell () {
    UIScrollView * _scrollView;
    UIView * _colorView;
}

@end

@implementation SVScrollingCell

- (void)dealloc {
    [_color release];
    [_scrollView release];
    [_colorView retain];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _colorView = [[UIView alloc] init];
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self.contentView addSubview:_scrollView];
        [_scrollView release];
        
        [_scrollView addSubview:_colorView];
        [_colorView release];
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    if (color != _color) {
        [_color release];
        _color = [color retain];
    }
    _colorView.backgroundColor = color;
}

- (void)layoutSubviews {
    UIView * contentView = self.contentView;
    CGRect bounds = contentView.bounds;
    
    CGFloat pageWidth = bounds.size.width;
    _scrollView.frame = CGRectMake(0, 0, pageWidth, bounds.size.height);
    _scrollView.contentSize = CGSizeMake(pageWidth * 2, bounds.size.height);
    
    _colorView.frame = [_scrollView convertRect:bounds fromView:contentView];
}

@end
