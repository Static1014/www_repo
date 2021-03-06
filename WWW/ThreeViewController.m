//
//  ThreeViewController.m
//  WWW
//
//  Created by XiongJian on 14-6-16.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "ThreeViewController.h"
#import "FiveViewController.h"
#import "BusinessUtil.h"
#import "MyCell.h"
#import "SixViewController.h"

@interface ThreeViewController () {
    UIProgressView *progress;
}

@end

@implementation ThreeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setNavigationBar];

    [self initSearchBar];

    [self initCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [BusinessUtil hideTabbarByChangeFrame:NO withTabBarView:self.tabBarController.view];
}

- (void)setNavigationBar {
    self.navigationController.navigationBar.translucent = NO;

    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 158, 44)];
    bgView.backgroundColor = [UIColor clearColor];

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(4, 2, 150, 20)];
    title.text = @"Navigation Test";
    title.textColor = [UIColor redColor];
    title.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:title];
    [title release];

    progress = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progress.progress = 0.3;
    progress.frame = CGRectMake(4, 30, 150, 12);

    [bgView addSubview:progress];
    [progress release];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];

    self.navigationItem.titleView = bgView;
    [bgView release];

    UIButton *left1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [left1 setImage:[UIImage imageNamed:@"tab_s1.png"] forState:UIControlStateNormal];
    [left1 setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateHighlighted];
    [left1 setFrame:CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *l1 = [[UIBarButtonItem alloc]initWithCustomView:left1];

    UIBarButtonItem *l2 = [[UIBarButtonItem alloc]initWithTitle:@"L2" style:UIBarButtonItemStylePlain target:self action:@selector(clickL2:)];

    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:l1,l2, nil];
    [l1 release];
    [l2 release];

    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [right1 setImage:[UIImage imageNamed:@"tab_s1.png"] forState:UIControlStateNormal];
    [right1 setImage:[UIImage imageNamed:@"tab_1.png"] forState:UIControlStateHighlighted];
    [right1 setFrame:CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *r1 = [[UIBarButtonItem alloc]initWithCustomView:right1];

    UIBarButtonItem *r2 = [[UIBarButtonItem alloc]initWithTitle:@"R2" style:UIBarButtonItemStylePlain target:self action:@selector(clickR2:)];

    NSArray *rightItems = [NSArray arrayWithObjects:r1,r2, nil];
    self.navigationItem.rightBarButtonItems = rightItems;
    [r2 release];
    [r1 release];
}

- (void)changeProgress {
    progress.progress += 0.02;
    if (progress.progress >= 1) {
        progress.progress = 0;
    }
}

- (void)clickR2:(UIBarButtonItem*)btn {
    FiveViewController *four = [[FiveViewController alloc]initWithNibName:@"FiveViewController" bundle:nil];
    four.title = @"Five Page";
    [self.navigationController pushViewController:four animated:YES];
    [four release];
}

- (void)clickL2:(UIBarButtonItem*)btn {
    SixViewController *six = [[SixViewController alloc]initWithNibName:@"SixViewController" bundle:nil];
    six.title = @"Six Page";
    [self.navigationController pushViewController:six animated:YES];
    [six release];
}

#pragma mark - SearchBar
- (void)initSearchBar {
    _searchBar.delegate = self;

    [_btnCancel setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    _btnCancel.enabled = NO;

    CGRect frame = [[UIScreen mainScreen]bounds];
    UIControl *con = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [con addTarget:self action:@selector(clickOthersCancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:con];
    [self.view sendSubviewToBack:con];
}

- (void)clickOthersCancelSearch {
    [self hideCancelBtn:YES];
}

- (void)hideCancelBtn:(BOOL)hidden {
    if (hidden) {
        [_searchBar resignFirstResponder];
    }
    CGFloat length = 0;
    if (hidden && _searchBar.frame.size.width == 260) {
        length = 60;
    } else if (!hidden && _searchBar.frame.size.width == 320) {
        length = -60;
    }
    if (length != 0) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _searchBar.frame;
            frame.size.width += length;
            _searchBar.frame = frame;
            frame = _btnCancel.frame;
            frame.origin.x += length;
            _btnCancel.frame = frame;
        }];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    _btnCancel.enabled = YES;
    [self hideCancelBtn:NO];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![@"" isEqualToString:searchText]) {
        _btnCancel.enabled = YES;
        [self search:searchText];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self search:_searchBar.text];
    [self hideCancelBtn:YES];
}

- (IBAction)clickCancelBtn:(id)sender {
    [self hideCancelBtn:YES];
}

- (void)search:(NSString*)text {
    NSLog(@"--------search clcik------%@",text);
}
#pragma mark - CollectionView
- (void)initCollectionView {
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    [_collectionView registerClass:[MyCell class] forCellWithReuseIdentifier:@"MyCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"MyCell";

    MyCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];

    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];

    cell.bg.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    [cell.image setImage:[UIImage imageNamed:@"item.png"]];
    [cell.lable setText:[NSString stringWithFormat:@"%d - %d",[indexPath section],[indexPath row]]];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell * cell = (MyCell *)[collectionView cellForItemAtIndexPath:indexPath];
    // 取消选中
    if (cell.bg.backgroundColor == [UIColor orangeColor]) {
        cell.bg.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    } else {
        cell.bg.backgroundColor = [UIColor orangeColor];
    }
}

// 单选，不重写该方法则多选
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCell * cell = (MyCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.bg.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_searchBar release];
    [_collectionView release];
    [_btnCancel release];
    [super dealloc];
}
@end
