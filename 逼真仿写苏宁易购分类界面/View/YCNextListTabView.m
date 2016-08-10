//
//  YCNextListTabView.m
//  逼真仿写苏宁易购分类界面
//
//  Created by 刘胤辰 on 16/8/6.
//  Copyright © 2016年 it.com. All rights reserved.
//

#import "YCNextListTabView.h"
#import "YCNextListTabCell.h"
#import "YCMainModel.h"
#import "YCNextModel.h"

@interface YCNextListTabView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *dataList;

@end

@implementation YCNextListTabView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self=[super initWithFrame:frame style:style];
    
    self.delegate = self;
    self.dataSource = self;
    
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.rowHeight = NextListCellHeight;
    
    //注册通知观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getData:) name:@"sendData" object:nil];
    
    return self;
}

//获取从MainListTableView传过来的二维数组模型
-(void)getData:(NSNotification *)nof{
    
    YCMainModel *dataModel = nof.object;
    
    self.dataList=[NSArray array];
    //获取NextListTableView的数据源
    self.dataList=dataModel.next;
    
    //在点击MainListView的cell的时候实现NextListTableview的数据源变化，进行刷新
    [self reloadData];
    
    //刚启动默认选中第一行
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [self selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    //刚启动的时候将NextList的第一行数据传入TwoListTabView中
    [self sendDataToNextListTabView:index];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //此处因为没有素材图片，所以我就手动实现（第二级tableView的左边的那条白色细线）
    UIView *WhiteLineView = [[UIView alloc]init];
    WhiteLineView.backgroundColor = [UIColor whiteColor];
    WhiteLineView.frame=CGRectMake(0, 0, 1.5, [UIScreen mainScreen].bounds.size.height);
    
    [self addSubview:WhiteLineView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YCNextListTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Nextcell"];
    
    if (cell==nil) {
        
        cell=[[YCNextListTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Nextcell"];
    }
    
    YCNextModel *model = self.dataList[indexPath.row];
    
    cell.textLabel.text = model.nextName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击切换页面的时候将对应的NextListTabView数据传入TwoListTabView中
    [self sendDataToNextListTabView:indexPath];
}

#pragma mark - 此处可以改进，用如下方法进行改进，目前暂时先用通知的方法传递数据 -
//通过递归方法动态获取view的父控制器,可以用来进行性能的优化
//点击切换页面的时候将数据传入NextListTabView中
-(void)sendDataToNextListTabView:(NSIndexPath *)indexPath{
    
    YCNextModel *model = self.dataList[indexPath.row];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sendNextData" object:model];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
