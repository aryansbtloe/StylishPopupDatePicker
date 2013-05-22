//
//  AksPopUpDatePickerView.m
//  StylishPopupDatePicker
//
//  Created by Alok on 22/05/13.
//  Copyright (c) 2013 Konstant Info Private Limited. All rights reserved.
//

#import "AKSPopUpDatePickerView.h"

#define SCREENINSET   40.
#define HEADER_HEIGHT 50.
#define RADIUS        5.

@interface AKSPopUpDatePickerView (private)
- (void)fadeIn;
- (void)fadeOut;
@end

@implementation AKSPopUpDatePickerView
@synthesize delegate;

- (id)initWithTitle:(NSString *)aTitle WithDescription:(NSString *)aDescription {
    CGRect rect = [[UIScreen mainScreen] bounds];

    if (self = [super initWithFrame:rect]) {
        self.backgroundColor = [UIColor clearColor];

        _title = [aTitle copy];
        _description = [aDescription copy];

        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 90, 1, 1)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.hidden = NO;
        datePicker.date = [NSDate date];
        [self addSubview:datePicker];

        UIButton *closebutton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENINSET + rect.size.width - 2 * SCREENINSET - 15, HEADER_HEIGHT - 30, 30, 30)];
        [closebutton setImage:[UIImage imageNamed:@"closeIcon"] forState:UIControlStateNormal];
        [closebutton setImage:[UIImage imageNamed:@"closeIcon"] forState:UIControlStateHighlighted];
        [closebutton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closebutton];

        UIButton *acceptButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREENINSET -15 , HEADER_HEIGHT - 30, 30, 30)];
        [acceptButton setImage:[UIImage imageNamed:@"chooseIcon"] forState:UIControlStateNormal];
        [acceptButton setImage:[UIImage imageNamed:@"chooseIcon"] forState:UIControlStateHighlighted];
        [acceptButton addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:acceptButton];
    }
    return self;
}

#pragma mark - Private Methods
- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)fadeOut {
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Instance Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated {
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}

- (void)close {
    // tell the delegate the cancellation
    if (self.delegate && [self.delegate respondsToSelector:@selector(AKSPopUpDatePickerViewDidCancel)]) {
        [self.delegate AKSPopUpDatePickerViewDidCancel];
    }

    // dismiss self
    [self fadeOut];
}

- (void)choose {
    // tell the delegate the cancellation
    if (self.delegate && [self.delegate respondsToSelector:@selector(AKSPopUpDatePickerViewDidSelectedDate:)]) {
        [self.delegate AKSPopUpDatePickerViewDidSelectedDate:datePicker.date];
    }

    // dismiss self
    [self fadeOut];
}

#pragma mark - DrawDrawDraw
- (void)drawRect:(CGRect)rect {
    CGRect bgRect = CGRectInset(rect, SCREENINSET, SCREENINSET);
    CGRect titleRect = CGRectMake(SCREENINSET + 10, SCREENINSET + 10 + 5, rect.size.width -  2 * (SCREENINSET + 10), 30);
    CGRect descriptionRect = CGRectMake(SCREENINSET + 10, 310, rect.size.width -  2 * (SCREENINSET + 10), 140);
    CGRect separatorRect = CGRectMake(SCREENINSET, SCREENINSET + HEADER_HEIGHT - 2, rect.size.width - 2 * SCREENINSET, 2);

    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // Draw the background with shadow
    CGContextSetShadowWithColor(ctx, CGSizeZero, 6., [UIColor colorWithWhite:0 alpha:.75].CGColor);
    [[UIColor colorWithWhite:1 alpha:0.85] setFill];


    float x = SCREENINSET;
    float y = SCREENINSET;
    float width = bgRect.size.width;
    float height = bgRect.size.height;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, x, y + RADIUS);
    CGPathAddArcToPoint(path, NULL, x, y, x + RADIUS, y, RADIUS);
    CGPathAddArcToPoint(path, NULL, x + width, y, x + width, y + RADIUS, RADIUS);
    CGPathAddArcToPoint(path, NULL, x + width, y + height, x + width - RADIUS, y + height, RADIUS);
    CGPathAddArcToPoint(path, NULL, x, y + height, x, y + height - RADIUS, RADIUS);
    CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    CGContextFillPath(ctx);
    CGPathRelease(path);

    // Draw the title and the separator with shadow
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 0.5f, [UIColor blackColor].CGColor);
    [[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.75] setFill];
    [_title drawInRect:titleRect withFont:[UIFont fontWithName:@"Marker Felt" size:18]];
    CGContextFillRect(ctx, separatorRect);

    // Draw the description and the separator with shadow
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 1), 0.5f, [UIColor blackColor].CGColor);
    [[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.75] setFill];
    [_description drawInRect:descriptionRect withFont:[UIFont fontWithName:@"Marker Felt" size:18]];
}

@end
