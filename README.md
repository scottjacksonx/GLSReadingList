#GLSReadingList

GLSReadingList is an Objective-C API to the user's Reading List on OS X. It adds Reading List items by running an AppleScript, and gets the user's unread Reading List items by reading the plist Safari stores them in on disk. **As a result, you can't get the user's unread Reading List items if your app is sandboxed.** (All right, _maybe_ you technically could if you got the user to allow your app access to `~/Library/Safari/Bookmarks.plist`. But don't do that.)

##Usage

GLSReadingList is totes simp to use.

GLSReadingList *list = [GLSReadingList sharedReadingList];

	// create a Reading List item and add it to the user's Reading List
	GLSReadingListItem *item = [[GLSReadingListItem alloc] init];
	item.url = [NSURL URLWithString:@"http://apple.com"];
	[list addItem:item];

	// get the user's unread Reading List items
	NSArray *unreadItems = [[GLSReadingList sharedReadingList] unreadItems];
	for (GLSReadingListItem *item in unreadItems) {
		NSLog(@"item URL = %@", item.URL);
	}