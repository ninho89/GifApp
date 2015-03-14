//
//  SearchViewController.m
//  GifApp
//
//  Created by Filippo Aresu on 14/3/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomGifTableViewCell.h"
#import "GiffyApiHelper.h"
#import "GifParser.h"
#import "Gif.h"
#import "DetailGifViewController.h"

NSString *const kCellSearch = @"CellID";

@interface SearchViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listGif;
@property (strong, nonatomic)  UISearchBar *searchGif;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.listGif = [[NSMutableArray array]mutableCopy];
    [self registerCustomCell];
    
    self.searchGif = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    [self.view addSubview:self.searchGif];
    self.searchGif.delegate = self;
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self downloadGiffy:self.searchGif.text];
    [self.searchGif resignFirstResponder];
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) registerCustomCell{
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil]forCellReuseIdentifier:kCellSearch];
}

-(void)downloadGiffy:(NSString *)endPoint{
    GiffyApiHelper *gh = [[GiffyApiHelper alloc]init];
    [gh gifCompletionWithSearch:endPoint completionBlock:^(NSData *resultData) {
        GifParser *parser = [[GifParser alloc]init];
        self.listGif = [parser gifData:resultData];
        [self.tableView reloadData];
    }];
}

#pragma mark - TableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listGif.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomGifTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellSearch forIndexPath:indexPath];
    Gif *gif = self.listGif[indexPath.row];
    
//    [cell.imageGifCustom sd_setImageWithURL:[NSURL URLWithString:giffy.giffyURL]  placeholderImage:[UIImage imageNamed:@"first"]];
//    
    
    return cell;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailGifViewController *detailGifViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"detailGifViewController"];
    
    detailGifViewController.giffy = self.listGif[indexPath.row];
    detailGifViewController.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:detailGifViewController animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

@end
