//
//  YCMainListTabCell.m
//  逼真仿写苏宁易购分类界面
//
//  Created by 刘胤辰 on 16/8/6.
//  Copyright © 2016年 it.com. All rights reserved.
//

#import "YCMainListTabCell.h"

@interface YCMainListTabCell()

@property(nonatomic,strong)UIImageView *arrowImage;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UILabel *labelDetail;


@end

@implementation YCMainListTabCell

-(UILabel *)label{
    
    if (_label==nil) {
        
        _label=[[UILabel alloc]init];
    }
    
    _label.font=[UIFont systemFontOfSize:23];
    
    _label.frame=CGRectMake(LeftMargin, 10, 200, 40);
    
    return _label;
}

-(UILabel *)labelDetail{
    
    if (_labelDetail==nil) {
        
        _labelDetail=[[UILabel alloc]init];
    }
    
    _labelDetail.font=[UIFont systemFontOfSize:15];
    
    _labelDetail.textColor=[UIColor lightGrayColor];
    
    _labelDetail.frame=CGRectMake(LeftMargin, 35, 200, 40);
    
    return _labelDetail;
}

-(void)setModel:(YCMainModel *)model{
    
    _model=model;
    
    self.headImage.image=[UIImage imageNamed:model.mainName];
    
    self.label.text=model.text;
    self.labelDetail.text=model.text;
}

//右滑的时候隐藏箭头和LineView
-(void)setIsHiddenLineViewAndArrowView:(BOOL)isHiddenLineViewAndArrowView{
    
    _isHiddenLineViewAndArrowView=isHiddenLineViewAndArrowView;
    
    if (_isHiddenLineViewAndArrowView) {
        
        self.arrowImage.hidden=YES;
        self.lineView.hidden=YES;
        
    }
}

-(UIImageView *)headImage{
    
    if (_headImage==nil) {
        
        _headImage=[[UIImageView alloc]init];
                
        _headImage.frame=CGRectMake(20, (MainListCellHeight-70)/2, 70, 70);
    }
    
    return _headImage;
}

-(void)setIsLeftSlide:(BOOL)isLeftSlide{
    
    _isLeftSlide=isLeftSlide;
    
    if (_isLeftSlide) {
        
        self.arrowImage.hidden=NO;
        self.lineView.hidden=NO;
        
    }
}

//程序刚启动的时候隐藏LineView
-(void)setIsClickToApperaLineView:(BOOL)isClickToApperaLineView{
    
    _isClickToApperaLineView=isClickToApperaLineView;
    
    self.lineView.hidden=YES;
    self.arrowImage.hidden=YES;
}

//点击的当前cell的时候让其它cell的箭头消失，实现箭头的上下走动的效果
-(void)setIsAppear:(BOOL)isAppear{
    
    _isAppear=isAppear;
    
    if (!isAppear) {
        
        self.arrowImage.hidden=YES;
        self.lineView.hidden=NO;
    }else{
        self.arrowImage.hidden=NO;
        self.lineView.hidden=YES;
    }
}

-(UIImageView *)arrowImage{
    
    if (_arrowImage==nil) {
        
        _arrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AllCata_LeftArrow"]];
//        _arrowImage.hidden = YES;
    }
    
    return _arrowImage;
}

-(UIView *)lineView{
    
    if (_lineView==nil) {
        
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=themeColor;
        _lineView.hidden=YES;
    }
    
    return _lineView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //添加
    [self addSubview:self.arrowImage];
    [self addSubview:self.lineView];
    [self addSubview:self.headImage];
    [self addSubview:self.label];
    [self addSubview:self.labelDetail];

    //设置约束
    [self setContranst];
    [self setLineContranst];
    
    
    
    
    
    return self;
}

-(void)setLineContranst{
    
    self.lineView.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.arrowImage attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:1];
    
    [self addConstraint:centerX];
    [self addConstraint:centerY];
    [self addConstraint:height];
    [self addConstraint:width];
}

-(void)setContranst{
    
    self.arrowImage.translatesAutoresizingMaskIntoConstraints=NO;
    self.lineView.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.arrowImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.arrowImage attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:LeftMargin-12];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.arrowImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.arrowImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0 constant:12];
    
    [self addConstraint:centerX];
    [self addConstraint:centerY];
    [self addConstraint:height];
    [self addConstraint:width];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
