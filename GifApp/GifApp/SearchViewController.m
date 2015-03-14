//
//  SearchViewController.m
//  GifApp
//
//  Created by Filippo Aresu on 14/3/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import "SearchViewController.h"
#import "GifApiHelper.h"
#import "GifParser.h"
#import "Gif.h"
#import "CustomGifTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "DetailGifViewController.h"

NSString *const kCellSearch = @"CellID";

@interface SearchViewController () <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listGif;
@property (strong, nonatomic)  UISearchBar *searchGif;
@end

@implementation SearchViewController

#pragma mark - View Life Cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.listGif = [[NSMutableArray array]mutableCopy];
    
    [self registerCustomCell];
    
    self.searchGif = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    [self.view addSubview:self.searchGif];
    self.searchGif.delegate = self;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils Methods

-(void)downloadGiffy:(NSString *)endPoint{
    GifApiHelper *gh = [[GifApiHelper alloc]init];
    [gh gifCompletionWithSearch:endPoint completionBlock:^(NSData *resultData) {
        GifParser *parser = [[GifParser alloc]init];
        self.listGif = [parser gifData:resultData];
        [self.tableView reloadData];
    }];
}

-(void) registerCustomCell{
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomGifTableViewCell" bundle:nil]forCellReuseIdentifier:kCellSearch];
}

#pragma mark - UISearchBar Methods

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self downloadGiffy:self.searchGif.text];
    [self.searchGif resignFirstResponder];
    [self.tableView reloadData];
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
    
    [cell.imageGifCustom sd_setImageWithURL:[NSURL URLWithString:gif.gifURL]  placeholderImage:[UIImage imageNamed:@"first"]];
    
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailGifViewController *detailGifViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"detailGifViewController"];
    
    detailGifViewController.gif = self.listGif[indexPath.row];
    detailGifViewController.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:detailGifViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}


@end
