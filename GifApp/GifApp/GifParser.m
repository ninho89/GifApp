//
//  GifParser.m
//  GifApp
//
//  Created by Filippo Aresu on 14/3/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import "GifParser.h"
#import "Gif.h"

@implementation GifParser

-(NSMutableArray *) gifData:(NSData *)gifData{
    
    NSError *error;
    NSDictionary *gifJson = [NSJSONSerialization JSONObjectWithData:gifData options:kNilOptions error:&error];
    if (error) {
        return nil;
    }
    NSMutableArray *gifArray = [[NSMutableArray alloc]init];
    NSArray *data = [gifJson valueForKey:@"data"];
    
    for (int i = 0; i < data.count; i++) {
        
        Gif *gif = [[Gif alloc]init];
        //NSString *gifUrl = [[[data[i] valueForKey:@"images"] valueForKey:@"downsized"]valueForKey:@"url"];
        NSString *gifUrl = [data[i] valueForKeyPath:@"images.downsized.url"];
        gif.gifURL = gifUrl;
        
        [gifArray addObject:gif];
    }
    
    return gifArray;
    
}

@end
