//
//  CJImagePathFileModel.h
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJPathFileModel.h"
#import <UIKit/UIKit.h>

@interface CJImagePathFileModel : CJPathFileModel

/**
 *  从FileModel的absoluteURL路径中获取图片，并回调
 *
 *  @param completeBlock 获取到图片后的回调方法
 */
- (void)cj_getImageWithCompleteBlock:(void(^)(UIImage *image))completeBlock;


@end