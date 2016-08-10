//
//  YCNextListTabView.m
//  逼真仿写苏宁易购分类界面
//
//  Created by 刘胤辰 on 16/8/6.
//  Copyright © 2016年 it.com. All rights reserved.
//

#import "YCTwoListTabView.h"
#import "YCTwoListTabCell.h"
#import "YCNextModel.h"
#import "YCTwoModel.h"

@interface YCTwoListTabView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *dataList;

@end

@implementation YCTwoListTabView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self=[super initWithFrame:frame style:style];
    
    self.delegate = self;
    self.dataSource = self;
        
    self.rowHeight = TwoListCellHeight;
    
    //隐藏cell的线
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //设置背景颜色
    self.backgroundColor=[[UIColor alloc]initWithWhite:217.0/255.0 alpha:1.0];
    
    //注册通知观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getData:) name:@"sendNextData" object:nil];
    
    return self;
}

//通知方法
-(void)getData:(NSNotification *)nof{
    
    YCNextModel *dataModel = nof.object;
    
    self.dataList=[NSArray array];
    //TwoListTabView的数据源
    self.dataList=dataModel.two;
    
    [self reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YCTwoListTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Nextcell"];
    
    if (cell==nil) {
        
        cell=[[YCTwoListTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Nextcell"];
    }
    
    YCTwoModel *model = self.dataList[indexPath.row];
    
    cell.textLabel.text = model.name;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    return cell;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
