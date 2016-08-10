//
//  YCCategoryVC.m
//  逼真仿写苏宁易购分类界面
//
//  Created by 刘胤辰 on 16/8/6.
//  Copyright © 2016年 it.com. All rights reserved.
//

#import "YCCategoryVC.h"
#import "YCMainListTabView.h"
#import "YCNextListTabView.h"
#import "UIView+Extension.h"
#import "YCTwoListTabView.h"

@interface YCCategoryVC ()

@property (nonatomic,strong)YCMainListTabView * mainListView;
@property (nonatomic,strong)YCNextListTabView * nextListView;
@property (nonatomic,strong)YCTwoListTabView * twoListView;

@end

@implementation YCCategoryVC

//第三排的tableView
-(YCTwoListTabView *)twoListView{
    
    if (_twoListView==nil) {
        
        _twoListView = [[YCTwoListTabView alloc]init];
        
        _twoListView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width, 65, [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.height);
    }
    return _twoListView;
}

//第二排的tableView
-(YCNextListTabView *)nextListView{
    
    if (_nextListView==nil) {
        
        _nextListView=[[YCNextListTabView alloc]init];
        
        _nextListView.backgroundColor=[[UIColor alloc]initWithWhite:242.0/255.0 alpha:1.0];
        
        _nextListView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width, 65, [UIScreen mainScreen].bounds.size.width-[UIScreen mainScreen].bounds.size.width/3, [UIScreen mainScreen].bounds.size.height);
    }
    
    return _nextListView;
}

//第一排的tableView
-(YCMainListTabView *)mainListView{
    
    if (_mainListView==nil) {
        
        _mainListView=[[YCMainListTabView alloc]init];
        
    }
    
    return _mainListView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.view addSubview:self.nextListView];
    [self.navigationController.view addSubview:self.twoListView];
}

-(void)loadView{
    
    //放置mainListView
    self.view = self.mainListView;
    
    __weak typeof(self)weakself = self;
    
    //当右滑的时候进行回调
    self.mainListView.rightClick=^(){
        
   [[NSNotificationCenter defaultCenter]postNotificationName:@"change" object:nil];
            
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
                
                weakself.nextListView.x=[UIScreen mainScreen].bounds.size.width;
                weakself.twoListView.x=[UIScreen mainScreen].bounds.size.width;
            } completion:nil];
    };
    //当左滑的时候进行回调
    self.mainListView.leftClick=^(){
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
            
            weakself.nextListView.x=LeftMargin;
            weakself.twoListView.x=LeftMargin+NextMargin;
        } completion:^(BOOL finished) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"change" object:nil];
        }];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
