//
//  GLSReadingListItem.m
//  Glasses
//
//  Created by Scott Jackson on 11/04/13.
//  Copyright (c) 2013 Scott Jackson. All rights reserved.
//

#import "GLSReadingListItem.h"

@implementation GLSReadingListItem

- (NSString *)description {
	NSString *originalDescription = [super description];
	return [NSString stringWithFormat:@"%@ (title: %@, url: %@)", originalDescription, self.title, self.URL];
}

@end
