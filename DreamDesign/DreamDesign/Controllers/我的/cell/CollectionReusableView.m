//
//  CollectionReusableView.m
//  DreamDesign
//
//  Created by Apple on 2017/10/10.
//  Copyright © 2017年 lxd. All rights reserved.
//

#import "CollectionReusableView.h"

@interface CollectionReusableView ()

@property (nonatomic, strong) UILabel *line;

@property (nonatomic, strong) UILabel *textLable;

@end

@implementation CollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        
        _line = [[UILabel alloc] init];
        [self addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(0);
            make.width.mas_equalTo(5);
        }];
        
        _textLable = [[UILabel alloc] init];
        _textLable.font = DEF_FontSize_16;
        _textLable.textColor = [UIColor darkGrayColor];
        [self addSubview:_textLable];
        [_textLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(0);
            make.left.mas_equalTo(20);
        }];
        
    }
    return self;
}

- (void)setLineColor:(UIColor *)lineColor {

    _line.backgroundColor = lineColor;
}

- (void)setHeaderText:(NSString *)headerText {
    _textLable.text = headerText;
}

@end
