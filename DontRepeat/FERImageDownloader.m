//
//  ImageDownloader.m
//  MarvelAPIDemo
//
//  Created by Fernando Garcia Corrochano on 07/07/14.
//  Copyright (c) 2014 Diego Freniche Brito. All rights reserved.
//

#import "FERImageDownloader.h"

@implementation FERImageDownloader

+ (void)downloadImageUsingDictionary:(NSDictionary *)dic completion:(void(^)(UIImage *image))completion {
	
	dispatch_async(BACKGROUND_QUEUE, ^{
		NSString *dataString = [dic objectForKey:@"Pic"];
		NSData *stringData = [[NSData alloc]initWithBase64EncodedString:dataString
																														options:NSDataBase64DecodingIgnoreUnknownCharacters];
		UIImage *img = [UIImage imageWithData:stringData];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			completion(img);
		});
	});
}

+ (void)downloadImageUsingUrl2:(NSString *)url completion:(void (^)(UIImage *))completion {
	NSURLSession *session = [NSURLSession sharedSession];
	
	NSURLSessionDataTask *task = [session
																dataTaskWithURL:[NSURL URLWithString:url]
																completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
																	
																	UIImage *img = [UIImage imageWithData:data];
																	
																	dispatch_async(dispatch_get_main_queue(), ^{
																		completion(img);
																	});
																	
																	
																}];
	
	[task resume];
	
}

@end
