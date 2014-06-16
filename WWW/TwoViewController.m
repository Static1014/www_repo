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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    keyBoardIsOpen = NO;
    isEng = YES;

    [self setNavigationBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasChanged:) name:UIKeyboardDidChangeFrameNotification object:nil];

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

    if ([infos count] > 0) {
        for (NSDictionary *info in infos) {
            [self sendMessage:NO text:[NSString stringWithFormat:@"%@",[info objectForKey:@"ATTRIBUTION"]] image:nil];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    if (_scrollView.contentSize.height  > _scrollView.frame.size.height) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, _scrollView.contentSize.height - _scrollView.bounds.size.height ) animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_scrollView release];
    [_btnAdd release];
    [_editView release];
    [_btnSend release];
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
    title.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = title;
    [title release];
}

- (void)clickLeftBack:(UIBarButtonItem*)sender {
    [_editView resignFirstResponder];
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
    [_editView resignFirstResponder];

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

//    NSDate *date = [NSDate date];

    [BusinessUtil saveImageToBox:[BusinessUtil scaleImageWithImageSimple:image scaledToSize:CGSizeMake(100,image.size.height*100/image.size.width)] WithName:[NSString stringWithFormat:@"www-%@.png",[NSDate date]]];

    [self dismissViewControllerAnimated:YES completion:nil];
    [picker release];
}

#pragma mark - Send Message
- (IBAction)clickSend:(id)sender {
    [_editView resignFirstResponder];

    [DBUtil insertUserInfo:_headerText :_editView.text :_editView.text :_editView.text];
    
    [self sendMessage:NO text:_editView.text image:nil];
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
    _editView.text = @"";
    _btnSend.enabled = NO;

    [cell setFrame:CGRectMake(cell.frame.origin.x, _scrollView.contentSize.height, cell.frame.size.width, cell.frame.size.height)];

    [_scrollView addSubview:cell];
    [cell release];

    if (_scrollView.contentSize.height + cell.frame.size.height > _scrollView.frame.size.height) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, _scrollView.contentSize.height - _scrollView.bounds.size.height +cell.frame.size.height) animated:YES];
    }
    CGSize size = _scrollView.contentSize;
    size.height += cell.frame.size.height;
    [_scrollView setContentSize:size];
}

- (IBAction)inputChange:(id)sender {
    if ([_editView.text isEqualToString:@""]) {
        _btnSend.enabled = NO;
    } else {
        _btnSend.enabled = YES;
    }
}

- (IBAction)inputExit:(id)sender {
    [_editView resignFirstResponder];
}

- (IBAction)inputEnd:(id)sender {
    [_editView resignFirstResponder];

    if (isEng) {
        [self moveView:216];
    } else {
        [self moveView:252];
    }
}

- (IBAction)inputBegin:(id)sender {
    [self moveView:-216];
}

- (void)moveView:(NSInteger)length
{
    if (length == -36) {
        isEng = NO;
    } else if (length == 36) {
        isEng = YES;
    } else if (length == 216) {
        isEng = YES;
        keyBoardIsOpen = NO;
    } else if (length == 252) {
        isEng = YES;
        keyBoardIsOpen = NO;
    } else if (length == -216) {
        isEng = YES;
        keyBoardIsOpen = YES;
    } else if (length == -252) {
        isEng = NO;
        keyBoardIsOpen = YES;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    CGRect frame = self.view.frame;
    frame.origin.y = frame.origin.y + length;
    [self.view setFrame:frame];
    [UIView commitAnimations];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_editView resignFirstResponder];
}

@end
