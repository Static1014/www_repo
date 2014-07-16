//
//  TwoViewController.h
//  WWW
//
//  Created by XiongJian on 2014/05/30.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol showOneMsgDelegate
@optional
- (void)showOneMsg:(BOOL)hidden withNum:(int)num;
@end

@interface TwoViewController : UIViewController <UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate>

@property (retain, nonatomic) id<showOneMsgDelegate> delegate;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UITextView *textView;
@property (retain, nonatomic) IBOutlet UIButton *btnAdd;
@property (retain, nonatomic) IBOutlet UIButton *btnSend;
@property (retain, nonatomic) IBOutlet UIView *bottomView;

@property (retain, nonatomic) NSString *headerText;

- (IBAction)clickSend:(id)sender;
- (IBAction)clickAdd:(id)sender;
- (IBAction)inputExit:(id)sender;
@end
