//
//  DXIntervalSelectViewController.h
//  DXDesign
//
//  Created by caxa on 15/12/6.
//  Copyright © 2015年 mlf. All rights reserved.
//
/**
 *  pickerview选择器  最多支持三列
 *
 */
#import <UIKit/UIKit.h>

//  数值类型
typedef NS_ENUM(NSInteger, ValueType)
{
    ValueTypeFloat,     //    字符型
    ValueTypeString       //    字符串类型
};

/**
 *  完成回调
 *
 *  @param currentIndex  当前选择的行索引
 */
typedef void(^DSCPickerMutiDoneBlock)(NSInteger firstIndex,NSInteger secondIndex,NSInteger thirdIndex,NSString *valueStr);
typedef void(^DSCPickerMutiCancelBlock)();


@interface DSCPickerViewMuti : UIViewController

@property (nonatomic, strong) NSMutableArray *dataSourceArray;  //  数据源
@property (nonatomic, assign) ValueType valueType;
@property (nonatomic, assign) BOOL showTitle;   //  是否显示已选选项
@property (nonatomic, copy) NSString *defaultTitle; //  标题值
//  以下两个属性 只有showTitle=YES时 起作用
@property (nonatomic, copy)NSString *leftTitle; //  左侧名称
@property (nonatomic, copy)NSString *unitStr;   //  单位,如cm
@property (nonatomic, assign)CGFloat componentWith; //  宽度

@property (nonatomic, copy)DSCPickerMutiDoneBlock pickerMutiBlock;
@property (nonatomic, copy)DSCPickerMutiCancelBlock cancelMutiBlock;
@property (nonatomic, assign)NSInteger secondComponentRowIndex;     //  第二列选中的行
@property (nonatomic, assign)NSInteger thirdComponentRowIndex;     //  第三列选中的行


@property (weak, nonatomic) IBOutlet UIButton *middleBarBtn;
@property (nonatomic, assign)NSInteger firstComponentRowIndex;     //  第一列选中的行


- (void)showInView:(UIView *)view done:(DSCPickerMutiDoneBlock)block cancelBlock:(DSCPickerMutiCancelBlock)cancelBlock;

/**
 *  设置默认滚动pickerview 若无则传999
 *
 *  @param firstComponent  第一列
 *  @param secondComponent 第二列
 *  @param thirdComponent  第三列
 */
- (void)scrollFirstComponentRow:(NSInteger)firstComponentRow secondComponentRow:(NSInteger)secondComponentRow thirdComponentRow:(NSInteger)thirdComponentRow;

@end
