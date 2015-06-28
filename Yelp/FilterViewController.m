//
//  FilterViewController.m
//  Yelp
//
//  Created by Curtis Kang on 6/28/15.
//  Copyright (c) 2015 Curtis Kang. All rights reserved.
//

#import "FilterViewController.h"


@interface FilterViewController ()

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
- (IBAction)changeSwitch:(id)sender {
    NSString *cat1 , *cat2 , *cat3;
   if (self.mySwitch.on)
   {
       cat1 = @"& Chinese";
   }
    else
    {
        cat1 = @"";
    }
  
    if (self.catSwitch2.on)
    {
        cat2 = @"& French";
    }
    else
    {
        cat2 = @"";
    }
    if (self.catSwitch3.on)
    {
        cat3 = @"& American";
    }
    else
    {
        cat3 = @"";
    }
    NSString *categoryFilter = [[ NSString alloc] initWithFormat:@"%@%@%@",cat1,cat2,cat3];
    
    NSDictionary *resultDict = [[NSDictionary alloc] initWithObjectsAndKeys:categoryFilter,@"filter1",
                                
                                                   nil];

    NSLog(@"%@", resultDict);
    [self.delegate filterViewController:self didUpdateFilters:resultDict];
}


- (IBAction)onSave:(id)sender {
        [ self dismissViewControllerAnimated:YES completion:nil];
}

@end
