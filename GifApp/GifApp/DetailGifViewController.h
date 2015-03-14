//
//  DetailGifViewController.h
//  GifApp
//
//  Created by Filippo Aresu on 14/3/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gif.h"

@interface DetailGifViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong) Gif *gif;

@end
