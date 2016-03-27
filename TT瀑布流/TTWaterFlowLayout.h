//
//  TTWaterFlowLayout.h
//  TT瀑布流
//
//  Created by apple on 16/3/27.
//  Copyright © 2016年 xiaoM. All rights reserved.
//


#import <UIKit/UIKit.h>

@class TTWaterFlowLayout;

@protocol TTWaterFlowLayoutDelegate <NSObject>

@required

/**  根据宽度获取对应item的高度 */
- (CGFloat)waterFlowLayout:(TTWaterFlowLayout *)waterFlowLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth;

@optional
/** 列数 */
- (CGFloat)columnCountInWaterFlowLayout:(TTWaterFlowLayout *)waterFlowLayout;
/** 列间距 */
- (CGFloat)columnMarginInWaterFlowLayout:(TTWaterFlowLayout *)waterFlowLayout;
/** 行间距 */
- (CGFloat)rowMarginInWaterFlowLayout:(TTWaterFlowLayout *)waterFlowLayout;
/** 视图间距 */
- (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(TTWaterFlowLayout *)waterFlowLayout;

@end

@interface TTWaterFlowLayout : UICollectionViewLayout

/** 代理 */
@property(nonatomic,weak)id<TTWaterFlowLayoutDelegate>delegate;

@end
