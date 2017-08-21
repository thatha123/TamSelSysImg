//
//  TamSelSysImg.h
//  TamSelSysImgDemo
//
//  Created by xin chen on 2017/8/21.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ImgBlock)(UIImage *img);

@interface TamSelSysImg : NSObject

+(TamSelSysImg *)shareInstance;

/**
 *  选择系统相册
 *
 *  @param sender       控制器
 *  @param isShowCamera 是否显示相机
 *  @param isShowEdit   是否要编辑
 *  @param imgBlock     图片数据
 */
+(void)selImage:(UIViewController *)sender isShowCamera:(BOOL)isShowCamera isShowEdit:(BOOL)isShowEdit imgBlock:(ImgBlock)imgBlock;

@end
