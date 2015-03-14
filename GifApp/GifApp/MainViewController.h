//
//  ViewController.h
//  GifApp
//
//  Created by Filippo Aresu on 14/3/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

