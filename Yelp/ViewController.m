//
//  ViewController.m
//  Yelp
//
//  Created by Curtis Kang on 6/25/15.
//  Copyright (c) 2015 Curtis Kang. All rights reserved.
//

#import "ViewController.h"
#import "YelpClient.h"
#import "RestCell.h"
#import <UIImageView+AFNetworking.h>

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) YelpClient *client;
@property (strong, nonatomic) NSArray *imageUrls;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSMutableArray *testArray;
@property (strong, nonatomic) NSDictionary *dictionary;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (strong, nonatomic) NSMutableDictionary *dictData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource =self;
    self.tableView.delegate  = self;
    

    //NSLog(@"response: %@", res);
    /*
    NSString *apiUrlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=7ue5rxaj9xn4mhbmsuexug54&limit=20&country=us";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiUrlString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError != NULL) {
            self.navigationItem.title = @"⚠ Network Error";
        }
        else {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = dict[@"movies"];
            [self.tableView reloadData];
        };
    }];
        // 4) Present picker in main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self presentViewController:_picker animated:YES completion:nil];
           });
*/
    
    // Do any additional setup after loading the view, typically from a nib.
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    //NSString *res;
    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
        // NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
       // NSDictionary *dict = (NSDictionary*)response;
        self.dictionary = response[@"businesses"];
         NSLog(@"START");
        //testArray = self.dictionary[@"total"];
       // NSLog(@"%@",  [ self.dictionary valueForKeyPath:@"image_url"]);
       
        [self.dictData setObject:[ self.dictionary valueForKeyPath:@"image_url"] forKey:@"image_url"];
        NSLog(@"%@",[ self.dictData valueForKeyPath:@"image_url"]);
         NSLog(@"END");
        NSMutableArray * referanceArray1=[[NSMutableArray alloc]init];
        NSMutableArray * referanceArray2=[[NSMutableArray alloc]init];
        NSMutableArray * referanceArray3=[[NSMutableArray alloc]init];
        NSMutableArray * referanceArray4=[[NSMutableArray alloc]init];
        NSMutableArray * referanceArray5=[[NSMutableArray alloc]init];

        NSMutableArray * referanceArray=[[NSMutableArray alloc]init];
        
        NSArray * responseArr = response[@"businesses"];
        
        for(NSDictionary * dict in responseArr)
        {
            
            [self.testArray  addObject:[dict valueForKey:@"name"]];
            [referanceArray1 addObject:[dict valueForKey:@"image_url"]];
            [referanceArray2 addObject:[dict valueForKey:@"rating_img_url"]];
            [referanceArray3 addObject:[dict valueForKeyPath:@"location.address"]];
            [referanceArray4 addObject:[dict valueForKey:@"snippet_text"]];
            [referanceArray5 addObject:[dict valueForKey:@"distance"]];
        }
        self.movies =responseArr;
       // NSLog(@"%@",referanceArray);      // Here you get the Period data
       // NSLog(@"%@",referanceArray1);   // Here you get the Referance data
      //  NSLog(@"%@",referanceArray2);      // Here you get the Period data
       // NSLog(@"%@",referanceArray3);   // Here you get the Referance data
       // NSLog(@"%@",referanceArray4);      // Here you get the Period data
       // NSLog(@"%@",referanceArray5);      // Here you get the Period data
      //  self.tableView
      [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
   // NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.dictionary options:0 error:nil];        //NSLog(@"%@", businessDictionaries);
    //NSDictionary *dict;
    
    //    NSDictionary *dict;
  //  for(int i=0; i<[array count];i++)
  //////  {
   //     dict= [array objectAtIndex:i];
  //      NSLog(@"Statuses: %@", [dict objectForKey:@"businesses"]);
  //  }
    
    // [ businessDictionaries ]
    //        for (NSString *string in businessDictionaries) {
    //            NSLog(@"%@", string);
    //        }
    /*
     for (NSString *key in businessDictionaries ) {
     id object = [businessDictionaries objectForKey:key];
     NSLog(@"The object for key \"%@\" is: %@", key, object);
     }*/
    
    // self.movies = businessDictionaries[@"snippet_image_url"];
  


 NSLog(@"DEBUG");

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyRestCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.titleLabel.text = movie[@"name"];
    cell.addrLabel.text = [movie valueForKeyPath:@"location.address"][0];
    NSMutableString *category = [[NSMutableString alloc] init];
    NSString *category2= [[NSString alloc] init];
 category =[NSMutableString stringWithFormat:@"%@",movie[@"categories"][0][0]];
    if ( [ movie[@"categories"] count ] > 1 )
    {
       
        category2 = [NSMutableString stringWithFormat:@"%@",movie[@"categories"][1][0]];
        NSLog(@"test %@", category2);
        [ category appendString:@" & "];

        [ category appendString:category2];
       // [ category appendString:movie[@"categories"][1][0]];
    }
    NSLog(@"TTTTTT");
    cell.noteLabel.text = category;
    NSLog(@"XXXXXX");
    cell.reviewCount.text = [NSString stringWithFormat:@"%d",(int)movie[@"review_count"]];
    float d =  [[movie valueForKey:@"distance"] floatValue]/1000;
   
    NSMutableString *a =[NSMutableString stringWithFormat:@"%1.2f", d];
   
    [a appendString:@"m"];
    cell.distanceLabel.text =a;
    NSString *posterURLString = movie[@"image_url"];
    NSString *ratingURLString = movie[@"rating_img_url_small"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:posterURLString]];
    [cell.ratingView setImageWithURL:[NSURL URLWithString:ratingURLString]];

    NSLog(@"DEBUG!");
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
