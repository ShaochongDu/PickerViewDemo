//
//  PlistFileTool.h
//  DingXiangApp
//
//  Created by Shaochong Du on 16/2/29.
//  Copyright © 2016年 X.T. All rights reserved.
//
/**
 *  plist文件操作类
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PlistFileTool : NSObject

/**
 *  加载plist配置文件
 *
 *  @param fileName 文件名称
 */
+ (NSMutableArray *)loadPlistFileName:(NSString *)fileName;

/**
 *  根据设置plist配置文件的数据，获取当前indexpath对应的标题文字
 *
 *  @param indexPath 当前indexpath
 *  @param plistArray plist文件数据
 *
 *  @return 标题
 */
+ (NSString *)fromPlistGetCellLeftTitle:(NSIndexPath *)indexPath plistArray:(NSMutableArray *)plistArray;

/**
 *  根据设置plist配置文件的数据，获取当前indexpath对应的字典数据
 *
 *  @param indexPath  当前indexpath
 *  @param plistArray plist文件数据
 *
 *  @return 当前条目配置
 */
+ (NSDictionary *)fromPlistGetCellDic:(NSIndexPath *)indexPath plistArray:(NSMutableArray *)plistArray;


@end
