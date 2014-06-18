//
//  TwoViewController.m
//  WWW
//
//  Created by XiongJian on 2014/05/30.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import "TwoViewController.h"
#import "OneCell.h"
#import "DBCommon.h"
#import "DBUtil.h"
#import "BusinessUtil.h"

@interface TwoViewController ()
{
    BOOL keyBoardIsOpen;
    BOOL isEng;

    UIImagePickerController *imagePicker;
}

@end

@implementation TwoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //隐藏系统tabbar
//        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 输入法改变监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasChanged:) name:UIKeyboardDidChangeFrameNotification object:nil];

    keyBoardIsOpen = NO;
    isEng = YES;

    [self setNavigationBar];
    _textView.text = @"";
    [_textView.layer setCornerRadius:10];
    _textView.delegate = self;
    _btnSend.enabled = NO;
    [self initScrollView];

//    测试捕获异常
//    NSArray *test = [NSArray arrayWithObjects:@"111", nil];
//    NSLog(@"%@",[NSString stringWithFormat:@"%@",[test objectAtIndex:1]]);
}

- (void)initScrollView {
    NSMutableArray *condition = [[NSMutableArray alloc]init];
    [condition addObject:[NSString stringWithFormat:@" USER_NAME = '%@'",_headerText]];
    NSArray *infos = [[DBCommon shared]selectDB:@"USER_INFO" condition:condition];
    [condition release];

    if ([infos count] > 0 && [infos count] <= 10) {
        for (NSDictionary *info in infos) {
            [self sendMessage:NO text:[NSString stringWithFormat:@"%@",[info objectForKey:@"ATTRIBUTION"]] image:nil];
        }
    } else if ([infos count] > 10) {
        // 刚进页面时，只加载最新的10条信息
        for (int i = infos.count - 10; i < infos.count; i++) {
            NSDictionary *info = [infos objectAtIndex:i];
            [self sendMessage:NO text:[NSString stringWithFormat:@"%@",[info objectForKey:@"ATTRIBUTION"]] image:nil];
        }
    }
    [self scrollToBottom];

    //点击scrollview隐藏键盘
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(inputExit:)];
    recognizer.delegate = self;
    [_scrollView addGestureRecognizer:recognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [self hideTabbarByChangeFrame:YES];
    [self scrollToBottom];
}

- (void)scrollToBottom {
    if (_scrollView.contentSize.height  > _scrollView.frame.size.height) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, _scrollView.contentSize.height - _scrollView.bounds.size.height ) animated:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [self hideTabbarByChangeFrame:NO];
}

- (void)hideTabbarByChangeFrame:(BOOL)hidden {
    NSArray *views = self.tabBarController.view.subviews;
    [UIView animateWithDuration:0.25 animations:^{
        if (hidden) {
            UIView *view1 = [views objectAtIndex:0];
            CGRect frame = view1.frame;
            frame.size.height = [[UIScreen mainScreen]bounds].size.height;
            view1.frame = frame;

            UIView *view2 = [views objectAtIndex:1];
            frame = view2.frame;
            frame.origin.y = [[UIScreen mainScreen]bounds].size.height;
            view2.frame = frame;

            UIView *view3 = [views objectAtIndex:2];
            frame = view3.frame;
            frame.origin.y = [[UIScreen mainScreen]bounds].size.height;
            view3.frame = frame;
        } else {
            UIView *view1 = [views objectAtIndex:0];
            CGRect frame = view1.frame;
            frame.size.height = [[UIScreen mainScreen]bounds].size.height - 49;
            view1.frame = frame;

            UIView *view2 = [views objectAtIndex:1];
            frame = view2.frame;
            frame.origin.y = [[UIScreen mainScreen]bounds].size.height - 49;
            view2.frame = frame;

            UIView *view3 = [views objectAtIndex:2];
            frame = view3.frame;
            frame.origin.y = [[UIScreen mainScreen]bounds].size.height - 49;
            view3.frame = frame;
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_scrollView release];
    [_btnAdd release];
    [_btnSend release];
    [_bottomView release];
    [_textView release];
    [super dealloc];
}

#pragma mark - navigationBar
- (void)setNavigationBar {
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(clickLeftBack:)];
    self.navigationItem.leftBarButtonItem = leftBtn;

    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(clickRightDelete:)];
    self.navigationItem.rightBarButtonItem = rightBtn;

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 200, 44)];
    [title setText:_headerText];
    [title setTextColor:[UIColor blueColor]];
    title.backgroundColor = [UIColor clearColor];
    title.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = title;
    [title release];
}

