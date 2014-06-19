//
//  OneViewController.h
//  WWW
//
//  Created by XiongJian on 2014/05/28.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoViewController.h"

//@protocol showOneMsgDelegate
//@optional
//- (void)showOneMsg:(BOOL)hidden withNum:(int)num;
//@end

@interface OneViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) id<showOneMsgDelegate> delegate;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@end
