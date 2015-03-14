//
//  GiffyApiHelper.m
//  GifApp
//
//  Created by Filippo Aresu on 14/3/15.
//  Copyright (c) 2015 Filippo Aresu. All rights reserved.
//

#import "GiffyApiHelper.h"

@implementation GiffyApiHelper

-(void)gifCompletionWithSearch:(NSString *) endPoint completionBlock:(void (^)(NSData *resultData)) completionBlock
{
    NSString *giffyURL = [NSString stringWithFormat:@"http://api.giphy.com/v1/gifs/search?q=%@&api_key=dc6zaTOxFJmzC", endPoint];
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:[NSURL URLWithString:giffyURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        //Esto es para probar que funciona y que devuelve un diccionario
        //NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        //NSLog(@"json %@", json);
        
        completionBlock(data);
        
    }]resume];
}

@end
