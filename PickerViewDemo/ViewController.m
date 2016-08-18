//
//  ViewController.m
//  PickerViewDemo
//
//  Created by Shaochong Du on 16/3/4.
//  Copyright © 2016年 Shaochong Du. All rights reserved.
//

#import "ViewController.h"
#import "DSCPickerView.h"
#import "DSCDatePickerViewController.h"
#import "DSCPickerViewMuti.h"
#import "PlistFileTool.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showActionSheet:(id)sender
{
    DSCPickerView *pickVC = [[DSCPickerView alloc] init];
    [self addChildViewController:pickVC];

    pickVC.dataSourceArray = [NSMutableArray arrayWithObjects:@"北京",@"上海",@"广州", nil];
    [pickVC showInView:self.view done:^(NSInteger currentIndex) {
        NSLog(@" 选择 -> %ld ",currentIndex);
    } cancelBlock:^{
       
        [pickVC removeFromParentViewController];
    }];
}

- (IBAction)showDatePickerView:(id)sender
{
    DSCDatePickerViewController *pickVC = [[DSCDatePickerViewController alloc] init];
    [self addChildViewController:pickVC];
    
    [pickVC showInView:self.view done:^(NSDate *currentDate) {
        NSLog(@" 选择 -> %@ ",currentDate);
    } cancelBlock:^{
        
        [pickVC removeFromParentViewController];
    }];
}

- (IBAction)otherPickerView:(id)sender
{
//    [self loadUserHeightData];
    [self loadUserWeight];
//    [self loadUserSex];
}

- (void)loadUserHeightData
{
    DSCPickerViewMuti *pickVC = [[DSCPickerViewMuti alloc] init];
    pickVC.showTitle = YES;
    pickVC.valueType = ValueTypeFloat;
    pickVC.defaultTitle = @"165";
    pickVC.leftTitle = @"身高:";
    pickVC.unitStr = @"cm";
    [self addChildViewController:pickVC];
    
    pickVC.dataSourceArray = [PlistFileTool loadPlistFileName:@"UserHeight.plist"];
    [pickVC showInView:self.view done:^(NSInteger firstIndex, NSInteger secondIndex, NSInteger thirdIndex, NSString *valueStr) {
        NSLog(@"firstIndex:%ld,secondIndex:%ld,thirdIndex:%ld value:%@",firstIndex,secondIndex,thirdIndex,valueStr);
    } cancelBlock:^{
        [pickVC removeFromParentViewController];
    }];
    [pickVC.middleBarBtn setTitle:@"身高：165 cm" forState:UIControlStateNormal];
}

- (void)loadUserWeight
{
    DSCPickerViewMuti *pickVC = [[DSCPickerViewMuti alloc] init];
    pickVC.showTitle = YES;
    pickVC.valueType = ValueTypeFloat;
    pickVC.defaultTitle = @"60";
    pickVC.leftTitle = @"体重:";
    pickVC.unitStr = @"kg";
    [self addChildViewController:pickVC];
    
    pickVC.dataSourceArray = [PlistFileTool loadPlistFileName:@"UserWeight.plist"];
    [pickVC showInView:self.view done:^(NSInteger firstIndex, NSInteger secondIndex, NSInteger thirdIndex, NSString *valueStr) {
        NSLog(@"firstIndex:%ld,secondIndex:%ld,thirdIndex:%ld value:%@",firstIndex,secondIndex,thirdIndex,valueStr);
    } cancelBlock:^{
        [pickVC removeFromParentViewController];
    }];
    
    [pickVC scrollFirstComponentRow:0 secondComponentRow:6 thirdComponentRow:0];
    [pickVC.middleBarBtn setTitle:@"体重：60 kg" forState:UIControlStateNormal];
}

- (void)loadUserSex
{
    DSCPickerViewMuti *pickVC = [[DSCPickerViewMuti alloc] init];
    pickVC.showTitle = YES;
    pickVC.valueType = ValueTypeString;
    pickVC.defaultTitle = @"男";
    pickVC.leftTitle = @"性别:";
    pickVC.unitStr = @"";
    [self addChildViewController:pickVC];
    
    pickVC.dataSourceArray = [PlistFileTool loadPlistFileName:@"UserSex.plist"];
    [pickVC showInView:self.view done:^(NSInteger firstIndex, NSInteger secondIndex, NSInteger thirdIndex, NSString *valueStr) {
        NSLog(@"firstIndex:%ld,secondIndex:%ld,thirdIndex:%ld value:%@",firstIndex,secondIndex,thirdIndex,valueStr);
    } cancelBlock:^{
        [pickVC removeFromParentViewController];
    }];
    [pickVC.middleBarBtn setTitle:@"性别：男" forState:UIControlStateNormal];
}


@end
