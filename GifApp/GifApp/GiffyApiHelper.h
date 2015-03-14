//
//  GiffyApiHelper.h
//  GifApp
//
//  Created by Filippo Aresu on 14/3/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiffyApiHelper : NSObject

-(void)gifCompletionWithSearch:(NSString *) endPoint completionBlock:(void (^)(NSData *resultData)) completionBlock;

@end
