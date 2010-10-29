//
//  Possession.m
//  RandomPossessions
//
//  Created by bhardy on 7/29/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "Possession.h"


@implementation Possession

@synthesize possessionName, serialNumber, valueInDollars, dateCreated, imageKey;

- (void)setThumbnailDataFromImage:(UIImage *)image
{
	[thumbnail release];
	[thumbnailData release];
	
	CGRect imageRect = CGRectMake(0, 0, 70, 70);
	UIGraphicsBeginImageContext(imageRect.size);
	[image drawInRect:imageRect];
	
	thumbnail = UIGraphicsGetImageFromCurrentImageContext();
	
	[thumbnail retain];
	
	UIGraphicsEndImageContext();
	
	thumbnailData = UIImageJPEGRepresentation(thumbnail, 0.5);
	[thumbnailData retain];
}

- (UIImage *)thumbnail
{
	if (!thumbnailData) {
		return nil;
	}
	
	if (!thumbnail) {
		thumbnail = [[UIImage imageWithData:thumbnailData] retain];
	}
	
	return thumbnail;
}

+ (id)randomPossession 
{
	NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffy",
														  @"Rusty",
														  @"Shiny", nil];
	NSArray *randomNounList = [NSArray arrayWithObjects:@"Bear",
														@"Spork",
														@"Mac", nil];
	
	int adjectiveIndex = random() % [randomAdjectiveList count];
	int nounIndex = random() % [randomNounList count];
	NSString *randomName = [NSString stringWithFormat:@"%@ %@",
								[randomAdjectiveList objectAtIndex:adjectiveIndex],
								[randomNounList objectAtIndex:nounIndex]];
	int randomValue = random() % 100;
	NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", 
																	'0' + random() % 10,
																	'A' + random() % 26,
																	'0' + random() % 10,
																	'A' + random() % 26,
																	'0' + random() % 10];
	Possession *newPossession = [[self alloc] initWithPossessionName:randomName
															valueInDollars:randomValue
															  serialNumber:randomSerialNumber];
	return [newPossession autorelease];
}

- (id)initWithPossessionName:(NSString *)name 
							valueInDollars:(int)value
								serialNumber:(NSString *)sNumber
{
	// Call the superclass's designated initializer 
	self = [super init];
	
	// Did the superclass's initialization fail? 
	if (!self)
		return nil;
	
	// Give the instance variables initial values 
	[self setPossessionName:name]; 
	[self setSerialNumber:sNumber]; 
	[self setValueInDollars:value];
	dateCreated = [[NSDate alloc] init];
	
	// Return the address of the newly initialized object
	return self;
}

- (id)initWithPossessionName:(NSString *)name {
	return [self initWithPossessionName:name 
						 valueInDollars:0
						   serialNumber:@""];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ (%@): Worth $%d, Recorded on %@",
								possessionName, serialNumber, valueInDollars, dateCreated];
}

#pragma mark -
#pragma mark NSCoding protocal methods

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:possessionName forKey:@"possessionName"];
	[aCoder encodeObject:serialNumber forKey:@"serialNumber"];
	[aCoder encodeInt:valueInDollars forKey:@"valueInDollars"];
	[aCoder encodeObject:dateCreated forKey:@"dateCreated"];
	[aCoder encodeObject:imageKey forKey:@"imageKey"];
	[aCoder encodeObject:thumbnailData forKey:@"thumbnailData"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	[super init];
	
	[self setPossessionName:[aDecoder decodeObjectForKey:@"possessionName"]];
	[self setSerialNumber:[aDecoder decodeObjectForKey:@"serialNumber"]];
	[self setValueInDollars:[aDecoder decodeIntForKey:@"valueInDollars"]];
	[self setImageKey:[aDecoder decodeObjectForKey:@"imageKey"]];
	dateCreated = [[aDecoder decodeObjectForKey:@"dateCreated"] retain];
	
	thumbnailData = [[aDecoder decodeObjectForKey:@"thumbnailData"] retain];
	
	return self;
}


#pragma mark -
#pragma mark Cleanup methods

- (void)dealloc {
	[thumbnail release];
	[thumbnailData release];
	[imageKey release];
	[possessionName release]; 
	[serialNumber release];
	[dateCreated release];
	[super dealloc];
}

@end
