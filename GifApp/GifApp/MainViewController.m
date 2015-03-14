//
//  ViewController.m
//  GifApp
//
//  Created by Filippo Aresu on 14/3/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import "MainViewController.h"
#import "SearchViewController.h"
#import "GifEntity.h"
#import "CustomGifTableViewCell.h"
#import <UIImageView+WebCache.h>

NSString *const kCellMain = @"CellID";

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listGifCore;
@property (nonatomic, strong) NSArray *itemsGif;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self loadDataCoreData];
    [self registerCustomCell];
}

-(void) loadDataCoreData{
    //Creamos un objeto NSFetchRequest para realizar la consulta
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //Definimos que tabla queremos utilizar para la consulta
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([GifEntity class]) inManagedObjectContext:self.managedObjectContext];
    
    //Asignamos la descripción de la tabla al objeto NSFetchRequest que hemos creado
    [fetchRequest setEntity:entity];
    
    NSError *error;
    
    //Realizamos la consulta de los registros almacenandolos en un array
    self.itemsGif = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadDataCoreData];
    [self.tableView reloadData];
}

-(void) registerCustomCell{
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomGifTableViewCell" bundle:nil]forCellReuseIdentifier:kCellMain];
}

- (IBAction)searchGifButton:(id)sender {
    
    SearchViewController *searchViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"searchViewController"];
    searchViewController.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:searchViewController animated:YES];
    
}


#pragma mark - TableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemsGif.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomGifTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellMain forIndexPath:indexPath];
    
    GifEntity *gif = self.itemsGif[indexPath.row];
    [cell.imageGifCustom sd_setImageWithURL:[NSURL URLWithString:gif.urlGif] placeholderImage:[UIImage imageNamed:@"first"]];
    
    return cell;
}

/*
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
 return <#row height#>;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 300;
}

@end



