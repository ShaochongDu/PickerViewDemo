//
//  DXIntervalSelectViewController.m
//  DXDesign
//
//  Created by caxa on 15/12/6.
//  Copyright © 2015年 mlf. All rights reserved.
//

#import "DSCPickerView.h"
#import "UIView+Addition.h"

@interface DSCPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bgView;    //  背景视图
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, assign)NSInteger selectedRow;     //  记录选择的行

@end

@implementation DSCPickerView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIColor *color = [UIColor blackColor];
    self.view.backgroundColor = [color colorWithAlphaComponent:0.5];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromView)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"tip:dealloc");
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
        self.pickerBlock(self.selectedRow);
    }
}

#pragma mark - show
- (void)showInView:(UIView *)view done:(DSCPickerDoneBlock)block cancelBlock:(DSCPickerCancelBlock)cancelBlock
{
    self.pickerBlock = [block copy];
    self.cancelBlock = [cancelBlock copy];
    
    CGRect viewFrame = self.view.frame;
    viewFrame = view.frame;
    viewFrame.origin = CGPointMake(0, 0);
    self.view.frame = viewFrame;
    [view addSubview:self.view];
    
    self.bgView.top = view.bottom;
    __block DSCPickerView *weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.bgView.bottom = view.bottom;
        
    }];
}

- (void)removeFromView
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    __block DSCPickerView *weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.bgView.top = weakSelf.view.bottom;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

#pragma mark - UIPickerView Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataSourceArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataSourceArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"tip:component->%ld,row->%ld ",(long)component,(long)row);
    
    self.selectedRow = row;
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
