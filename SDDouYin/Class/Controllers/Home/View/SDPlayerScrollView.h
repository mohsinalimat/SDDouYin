//
//  SDPlayerScrollView.h
//  SDDouYin
//
//  Created by slowdony on 2018/6/11.
//  Copyright © 2018年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KSYMediaPlayer/KSYMediaPlayer.h>
@class SDShortVideoModel;
@interface SDPlayerScrollView : UIScrollView
@property (nonatomic,strong)  KSYMoviePlayerController *topPlayer ,*middlePlayer ,*bottomPlayer;
/**
 更新数据

 @param videoDataArrs 数据源
 @param index idnex
 */
- (void)updateCurrentPlayerDatas:(NSMutableArray <SDShortVideoModel *>*)videoDataArrs currentIndex:(NSInteger )index;
@end
