//
//  YCtabBarVC.m
//  逼真仿写苏宁易购分类界面
//
//  Created by 刘胤辰 on 16/8/6.
//  Copyright © 2016年 it.com. All rights reserved.
//

#import "YCtabBarVC.h"
#import "YCCategoryVC.h"
#import "YCShoppingViewController.h"
#import "YCMineViewController.h"
#import "YCHomeViewController.h"
#import "YCSearchViewController.h"

@interface YCtabBarVC ()

@end

@implementation YCtabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = [UIColor whiteColor];
    
    [self addChildViewVC:[[YCHomeViewController alloc]init] andImageName:@"tabbar_home"title:@"首页"];
    
    [self addChildViewVC:[[YCSearchViewController alloc]init] andImageName:@"tabbar_message_center"title:@"搜索"];
    
    [self addChildViewVC:[[YCCategoryVC alloc]init] andImageName:@"tabbar_discover"title:@"分类"];
    
    [self addChildViewVC:[[YCShoppingViewController alloc]init] andImageName:@"tabbar_message_center"title:@"购物车"];
    
    [self addChildViewVC:[[YCMineViewController alloc]init] andImageName:@"tabbar_profile"title:@"我的易购"];
    
}

-(void)addChildViewVC:(UIViewController *)vc andImageName:(NSString *)imageName title:(NSString *)title{

    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    vc.view.backgroundColor=[UIColor whiteColor];
    //设置tabBar
    vc.tabBarItem.image=[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage=[[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.title=title;
    
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    
    //嵌套导航控制器
    
    [self addChildViewController:nav];
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
