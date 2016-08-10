//
//  YCMainModel.m
//  逼真仿写苏宁易购分类界面
//
//  Created by 刘胤辰 on 16/8/8.
//  Copyright © 2016年 it.com. All rights reserved.
//

#import "YCMainModel.h"

@implementation YCMainModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)nameWithDict:(NSDictionary *)dict{
    
    return [[self alloc]initWithDict:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
