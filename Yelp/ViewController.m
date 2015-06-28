//
//  ViewController.m
//  Yelp
//
//  Created by Curtis Kang on 6/25/15.
//  Copyright (c) 2015 Curtis Kang. All rights reserved.
//

#import "ViewController.h"
#import "FilterViewController.h"
#import "YelpClient.h"
#import "RestCell.h"
#import <UIImageView+AFNetworking.h>

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface ViewController () <FilterViewControllerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) YelpClient *client;
@property (strong, nonatomic) NSArray *imageUrls;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic) NSDictionary *dictionary;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (strong, nonatomic) NSMutableDictionary *dictData;
@property (strong, nonatomic) NSMutableString *category;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.category  = [@"food" mutableCopy];
    self.tableView.dataSource =self;
    self.tableView.delegate  = self;
    self.searchBar.delegate = self;
    [self callYelpAPI:self.category];
  

 NSLog(@"DEBUG");

}
//- (void)viewDidAppear:(BOOL)animated {
//    [self callYelpAPI:@"Thai"];
//
//}

- (void)viewWillAppear:(BOOL)animated
{
    [self callYelpAPI:self.category];
}

-(void) callYelpAPI:(NSString *)category
{
    // Do any additional setup after loading the view, typically from a nib.
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
       [self.client searchWithTerm:category success:^(AFHTTPRequestOperation *operation, id response) {
        self.dictionary = response[@"businesses"];
 
        
        [self.dictData setObject:[ self.dictionary valueForKeyPath:@"image_url"] forKey:@"image_url"];
        NSLog(@"%@",[ self.dictData valueForKeyPath:@"image_url"]);
           
        NSArray * responseArr = response[@"businesses"];
        
        self.movies =responseArr;
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyRestCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.titleLabel.text = movie[@"name"];
    cell.addrLabel.text = @"N/A";
    if ( [[movie valueForKeyPath:@"location.address"] count] > 0)
    {
        cell.addrLabel.text = [movie valueForKeyPath:@"location.address"][0];
    }
    NSMutableString *category = [[NSMutableString alloc] init];
    NSString *category2= [[NSString alloc] init];
 category =[NSMutableString stringWithFormat:@"%@",movie[@"categories"][0][0]];
    if ( [ movie[@"categories"] count ] > 1 )
    {
       
        category2 = [NSMutableString stringWithFormat:@"%@",movie[@"categories"][1][0]];
      
        [ category appendString:@" & "];

        [ category appendString:category2];
     ;
    }

    cell.noteLabel.text = category;
   
    cell.reviewCount.text = [NSString stringWithFormat:@"%@",movie[@"review_count"]];
    NSLog(@"%@",movie[@"review_count"]);

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


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *nav = segue.destinationViewController;
    FilterViewController *filterVc = (FilterViewController *)nav.topViewController;
    //FilterViewController *filterVc = (FilterViewController *)segue.destinationViewController;
    filterVc.delegate = self;
    
    
}

-(void)filterViewController:(FilterViewController *)viewController didUpdateFilters:(NSDictionary *) filters
{
    NSLog(@"test %@",filters.allValues);
    self.category = filters[@"filter1"];
    [self callYelpAPI:self.category];
    //[self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@", self.searchBar.text);
  //   [self.tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
     NSLog(@"DEBUG search");
    
    self.category = [self.searchBar.text mutableCopy];
    [self callYelpAPI:self.category];
    //[self.tableView reloadData];
    [ searchBar resignFirstResponder];
}
@end
