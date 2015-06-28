//
//  FilterViewController.h
//  Yelp
//
//  Created by Curtis Kang on 6/28/15.
//  Copyright (c) 2015 Curtis Kang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilterViewController;

@protocol FilterViewControllerDelegate <NSObject>

-(void)filterViewController:(FilterViewController *)viewController didUpdateFilters:(NSDictionary *) filters;

@end
@interface FilterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *catSwitch2;

@property (weak, nonatomic) IBOutlet UISwitch *catSwitch3;
@property (weak, nonatomic) NSMutableDictionary *switchDict;
@property (weak, nonatomic) id<FilterViewControllerDelegate> delegate;
@end
