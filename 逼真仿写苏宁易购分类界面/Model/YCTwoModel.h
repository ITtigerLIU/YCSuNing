//
//  YCTwoModel.h
//  逼真仿写苏宁易购分类界面
//
//  Created by 刘胤辰 on 16/8/8.
//  Copyright © 2016年 it.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCTwoModel : NSObject

@property(nonatomic,copy)NSString * name;

+ (instancetype)nameWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
