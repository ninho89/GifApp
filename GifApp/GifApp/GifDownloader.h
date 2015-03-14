//
//  GifDownloader.h
//  GifApp
//
//  Created by Filippo Aresu on 14/3/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GifDownloader : NSObject

+(void)gifWithURL:(NSString*)url completionBlock:(void(^)(UIImage *image)) completionBlock;

@end
