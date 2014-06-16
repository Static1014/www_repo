//
//  OneViewController.m
//  WWW
//
//  Created by XiongJian on 2014/05/28.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "OneViewController.h"
#import "OneCell.h"
#import "TwoViewController.h"

@interface OneViewController ()
{
    NSArray *sectionArr;
    NSArray *cellArr;

    NSMutableArray *openSections;
}
@end

@implementation OneViewController

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

    openSections = [[NSMutableArray alloc]init];

    sectionArr = [[NSArray alloc]initWithObjects:@"北京",@"上海",@"香港",@"天津", nil];
    NSArray *beijing = [[NSArray alloc]initWithObjects:@"北京1",@"北京2",@"北京3", nil];
    NSArray *shanghai = [[NSArray alloc]initWithObjects:@"上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1上海1",@"上海2上海2上海2上海2上海2上海2",@"上海3",@"上海4",@"上海5", nil];
    NSArray *xianggang = [[NSArray alloc]initWithObjects:@"香港1",@"香港2",@"香港3",@"香港4香港4香港4香港4香港4香港4香港4香港4香港4香港4",@"香港5@香港5@香港5@香港5",@"香港6", nil];
    NSArray *tianjin = [[NSArray alloc]initWithObjects:@"天津1",@"天津2", nil];
    cellArr = [[NSArray alloc]initWithObjects:beijing,shanghai,xianggang,tianjin, nil];
    [beijing release];
    [shanghai release];
    [xianggang release];
    [tianjin release];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - navigationBar
- (void)setNavigationBar {
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickLeftAdd:)];
    self.navigationItem.leftBarButtonItem = leftBtn;

    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(clickRightRefresh:)];
    self.navigationItem.rightBarButtonItem = rightBtn;

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 200, 44)];
    [title setText:@"View One"];
    [title setTextColor:[UIColor blueColor]];
    title.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = title;
    [title release];
}

- (void)clickLeftAdd:(UIBarButtonItem*)sender {

}

- (void)clickRightRefresh:(UIBarButtonItem*)sender {

}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [self tableView:_tableView viewForHeaderInSection:section];
    return sectionView.frame.size.height;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[[UIView alloc]init]autorelease];

    UIButton *btnSection = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 36)];
    btnSection.tag = section;
    btnSection.backgroundColor = [UIColor clearColor];
    [btnSection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnSection setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    [btnSection addTarget:self action:@selector(clickSection:) forControlEvents:UIControlEventTouchUpInside];
    [btnSection setBackgroundImage:[UIImage imageNamed:@"section_bg.png"] forState:UIControlStateNormal];
    [btnSection setBackgroundImage:[UIImage imageNamed:@"section_bg.png"] forState:UIControlStateHighlighted];
    [btnSection setTitle:[sectionArr objectAtIndex:section] forState:UIControlStateNormal];
    [btnSection setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 250)];

    UILabel *open = [[UILabel alloc]initWithFrame:CGRectMake(280, 0, 30, 30)];
    BOOL isOpen = NO;
    for (NSNumber *temp in openSections) {
        if (temp.integerValue == section) {
            isOpen = YES;
        }
    }
    if (isOpen) {
        open.text = @"-";
    } else {
        open.text = @"+";
    }
    open.font = [UIFont systemFontOfSize:24];
    open.contentMode = UIViewContentModeCenter;
    open.backgroundColor = [UIColor clearColor];

    sectionView.backgroundColor = [UIColor whiteColor];
    sectionView.frame = btnSection.frame;

    [sectionView addSubview:btnSection];
    [sectionView addSubview:open];
    [btnSection release];
    [open release];

    return sectionView;
}

- (void)clickSection:(id)sender
{
    UIButton *btn = (UIButton*)sender;

    BOOL isOpen = NO;
    for (NSNumber *temp in openSections) {
        if (temp.integerValue == btn.tag) {
            isOpen = YES;
            [openSections removeObject:temp];
            break;
        }
    }
    if (!isOpen) {
        [openSections addObject:[NSNumber numberWithInteger:btn.tag]];
    }

    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    BOOL isOpen = NO;
    for (NSNumber *temp in openSections) {
        if (temp.integerValue == section) {
            isOpen = YES;
        }
    }
    if (isOpen) {
        count = [[cellArr objectAtIndex:section] count];
    }

    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneCell *cell = (OneCell*)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"OneCell";

    OneCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[OneCell alloc] initWithReuseIdentifier:cellIdentifier]autorelease];
    }

    cell.indexPath = indexPath;
    [cell setCellImage:[UIImage imageNamed:@"item.png"]];
    [cell setCellText:[NSString stringWithFormat:@"%@",[[cellArr objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]]]];
//    [cell setCellBackgroundImage:[UIImage imageNamed:@"photo_list01_bg01.png"]];

    [cell.image addTarget:self action:@selector(clickImageAtIndexPath:) forControlEvents:UIControlEventTouchUpInside];
    [cell.image setTag:[indexPath section]*10000 + [indexPath row]];

    //cell长按事件
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
    recognizer.minimumPressDuration = 0.8f;
    [cell addGestureRecognizer:recognizer];

    return cell;
}

- (void)clickImageAtIndexPath:(UIButton*)sender {
    NSLog(@"image ----click---%d-----%d",sender.tag/10000,sender.tag%10000);
}

- (void)cellLongPress:(UIGestureRecognizer*)recognizer {
    if (recognizer.state != UIGestureRecognizerStateEnded) {
        OneCell *cell = (OneCell*)recognizer.view;
        NSLog(@"cell long click---%d-----%d",[cell.indexPath section],[cell.indexPath row]);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwoViewController *two = [[TwoViewController alloc]initWithNibName:@"TwoViewController" bundle:nil];
    two.headerText = [NSString stringWithFormat:@"%@",[[cellArr objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]]];
//    [self presentViewController:two animated:YES completion:nil];
    [self.navigationController pushViewController:two animated:YES];
    [two release];
}

#pragma mark - dealloc
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [sectionArr release];
    [cellArr release];
    [_tableView release];
    [super dealloc];
}
@end
