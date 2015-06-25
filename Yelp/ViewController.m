//
//  ViewController.m
//  Yelp
//
//  Created by Curtis Kang on 6/25/15.
//  Copyright (c) 2015 Curtis Kang. All rights reserved.
//

#import "ViewController.h"
#import "YelpClient.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) YelpClient *client;
@property (strong, nonatomic) NSArray *imageUrls;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    //NSString *res;
    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
        //NSLog(@"response: %@", response);
        NSLog(@"DEBUG");
        NSDictionary *dict = (NSDictionary*)response;
        self.imageUrls = dict[@"image_url"];
       // self.tableView
        for (NSString *key in dict) {
            id object = [dict objectForKey:key];
            NSLog(@"The object for key \"%@\" is: %@", key, object);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    //NSLog(@"response: %@", res);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