- (void)clickLeftBack:(UIBarButtonItem*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightDelete:(UIBarButtonItem*)sender {
    if ([_scrollView.subviews count] > 0) {
        for (UIView *view in _scrollView.subviews) {
            [view removeFromSuperview];
        }
        CGSize size = _scrollView.contentSize;
        size.height = 0;
        [_scrollView setContentSize:size];
    }
}

#pragma mark - add photo
- (IBAction)clickAdd:(id)sender {
    [_textView resignFirstResponder];

    [self pickImageFromCamera:NO];
}

- (void)pickImageFromCamera:(BOOL)fromCamera {
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = fromCamera?UIImagePickerControllerSourceTypeCamera:UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;

    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, @"www");
//    }

    [self sendMessage:YES text:nil image:image];

    [BusinessUtil saveImageToBox:[BusinessUtil scaleImageWithImageSimple:image scaledToSize:CGSizeMake(100,image.size.height*100/image.size.width)] WithName:[NSString stringWithFormat:@"www-%@.png",[NSDate date]]];

    [self dismissViewControllerAnimated:YES completion:nil];
    [picker release];
}

#pragma mark - Send Message
- (IBAction)clickSend:(id)sender {
    [_textView resignFirstResponder];
    [DBUtil insertUserInfo:_headerText :_textView.text :_textView.text :_textView.text];
    [self sendMessage:NO text:_textView.text image:nil];
}

- (void)sendMessage:(BOOL)msgIsImage text:(NSString*)msg image:(UIImage*)image {
    OneCell *cell = [[OneCell alloc]initWithReuseIdentifier:@"OneCell"];
    [cell setCellImage:[UIImage imageNamed:@"item.png"]];
    if (msgIsImage) {
        [cell textIsImage:image];
        cell.lableBg.hidden = YES;
    } else {
        [cell setCellText:msg];
    }
    [cell setTextBackgroundImage:[UIImage imageNamed:@"section_bg.png"]];
    if ([_scrollView.subviews count]%2 == 1) {
        [cell turnToRight];
    }
    _textView.text = @"";
    _btnSend.enabled = NO;

    [cell setFrame:CGRectMake(cell.frame.origin.x, _scrollView.contentSize.height, cell.frame.size.width, cell.frame.size.height)];

    [_scrollView addSubview:cell];
    [cell release];

    CGSize size = _scrollView.contentSize;
    size.height += cell.frame.size.height;
    [_scrollView setContentSize:size];

    [self scrollToBottom];
}

#pragma mark - textview delegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self moveView:-216];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [_textView resignFirstResponder];
    if (isEng) {
        [self moveView:216];
    } else {
        [self moveView:252];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 0)];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([_textView.text isEqualToString:@""]) {
        _btnSend.enabled = NO;
    } else {
        _btnSend.enabled = YES;
    }
    [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 0)];
}

- (IBAction)inputExit:(id)sender {
    [_textView resignFirstResponder];
}

- (void)moveView:(NSInteger)length
{
    // 49为tabbar的高度
    int tabbarHeight = 49;
    if (self.tabBarController.tabBar.hidden) {
        tabbarHeight = 0;
    }

    if (length == -36) {
        isEng = NO;
    } else if (length == 36) {
        isEng = YES;
    } else if (length == 216) {
        isEng = YES;
        length -= tabbarHeight;
        keyBoardIsOpen = NO;
    } else if (length == 252) {
        isEng = YES;
        length -= tabbarHeight;
        keyBoardIsOpen = NO;
    } else if (length == -216) {
        isEng = YES;
        length += tabbarHeight;
        keyBoardIsOpen = YES;
    } else if (length == -252) {
        isEng = NO;
        length += tabbarHeight;
        keyBoardIsOpen = YES;
    }

    [UIView animateWithDuration:0.25 animations:^{
        CGRect scrollViewFrame = _scrollView.frame;
        scrollViewFrame.size.height += length;
        _scrollView.frame = scrollViewFrame;

        CGRect bottomViewFrame = _bottomView.frame;
        bottomViewFrame.origin.y += length;
        _bottomView.frame = bottomViewFrame;
    }];

    if (length < -200) {
        [self scrollToBottom];
    }
}

- (void)keyboardWasChanged:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGFloat afterHeight = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size.height;

    if (keyBoardIsOpen && !isEng && afterHeight == 216) {
        [self moveView:36];
    } else if (keyBoardIsOpen && isEng && afterHeight == 252) {
        [self moveView:-36];
    }
}

@end
