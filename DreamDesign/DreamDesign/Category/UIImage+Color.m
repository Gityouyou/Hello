//
//  UIImage+Color.m
//  Dream
//
//  Created by 李晓丹 on 16/6/6.
//  Copyright © 2016年 李晓丹. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage*) imageWithColor:(UIColor*)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




- (UIImage *)scaleToSize:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


//裁剪图片
+ (UIImage *)cutImage:(UIImage *)image withUIImageView:(UIImageView *)currentImgView{
    NSData *data= UIImageJPEGRepresentation(image, 1.0);
//    if (data.length > 100*1024) {
//        if (data.length>1024*1024) {//1M以及以上
//            data=UIImageJPEGRepresentation(image, 0.1);
//        }else if (data.length>512*1024) {//0.5M-1M
//            data=UIImageJPEGRepresentation(image, 0.5);
//        }else if (data.length>200*1024) {//0.25M-0.5M
//            data=UIImageJPEGRepresentation(image, 0.9);
//        }
//    }
    if (data.length > 1024 * 1024) {
        data = UIImageJPEGRepresentation(image, 0.1);
    }
    image = [UIImage imageWithData:data];
    
    CGSize newSize;
    CGImageRef imageRef = nil;
    // 调整图片方向
    if (image.imageOrientation != UIImageOrientationUp) {
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        [image drawInRect:(CGRect){0, 0, image.size}];
        UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        image = normalizedImage;
        UIGraphicsEndImageContext();
    }
    
    if ((image.size.width / image.size.height) < (currentImgView.frame.size.width / currentImgView.frame.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * currentImgView.frame.size.height / currentImgView.frame.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * currentImgView.frame.size.width / currentImgView.frame.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    // 需要手动释放
    CGImageRelease(imageRef);
    return newImage;
}

- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height {
    CGSize size = CGSizeMake(width, height);
    if (&UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    } else {
        //        UIGraphicsBeginImageContext(size);
    }
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)imagewithImage:(UIImage *)image
{
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat redius = ((width <= height) ? width : height)/2;
    CGRect  rect = CGRectMake(width/2-redius, height/2-redius, redius*2, redius*2);
    
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newImage.size.width, newImage.size.height), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(newImage.size.width/2, newImage.size.height/2) radius:redius startAngle:0 endAngle:M_PI*2 clockwise:0];
    [path addClip];
    [newImage drawAtPoint:CGPointZero];
    UIImage *imageCut = UIGraphicsGetImageFromCurrentImageContext();
    
    CGImageRelease(sourceImageRef);
    CGImageRelease(newImageRef);
    return imageCut;
    
}

@end
