//
//  AksPopUpDatePickerView.h
//  StylishPopupDatePicker
//
//  Created by Alok on 22/05/13.
//  Copyright (c) 2013 Konstant Info Private Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AKSPopUpDatePickerViewDelegate;

@interface AKSPopUpDatePickerView : UIView
{
    UIDatePicker *datePicker;
    NSString *_title;
    NSString *_description;
}

@property (nonatomic, assign) id<AKSPopUpDatePickerViewDelegate> delegate;
- (id)initWithTitle:(NSString *)aTitle WithDescription:(NSString *)aDescription;
- (void)showInView:(UIView *)aView animated:(BOOL)animated;
@end

@protocol AKSPopUpDatePickerViewDelegate <NSObject>
- (void)AKSPopUpDatePickerViewDidSelectedDate:(NSDate *)date;
- (void)AKSPopUpDatePickerViewDidCancel;
@end