//
//  HomeViewController.m
//  StylishPopupDatePicker
//
//  Created by Alok on 22/05/13.
//  Copyright (c) 2013 Konstant Info Private Limited. All rights reserved.
//

#import "HomeViewController.h"
#import "AksPopUpDatePickerView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        [self showDemo];
    });
}

#pragma mark - AKSPopUpDatePickerView delegates

- (void)showDemo {
    AKSPopUpDatePickerView *aKSPopUpDatePickerView = [[AKSPopUpDatePickerView alloc] initWithTitle:@"Select due date..."WithDescription:@"The date u will choose will be the max due date for this task..."];
    aKSPopUpDatePickerView.delegate = self;
    [aKSPopUpDatePickerView showInView:self.view animated:YES];
}

- (void)AKSPopUpDatePickerViewDidSelectedDate:(NSDate *)date {
	NSLog(@"%@",date);
}

- (void)AKSPopUpDatePickerViewDidCancel {
}

@end
