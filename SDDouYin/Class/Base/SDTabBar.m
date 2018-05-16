
//
//  SDTabBar.m
//  SDInKe
//
//  Created by slowdony on 2018/1/24.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import "SDTabBar.h"
@interface SDTabBar()
/**
 背景
 */
@property (nonatomic,strong)  UIImageView *tabBarBJView;
@property (nonatomic,strong)  NSMutableArray *itemArr;

/**
 直播按钮
 */
@property (nonatomic,strong)  UIButton *cameraBtn;

/**
 最后选择的按钮
 */
@property (nonatomic,strong)  UIButton *lastSeletcBtn;
@end
@implementation SDTabBar

#pragma mark - lazy
///添加
- (UIButton *)cameraBtn{
    if (!_cameraBtn){
        //
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_cameraBtn setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_cameraBtn setTitle:@"添加" forState:UIControlStateNormal];
        [_cameraBtn  addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _cameraBtn.tag = TabBarTypeAdd;
    }
    return _cameraBtn;
}
-(NSMutableArray *)itemArr{
    if (!_itemArr){
        NSArray *arr = @[@"首页",@"关注",@"消息",@"我"];
        _itemArr = [NSMutableArray arrayWithArray:arr];
    }
    return _itemArr;
}
-(UIImageView *)tabBarBJView{
    if (!_tabBarBJView){
        _tabBarBJView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_bg"]];
    }
    return _tabBarBJView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tabBarBJView];
        [self setupUI];
    }
    return self;
}

- (void) setupUI{
    for (int i = 0; i < self.itemArr.count; i++) {
        //
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemBtn setImage:[UIImage imageNamed:self.itemArr[i]] forState:UIControlStateNormal];
        itemBtn.adjustsImageWhenHighlighted = NO  ;
//        [itemBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_p",self.itemArr[i]]] forState:UIControlStateSelected];
        [itemBtn setTitle:self.itemArr[i] forState:UIControlStateNormal];
        itemBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [itemBtn  addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn.tag = TabBarTypeHome+i;
        if (i==0){
            itemBtn.selected = YES;
            self.lastSeletcBtn = itemBtn;
        }
        [self addSubview: itemBtn];
    }
    [self addSubview:self.cameraBtn];
}

- (void)itemBtnClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(tabbar:withBtn:)]){
        [self.delegate tabbar:self withBtn:sender.tag];
    }
    if (sender.tag != TabBarTypeAdd) {
        self.lastSeletcBtn.selected = NO;
        sender.selected = YES;
        self.lastSeletcBtn = sender;
        
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                sender.transform = CGAffineTransformIdentity;
            }];
        }];
    }
   
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.tabBarBJView.frame = self.bounds;
    
    CGFloat btnX =0;
    CGFloat btnY =0;
    CGFloat btnW = self.bounds.size.width/(self.itemArr.count+1);
    CGFloat btnH = self.frame.size.height;
    
    for (int i = 0; i<[self subviews].count; i++) {
        UIView *btn = [self subviews][i];
        btnX = (btn.tag-TabBarTypeHome<2?(btn.tag-TabBarTypeHome):(btn.tag-TabBarTypeHome+1))*btnW;
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.frame = CGRectMake(btnX, btnY, btnW,btnH);
        }
    }
    [self.cameraBtn sizeToFit];
    self.cameraBtn.frame = CGRectMake(2*btnW, btnY, btnW,btnH);
}

@end