//
//  GLSReadingList.h
//  Glasses
//
//  Created by Scott Jackson on 11/04/13.
//  Copyright (c) 2013 Scott Jackson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLSReadingListItem.h"

@interface GLSReadingList : NSObject

/*
 Returns the shared Reading List.
 */
+ (GLSReadingList *)sharedReadingList;

/*
 Returns an NSArray of GLSReadingListItem objects.
 The items are fetched from disk each time unreadItems
 is called.
 
 -unreadItems won't work when the app is sandboxed
 because it reads the bookmarks plist from disk, which
 is stored in ~/Library/Safari (i.e. outside the app's
 sandbox). As a result, you can't call -unreadItems if
 you want to put your app on the Mac App Store.
 */
- (NSArray *)unreadItems;

/*
 Uses AppleScript to add a GLSReadingListItem to the
 user's Reading List.
 
 Returns YES if the item was added successfully,
 NO otherwise.
 */
- (BOOL)addItem:(GLSReadingListItem *)item;

@end
