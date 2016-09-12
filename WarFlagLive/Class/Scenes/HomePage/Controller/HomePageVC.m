//
//  HomePageVC.m
//  WarFlagLive
//
//  Created by admin on 16/9/8.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "HomePageVC.h"


#define IDENTIFIER_CELL @"homeMenuCell"
#define IDENTIFIER_HEADER @"homeMenuHeader"
#define IDENTIFIER_HEADERSECTION @"homeMenuHeaderSection"

@interface HomePageVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

{
    UICollectionView *_collectionView;
    AdSuperModel *adSuperModel;
    HomeSuperListModel *homeSuperListModel;

}
@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavBar];
    [self addCollectionView];
    NSLog(@"kDeviceFactor = %f", kDeviceFactor);
    [self getNetData];
}

#pragma mark 设置导航条
- (void)setNavBar{
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationController.navigationBar.hidden = YES;
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = kColor_Main_Color;
    topView.frame=CGRectMake(0, 0, kScreenWidth, kMarginTopHeight);
    [self.view addSubview:topView];
    
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 60, 32)];
    leftImg.image = [UIImage imageNamed:@"nav_home_logo@2x.png"];
    leftImg.hidden=NO;
    [topView addSubview:leftImg];
    
    UIImageView *centerImg  = [[UIImageView alloc]initWithFrame:CGRectMake(80, 20+(44-26)/2, kScreenWidth-120, 26)];
    centerImg.image = [UIImage setNewImage:@"nav_home_search@2x.png"];
    centerImg.hidden=NO;
    [topView addSubview:centerImg];
    
    UIButton *saoBtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    [saoBtn setImage:[UIImage imageNamed:@"nav_home_sao@2x.png"] forState:UIControlStateNormal];
    saoBtn.frame = CGRectMake(kScreenWidth-40, 20, 44, 44);
    saoBtn.hidden=NO;
    [topView addSubview:saoBtn];
}


#pragma mark 布局视图
- (void)addCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kMarginTopHeight, kScreenWidth, kScreenHeight-kTabBarHeight-kMarginTopHeight) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.bounces = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    
    [_collectionView registerClass:[HomePageCell class] forCellWithReuseIdentifier:IDENTIFIER_CELL];
    [_collectionView registerClass:[HomePageHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADER];
    [_collectionView registerClass:[HomePageSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADERSECTION];
    [self.view addSubview:_collectionView];
    
}

#pragma mark - CollectionView Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return homeSuperListModel.data.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return ((HomeListModel *)[homeSuperListModel.data objectAtIndex:section] ).lists.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth/2-20, 135.0*kDeviceFactor);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 220.0*kDeviceFactor);
    } else {
        return CGSizeMake(kScreenWidth, 50.0*kDeviceFactor);
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            HomePageHeader *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADER forIndexPath:indexPath];
            if (adSuperModel) {
                monthHeader.viewController=self;
                [monthHeader  resetArray:adSuperModel.data];
            }
            if (homeSuperListModel) {
//                [monthHeader resetTitle: ((HomeListModel *)[homeSuperListModel.data objectAtIndex:indexPath.section])];
            }
            
            
            reusableview = monthHeader;
        } else {
            HomePageSectionHeaderView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:IDENTIFIER_HEADERSECTION forIndexPath:indexPath];
            
            if (homeSuperListModel) {
                [sectionView resetTitle: ((HomeListModel *)[homeSuperListModel.data objectAtIndex:indexPath.section])];
            }
            
            reusableview = sectionView;
        }
    }
    return reusableview;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomePageCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER_CELL
                                              forIndexPath:indexPath];
    [cell resetModel: [((HomeListModel *)[homeSuperListModel.data objectAtIndex:indexPath.section]).lists objectAtIndex:indexPath.row]]; 
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RoomDetailVC *roomdetailVC = [[RoomDetailVC alloc] initWithVideoId:((Lists *)[((HomeListModel *)[homeSuperListModel.data objectAtIndex:indexPath.section]).lists objectAtIndex:indexPath.row]).videoId];
    [self.navigationController pushViewController:roomdetailVC animated:YES];
}

- (void)getNetData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:AppURL_Banner parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"responsePbject === %@", responseObject);
        adSuperModel = [[AdSuperModel alloc] initWithDictionary:responseObject error:nil];
        if ([adSuperModel.code intValue] ==0) {
            [_collectionView reloadData];
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"error == %@", error);
    }];
    
    
    
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    manager1.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
    manager1.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager1 GET:AppURL_HomePage parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        homeSuperListModel = [[HomeSuperListModel alloc] initWithDictionary:responseObject error:nil];
        if ([homeSuperListModel.code intValue] ==0) {
            [_collectionView reloadData];
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"error == %@", error);
    }];
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
