//
//  YCMainListTabCell.h
//  逼真仿写苏宁易购分类界面
//
//  Created by 刘胤辰 on 16/8/6.
//  Copyright © 2016年 it.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCMainModel.h"

@interface YCMainListTabCell : UITableViewCell

@property(nonatomic,assign)BOOL isAppear;

//创建一个属性使在点击或是左滑的时候再添加LineView
@property(nonatomic,assign)BOOL isClickToApperaLineView;

@property(nonatomic,assign)BOOL isHiddenLineViewAndArrowView;

//记录左滑
@property(nonatomic,assign)BOOL isLeftSlide;

@property(nonatomic,strong)YCMainModel *model;


@end
