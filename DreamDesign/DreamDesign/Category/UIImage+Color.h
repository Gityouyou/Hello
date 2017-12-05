//
//  UIImage+Color.h
//  Dream
//
//  Created by 李晓丹 on 16/6/6.
//  Copyright © 2016年 李晓丹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *  根据颜色返回图片（把颜色转换为图片）
 */
+ (UIImage*) imageWithColor:(UIColor*)color;



/**
 *  缩放图片
 */
- (UIImage *)scaleToSize:(CGSize)size;


/**
  *截取图片,按范围截取
 */
+ (UIImage *)cutImage:(UIImage*)image withUIImageView:(UIImageView *)currentImgView;


/**
 *  压缩图片
 */
- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height;


/**
 *  截取图片
 */
+ (UIImage *)imagewithImage:(UIImage *)image;



@end
