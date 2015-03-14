//
//  GifEntity.h
//  GifApp
//
//  Created by Filippo Aresu on 14/3/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GifEntity : NSManagedObject

@property (nonatomic, retain) NSString * urlGif;

@end
