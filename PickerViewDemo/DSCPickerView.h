//
//  DXIntervalSelectViewController.h
//  DXDesign
//
//  Created by caxa on 15/12/6.
//  Copyright © 2015年 mlf. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  完成回调
 *
 *  @param currentIndex  当前选择的行索引
 */
typedef void(^DSCPickerDoneBlock)(NSInteger currentIndex);
typedef void(^DSCPickerCancelBlock)();


@interface DSCPickerView : UIViewController

@property (nonatomic, strong) NSMutableArray *dataSourceArray;  //  数据源

@property (nonatomic, copy)DSCPickerDoneBlock pickerBlock;
@property (nonatomic, copy)DSCPickerCancelBlock cancelBlock;

- (void)showInView:(UIView *)view done:(DSCPickerDoneBlock)block cancelBlock:(DSCPickerCancelBlock)cancelBlock;

@end
