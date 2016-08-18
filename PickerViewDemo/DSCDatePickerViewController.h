//
//  DSCDatePickerViewController.h
//  PickerViewDemo
//
//  Created by Shaochong Du on 16/3/4.
//  Copyright © 2016年 Shaochong Du. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DSCDatePickerDoneBlock)(NSDate *currentDate);
typedef void(^DSCDatePickerCancelBlock)();

@interface DSCDatePickerViewController : UIViewController

@property (nonatomic, copy)DSCDatePickerDoneBlock pickerBlock;
@property (nonatomic, copy)DSCDatePickerCancelBlock cancelBlock;

- (void)showInView:(UIView *)view done:(DSCDatePickerDoneBlock)block cancelBlock:(DSCDatePickerCancelBlock)cancelBlock;



@end
