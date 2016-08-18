//
//  DXIntervalSelectViewController.m
//  DXDesign
//
//  Created by caxa on 15/12/6.
//  Copyright © 2015年 mlf. All rights reserved.
//

#import "DSCPickerViewMuti.h"
#import "UIView+Addition.h"
#import "PlistFileTool.h"

#define kDefaultTag 999 //  默认值
@interface DSCPickerViewMuti ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bgView;    //  背景视图
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, copy)NSString *firstComponentRowTitle;     //  第一列选中的行
@property (nonatomic, copy)NSString *secondComponentRowTitle;     //  第一列选中的行
@property (nonatomic, copy)NSString *thirdComponentRowTitle;     //  第一列选中的行

@end

@implementation DSCPickerViewMuti

-(instancetype)init
{
    if (self = [super init]) {
        self.firstComponentRowIndex = 0;
        self.secondComponentRowIndex = 0;
        self.thirdComponentRowIndex = 0;
        self.componentWith = 60;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIColor *color = [UIColor blackColor];
    self.view.backgroundColor = [color colorWithAlphaComponent:0.5];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromView)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tap];
    
    self.pickerView.showsSelectionIndicator = YES;
    
    if (self.showTitle) {
        [self.middleBarBtn setTitle:[NSString stringWithFormat:@"%@%@ %@",[self getNotNilStr:self.leftTitle],self.defaultTitle,[self getNotNilStr:self.unitStr]] forState:UIControlStateNormal];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"tip:dealloc");
}

- (void)scrollFirstComponentRow:(NSInteger)firstComponentRow secondComponentRow:(NSInteger)secondComponentRow thirdComponentRow:(NSInteger)thirdComponentRow
{
    if (firstComponentRow != kDefaultTag) {
        [_pickerView selectRow:firstComponentRow inComponent:0 animated:NO];
    }
    if (secondComponentRow != kDefaultTag) {
        [_pickerView selectRow:secondComponentRow inComponent:1 animated:NO];
    }
    if (thirdComponentRow != kDefaultTag) {
        [_pickerView selectRow:thirdComponentRow inComponent:2 animated:NO];
    }
    
}

#pragma mark - toolbar btn action
- (IBAction)cancleBtnAction:(id)sender
{
    [self removeFromView];
}

- (IBAction)doneBtnAction:(id)sender
{
    [self removeFromView];
    if (self.pickerMutiBlock) {
        self.pickerMutiBlock(self.firstComponentRowIndex,self.secondComponentRowIndex,self.thirdComponentRowIndex,self.defaultTitle);
    }
}

#pragma mark - show
- (void)showInView:(UIView *)view done:(DSCPickerMutiDoneBlock)block cancelBlock:(DSCPickerMutiCancelBlock)cancelBlock
{
    self.pickerMutiBlock = [block copy];
    self.cancelMutiBlock = [cancelBlock copy];
    
    CGRect viewFrame = self.view.frame;
    viewFrame = view.frame;
    viewFrame.origin = CGPointMake(0, 0);
    self.view.frame = viewFrame;
    [view addSubview:self.view];
    
    self.bgView.top = view.bottom;
    __block DSCPickerViewMuti *weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.bgView.bottom = view.bottom;
        
    }];
}

- (void)removeFromView
{
    if (self.cancelMutiBlock) {
        self.cancelMutiBlock();
    }
    
    __block DSCPickerViewMuti *weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.bgView.top = weakSelf.view.bottom;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

#pragma mark - UIPickerView Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.dataSourceArray.count;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSDictionary *sectionDic = self.dataSourceArray[component];
    return [sectionDic[kDataArray] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self getValueOfComponent:component row:row];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.componentWith;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"tip:component->%ld,row->%ld ",(long)component,(long)row);
    
    if (component == 0) {
        self.firstComponentRowIndex = row;
        self.firstComponentRowTitle = [self getValueOfComponent:component row:row];
    } else if (component == 1) {
        self.secondComponentRowIndex = row;
        self.secondComponentRowTitle = [self getValueOfComponent:component row:row];
    } else {
        self.thirdComponentRowIndex = row;
        self.thirdComponentRowTitle = [self getValueOfComponent:component row:row];
    }
    
    [self updateMiddlebtn];
}

//  获取相应标题
- (NSString *)getValueOfComponent:(NSInteger)component row:(NSInteger)row
{
    NSDictionary *sectionDic = self.dataSourceArray[component];
    NSArray *sectionDataArray = sectionDic[kDataArray];
    NSDictionary *dataDic = sectionDataArray[row];
    return dataDic[kModuleName];
}

//  更新标题
- (void)updateMiddlebtn
{
    if (self.showTitle) {
        [self.middleBarBtn setTitle:[NSString stringWithFormat:@"%@%@ %@",[self getNotNilStr:self.leftTitle],[self getSelectRowValue],[self getNotNilStr:self.unitStr]] forState:UIControlStateNormal];
    }
}

- (NSString *)getSelectRowValue
{
    if (self.valueType == ValueTypeFloat) {
        if (self.dataSourceArray.count == 3) {
            CGFloat firstValue = [[self getNotNilStr:self.firstComponentRowTitle] floatValue]*100;
            CGFloat secondValue = [[self getNotNilStr:self.secondComponentRowTitle] floatValue]*10;
            CGFloat thirdValue = [[self getNotNilStr:self.thirdComponentRowTitle] floatValue];
            self.defaultTitle = [NSString stringWithFormat:@"%.f",firstValue+secondValue+thirdValue];
            return self.defaultTitle;
        } else if (self.dataSourceArray.count == 2) {
            CGFloat firstValue = [[self getNotNilStr:self.firstComponentRowTitle] floatValue]*10;
            CGFloat secondValue = [[self getNotNilStr:self.secondComponentRowTitle] floatValue];
            self.defaultTitle = [NSString stringWithFormat:@"%.f",firstValue+secondValue];
            return self.defaultTitle;
        } else {
            CGFloat firstValue = [[self getNotNilStr:self.firstComponentRowTitle] floatValue];
            self.defaultTitle = [NSString stringWithFormat:@"%.f",firstValue];
            return self.defaultTitle;
        }
    }
    self.defaultTitle = [NSString stringWithFormat:@"%@%@%@",[self getNotNilStr:self.firstComponentRowTitle],[self getNotNilStr:self.secondComponentRowTitle],[self getNotNilStr:self.thirdComponentRowTitle]];
    return self.defaultTitle;
}

//  获取非空字符
- (NSString *)getNotNilStr:(NSString *)content
{
    if (content == nil) {
        return @"";
    }
    return content;
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
