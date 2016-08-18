//
//  DSCDatePickerViewController.m
//  PickerViewDemo
//
//  Created by Shaochong Du on 16/3/4.
//  Copyright © 2016年 Shaochong Du. All rights reserved.
//

#import "DSCDatePickerViewController.h"
#import "UIView+Addition.h"

@interface DSCDatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *selectDate;   //  选中的时间

@end

@implementation DSCDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIColor *color = [UIColor blackColor];
    self.view.backgroundColor = [color colorWithAlphaComponent:0.5];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromView)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
    
    self.datePicker.minimumDate = [NSDate date];
    self.selectDate = [NSDate date];
    
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - toolbar btn action
- (IBAction)cancleBtnAction:(id)sender
{
    [self removeFromView];
}

- (IBAction)doneBtnAction:(id)sender
{
    [self removeFromView];
    if (self.pickerBlock) {
        self.pickerBlock(self.selectDate);
    }
}

#pragma mark - show
- (void)showInView:(UIView *)view done:(DSCDatePickerDoneBlock)block cancelBlock:(DSCDatePickerCancelBlock)cancelBlock
{
    self.pickerBlock = [block copy];
    self.cancelBlock = [cancelBlock copy];
    
    CGRect viewFrame = self.view.frame;
    viewFrame = view.frame;
    viewFrame.origin = CGPointMake(0, 0);
    self.view.frame = viewFrame;
    [view addSubview:self.view];
    
    self.bgView.top = view.bottom;
    __block DSCDatePickerViewController *weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.bgView.bottom = view.bottom;
        
    }];
}

- (void)removeFromView
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    __block DSCDatePickerViewController *weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.bgView.top = weakSelf.view.bottom;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

#pragma mark - 
- (void)dateChanged:(UIDatePicker *)picker
{
    self.selectDate = picker.date;
    NSLog(@"%@",picker.date);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
