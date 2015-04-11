//
//  GLSReadingList.m
//  Glasses
//
//  Created by Scott Jackson on 11/04/13.
//  Copyright (c) 2013 Scott Jackson. All rights reserved.
//

#import "GLSReadingList.h"

@implementation GLSReadingList

static GLSReadingList *sharedReadingList;

+ (GLSReadingList *)sharedReadingList {
	if (!sharedReadingList) {
		sharedReadingList = [[GLSReadingList alloc] init];
	}
	return sharedReadingList;
}

- (NSArray *)unreadItems {
	/*
	 Yes, this is *full* of magic strings. Deal with it.
	 (More accurately: deal with it, *me*, when it breaks
	 with a new OS X release.)
	 */
	NSString *plistPath = [@"~/Library/Safari/Bookmarks.plist" stringByExpandingTildeInPath];
	NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:plistPath];
	NSArray *readingList = nil;
	for (NSDictionary *bookmarkList in plistData[@"Children"]) {
		if ([bookmarkList[@"Title"] isEqualToString:@"com.apple.ReadingList"]) {
			readingList = bookmarkList[@"Children"];
			break;
		}
	}
	
	if (!readingList) {
		NSLog(@"error finding reading list on disk");
		return nil;
	}
	
	NSMutableArray *unreadItems = [@[] mutableCopy];
	for (NSDictionary *bookmark in readingList) {
		if ([[bookmark[@"ReadingList"] allKeys] indexOfObject:@"DateLastViewed"] == NSNotFound) {
			GLSReadingListItem *unreadItem = [[GLSReadingListItem alloc] init];
			unreadItem.title = bookmark[@"URIDictionary"][@"title"];
			unreadItem.URL = [NSURL URLWithString:bookmark[@"URLString"]];
			unreadItem.UUID = bookmark[@"WebBookmarkUUID"];
			[unreadItems addObject:unreadItem];
		}
	}
	return [NSArray arrayWithArray:unreadItems];
}


- (BOOL)addItem:(GLSReadingListItem *)item {
	NSString *source = [NSString stringWithFormat:@"tell application \"Safari\" to add reading list item \"%@\"", [item.URL absoluteString]];
	NSAppleScript *script = [[NSAppleScript alloc] initWithSource:source];
	NSDictionary *error;
	[script executeAndReturnError:&error];
	if (error) {
		NSLog(@"error: %@", error);
		return NO;
	} else {
		return YES;
	}
}

@end
