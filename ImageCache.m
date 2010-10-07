//
//  ImageCache.m
//  Homepwner
//
//  Created by Chris Readle (GMC-MSV-IT CONTRACTOR) on 10/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageCache.h"

static ImageCache *sharedImageCache;


@implementation ImageCache

- (id)init
{
	[super init];
	dictionary = [[NSMutableDictionary alloc] init];
	return self;
}

#pragma mark Accessing the casche

- (void)setImage:(UIImage *)i forKey:(NSString *)s
{
	[dictionary setObject:i forKey:s];
}

- (UIImage *)imageForKey:(NSString *)s
{
	return [dictionary objectForKey:s];
}

- (void)deleteImageForKey:(NSString *)s
{
	[dictionary removeObjectForKey:s];
}

#pragma mark Singleton stuff

+ (ImageCache *)sharedImageCache
{
	if (!sharedImageCache) {
		sharedImageCache = [[ImageCache alloc] init];
	}
	return sharedImageCache;
}

+ (id)allocWithZone:(NSZone *)zone
{
	if (!sharedImageCache) {
		sharedImageCache = [super allocWithZone:zone];
		return sharedImageCache;
	}else {
		return nil;
	}
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

- (void)release
{
	//no op
}

@end
