//
//  DetailGifViewController.m
//  GifApp
//
//  Created by Filippo Aresu on 14/3/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import "DetailGifViewController.h"
#import "UIImageView+WebCache.h"
#import "GifEntity.h"

@interface DetailGifViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageGif;

@end

@implementation DetailGifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(saveGifCoreData:)];
    
    [self.imageGif sd_setImageWithURL:[NSURL URLWithString:self.gif.gifURL] placeholderImage:[UIImage imageNamed:@"first"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Buttons Method

- (void)saveGifCoreData:(id)sender {
    
    GifEntity *gif = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([GifEntity class]) inManagedObjectContext:self.managedObjectContext];
    
    gif.urlGif = self.gif.gifURL;
    
    NSError *error;
    [self.managedObjectContext save:&error];
    
    if(!error){
        NSLog(@"no error");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GIF"
                                                        message:@"Añadido a favoritos"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        NSLog(@"error");
    }
    
}


@end
