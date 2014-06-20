//
//  ThreeViewController.h
//  WWW
//
//  Created by XiongJian on 14-6-16.
//  Copyright (c) 2014年 tci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeViewController : UIViewController <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;
@property (retain, nonatomic) IBOutlet UICollectionView *collectionView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
- (IBAction)clickCancelBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *btnCancel;
@end
