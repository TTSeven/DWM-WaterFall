//
//  ViewController.m
//  TT瀑布流
//
//  Created by apple on 16/3/27.
//  Copyright © 2016年 xiaoM. All rights reserved.
//

#import "ViewController.h"
#import "TTShopCollectionViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "TTWaterFlowLayout.h"

@interface ViewController ()<UICollectionViewDataSource,TTWaterFlowLayoutDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *shopArr;

@end
static NSString *const identifier = @"shopCell";

@implementation ViewController

-(NSMutableArray *)shopArr{
    if (!_shopArr) {
        _shopArr = [NSMutableArray array];
    }return _shopArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
    [self setupRefresh];
    [self loadDataAndPrase];
    
    
}
#pragma mark setupRefresh
- (void)setupRefresh{
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer.hidden = YES;
}
- (void)loadNewShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *shops = [TTShop mj_objectArrayWithFilename:@"1.plist"];
        [self.shopArr removeAllObjects];
        [self.shopArr addObjectsFromArray:shops];
        
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    });
}
- (void)loadMoreShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray *shops = [TTShop mj_objectArrayWithFilename:@"1.plist"];
        
        [self.shopArr addObjectsFromArray:shops];
        
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    });
}

#pragma mark 处理数据
-(void)loadDataAndPrase{
    NSArray *arr = [TTShop mj_objectArrayWithFilename:@"1.plist"];
    [self.shopArr addObjectsFromArray:arr];
}
#pragma mark 初始化试图
-(void)setupCollectionView{
    
    TTWaterFlowLayout *layout = [TTWaterFlowLayout new];
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TTShopCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    
    self.collectionView = collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    self.collectionView.mj_footer.hidden = self.shopArr.count == 0;
    return self.shopArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TTShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.shop = self.shopArr[indexPath.row];
    return cell;
}


#pragma mark - TTWaterFlowLayoutDelegate

/**  根据宽度获取对应item的高度 */
- (CGFloat)waterFlowLayout:(TTWaterFlowLayout *)waterFlowLayout heightForItemAtIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth{
    
    TTShop *shop = self.shopArr[index];
    return shop.h*itemWidth / shop.w;
}


/** 列数 */
- (CGFloat)columnCountInWaterFlowLayout:(TTWaterFlowLayout *)waterFlowLayout{
    return 3;
}
/** 列间距 */
- (CGFloat)columnMarginInWaterFlowLayout:(TTWaterFlowLayout *)waterFlowLayout{
    return 10;
}
/** 行间距 */
- (CGFloat)rowMarginInWaterFlowLayout:(TTWaterFlowLayout *)waterFlowLayout{
    return 10;
}
/** 视图间距 */
- (UIEdgeInsets)edgeInsetsInWaterFlowLayout:(TTWaterFlowLayout *)waterFlowLayout{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
