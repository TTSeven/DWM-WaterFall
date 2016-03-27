//
//  TTShopCollectionViewCell.m
//  TT瀑布流
//
//  Created by apple on 16/3/27.
//  Copyright © 2016年 xiaoM. All rights reserved.
//

#import "TTShopCollectionViewCell.h"
#import <UIImageView+WebCache.h>


@interface TTShopCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation TTShopCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setShop:(TTShop *)shop{
    
    _shop = shop;
    
    self.priceLabel.text = shop.price;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageWithContentsOfFile:@"placeholder.png"]];
    
}
@end
