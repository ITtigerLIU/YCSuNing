//
//  YCMainListTabView.m
//  逼真仿写苏宁易购分类界面
//
//  Created by 刘胤辰 on 16/8/6.
//  Copyright © 2016年 it.com. All rights reserved.
//

#import "YCMainListTabView.h"
#import "YCMainListTabCell.h"
#import "YCMainModel.h"
#import "YCNextModel.h"
#import "YCTwoModel.h"
#import "YCMainCellModel.h"

@interface YCMainListTabView()<UITableViewDataSource,UITableViewDelegate>

//购物栏的箭头图标
@property(nonatomic,strong)UIImageView *arrowImage;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *mainCellModelArray;

@property(nonatomic,assign)BOOL isClickOrLeftSlide;

//记录左滑
@property(nonatomic,assign)BOOL isLeftSlide;

@end

@implementation YCMainListTabView

#pragma mark 用来监听cell点击之后复用的问题，判断是否点击
-(NSMutableArray *)mainCellModelArray{
    
    if (_mainCellModelArray==nil) {
        
        _mainCellModelArray=[NSMutableArray array];
        
                for (int i=0; i<self.dataArray.count; i++) {
        
                    YCMainCellModel *cell=[[YCMainCellModel alloc]init];
        
        
                    [_mainCellModelArray addObject:cell];
                }
    }
    
    return _mainCellModelArray;
}

#pragma mark 数据源
-(NSMutableArray *)dataArray{
    
    if (_dataArray==nil) {
        
        _dataArray=[NSMutableArray array];
        
        //进行plist文件的三维数组的字典转模型
        _dataArray = [self addPlistData];
    }
    
    return _dataArray;
}

#pragma mark - plist文件中的三维数组的读取以及字典转模型 -
-(NSMutableArray *)addPlistData{
    
    NSString *filePath=[[NSBundle mainBundle]pathForResource:@"threeDimensionalArray.plist" ofType:nil];
    NSArray *array =[NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *temModel = [NSMutableArray array];
    
    //三维数组进行字典转模型
    for (NSDictionary *dict in array) {
        YCMainModel *mainModel = [YCMainModel nameWithDict:dict];
        
        NSMutableArray *temMainModel = [NSMutableArray array];
        
        //对NextListTableView进行字典转模型
        for (NSDictionary *dict in mainModel.next) {
            
            YCNextModel *nextModel = [YCNextModel nameWithDict:dict];
            
            NSMutableArray *temNextModel = [NSMutableArray array];
            //对TwoListTableView进行字典转模型
            for (NSDictionary *dict in nextModel.two) {
                
                YCTwoModel *twoModel = [YCTwoModel nameWithDict:dict];
                //一维数组
                [temNextModel addObject:twoModel];
            }
            
            //给属性赋值
            nextModel.two=temNextModel;
            //二维数组
            [temMainModel addObject:nextModel];
        
        }
        
        //给属性赋值
        mainModel.next=temMainModel;
        //三维数组
        [temModel addObject:mainModel];
    }
    
    return temModel;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self=[super initWithFrame:frame style:style];
    
    self.delegate = self;
    self.dataSource = self;
    
    self.rowHeight = MainListCellHeight;
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change) name:@"change" object:nil];
    
    //创建手势
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self addGestureRecognizer:rightSwipe];
    
    return self;
}

/*
 思路：(用来实现nextListTablleView和TwoListTableView实现左右滑动的时候，MainListTableView上的箭头的显示与隐藏)
 当左滑或是点击的时候：设置self.isClickOrLeftSlide为yes，然后在停止滑动的时候发送通知，告知刷新
 当右滑的时候：设置self.isClickOrLeftSlide为no，然后在启动滑动的时候告知刷新
 */
-(void)change{
    
    [self reloadData];
}
//右滑手势实现方法
-(void)rightSwipe{
    
    if (self.rightClick) {
        
        self.rightClick();
        
        self.isClickOrLeftSlide=NO;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YCMainListTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if (cell==nil) {
        
        cell=[[YCMainListTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
    }
    //判断是否点击，防止购物栏的箭头图标的复用
    YCMainCellModel *cellModel = self.mainCellModelArray[indexPath.row];
    cell.isAppear=cellModel.isClick;
    //判断是否左滑了，是就显示箭头图标
    cell.isLeftSlide=self.isLeftSlide;
    
    //用来防止在程序一启动的时候箭头图标就显示
    if (!self.isClickOrLeftSlide) {
        
        cell.isClickToApperaLineView=YES;
    }
    
    //给label赋值
    YCMainModel *mainModel = self.dataArray[indexPath.row];
    cell.model =mainModel;
    
    NSLog(@"fsljflsdfsdfa");
    
    return cell;
}

#pragma mark - 此处可以改进，用如下方法进行改进，目前暂时先用通知的方法传递数据 -
//通过递归方法动态获取view的父控制器,可以用来进行性能的优化
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.isClickOrLeftSlide=YES;
    
    //当点击cell的时候，让nextListTablleView和TwoListTableView进行左滑
    if (self.leftClick) {
        
        self.leftClick();
    }
    
    //实现点击当前cell，其它cell的箭头图标均隐藏
    for (YCMainCellModel *model in self.mainCellModelArray) {
        
        model.isClick=NO;
    }
    YCMainCellModel *cellModel = self.mainCellModelArray[indexPath.row];
    cellModel.isClick=YES;
    
    //实现左滑动画结束的时候，箭头图标才开始显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //刷新当前行
        [tableView reloadData];
    });
    
    //获取数据，将数据进行传递
    YCMainModel *mainModel = self.dataArray[indexPath.row];

    //点击切换页面的时候将数据传入NextListTabView中
    [[NSNotificationCenter defaultCenter]postNotificationName:@"sendData" object:mainModel];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
