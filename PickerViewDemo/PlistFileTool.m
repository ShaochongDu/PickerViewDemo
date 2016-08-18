//
//  PlistFileTool.m
//  DingXiangApp
//
//  Created by Shaochong Du on 16/2/29.
//  Copyright © 2016年 X.T. All rights reserved.
//

#import "PlistFileTool.h"

@implementation PlistFileTool

/**
 *  加载plist配置文件
 *
 *  @param fileName 文件名称
 */
+ (NSMutableArray *)loadPlistFileName:(NSString *)fileName
{
    NSMutableArray *resultArray = [NSMutableArray array];
    NSString *str = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@",fileName]];
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:str];
    for (NSDictionary *sectionDic in plistArray) {
        BOOL sectionIsUse = [sectionDic[kIsUse] boolValue];
        //  判断整个分组是否可用
        if (sectionIsUse) {
            NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
            [headerDic setObject:sectionDic[kHeaderDes] forKey:kHeaderDes];
            [headerDic setObject:sectionDic[kFooterDes] forKey:kFooterDes];
            
            NSArray *dataArray = sectionDic[kDataArray];
            NSMutableArray *inArray = [NSMutableArray array];
            for (NSDictionary *settingDic in dataArray) {
                BOOL isUse = [settingDic[kIsUse] boolValue];
                //  判断子分组是否可用
                if (isUse) {
                    [inArray addObject:settingDic];
                }
            }
            [headerDic setObject:inArray forKey:kDataArray];
            [resultArray addObject:headerDic];
        }
    }
    return resultArray;
}

/**
 *  根据设置plist配置文件的数据，获取当前indexpath对应的标题文字
 *
 *  @param indexPath 当前indexpath
 *
 *  @return 标题
 */
+ (NSString *)fromPlistGetCellLeftTitle:(NSIndexPath *)indexPath plistArray:(NSMutableArray *)plistArray
{
    NSDictionary *sectionDic = plistArray[indexPath.section];
    NSArray *sectionDataArray = sectionDic[kDataArray];
    NSDictionary *dataDic = sectionDataArray[indexPath.row];
    return dataDic[kModuleName];
}

/**
 *  根据设置plist配置文件的数据，获取当前indexpath对应的字典数据
 *
 *  @param indexPath  当前indexpath
 *  @param plistArray plist文件数据
 *
 *  @return 当前条目配置
 */
+ (NSDictionary *)fromPlistGetCellDic:(NSIndexPath *)indexPath plistArray:(NSMutableArray *)plistArray
{
    NSDictionary *sectionDic = plistArray[indexPath.section];
    NSArray *sectionDataArray = sectionDic[kDataArray];
    return sectionDataArray[indexPath.row];
}

/**
 *  获取配置文件中 字段是否必填
 *
 *  @param isRequre   是否必填
 *  @param placeHoder 占位符
 *
 *  @return 占位文本
 */
+ (NSString *)getPlaceTitleIsRequired:(BOOL)isRequired placeHolder:(NSString *)placeHoder
{
    if (isRequired) {
        return [NSString stringWithFormat:@"*%@",placeHoder];
    }
    return placeHoder;
}

@end
