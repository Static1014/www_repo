//
//  TwoViewController.h
//  WWW
//
//  Created by XiongJian on 2014/05/30.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UITextField *editView;
@property (retain, nonatomic) IBOutlet UIButton *btnAdd;
@property (retain, nonatomic) IBOutlet UIButton *btnSend;

@property (retain, nonatomic) NSString *headerText;

- (IBAction)clickSend:(id)sender;
- (IBAction)clickAdd:(id)sender;
- (IBAction)inputExit:(id)sender;
- (IBAction)inputBegin:(id)sender;
- (IBAction)inputEnd:(id)sender;
- (IBAction)inputChange:(id)sender;
@end
