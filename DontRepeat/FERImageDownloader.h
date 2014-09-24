//
//  ImageDownloader.h
//  MarvelAPIDemo
//
//  Created by Fernando Garcia Corrochano on 07/07/14.
//  Copyright (c) 2014 Diego Freniche Brito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FERImageDownloader : NSObject

+ (void)downloadImageUsingDictionary:(NSDictionary *)dic completion:(void(^)(UIImage *image))completion;

@end
