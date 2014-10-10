//
//  main.m
//  PmdStatus
//
//  Created by Thai Pangsakulyanont on 2014/10/04.
//  Copyright (c) 2014年 Thai Pangsakulyanont. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSStatusBar (NSStatusBar_Private)
- (id)_statusItemWithLength:(float)l withPriority:(int)p;
- (id)_insertStatusItem:(NSStatusItem *)i withPriority:(int)p;
@end

@interface MyApplicationDelegate : NSObject<NSApplicationDelegate>
{
	NSFileHandle *stdin;
	NSFileHandle *stdout;
	NSMenu *menu;
	NSMenuItem *voidItem;
	NSStatusItem *barItem;
}
- (void)applicationDidFinishLaunching:(NSNotification *)notification;
@end

@implementation MyApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	[self _initializeStdio];
	[self _createMenu];
	[self _createStatusBarItem];
}

- (void)_initializeStdio {
	stdin = [NSFileHandle fileHandleWithStandardInput];
	stdout = [NSFileHandle fileHandleWithStandardOutput];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_stdinDataAvailable) name:NSFileHandleDataAvailableNotification object:stdin];
	[stdin waitForDataInBackgroundAndNotify];
}

- (void)_createMenu {
	menu = [NSMenu new];
	voidItem = [menu addItemWithTitle:@"Void" action:@selector(_voidPomodoro:) keyEquivalent:@""];
	voidItem.target = self;
	voidItem.enabled = true;
}

- (void)_createStatusBarItem {
	NSStatusBar *bar = [NSStatusBar systemStatusBar];
	barItem = [[bar statusItemWithLength:0] retain];
	[bar removeStatusItem:barItem];
	[bar _insertStatusItem:barItem withPriority:INT_MAX-2];
	barItem.title = @"...";
	barItem.highlightMode = true;
	barItem.menu = menu;
	barItem.length = NSVariableStatusItemLength;
}

- (void)_stdinDataAvailable {
	NSData *data = [stdin availableData];
	if (data.length == 0) {
		exit(0);
		return;
	}
	NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	[self _setText:text];
	[stdin waitForDataInBackgroundAndNotify];
}

- (void)_setText:(NSString *)text {
	barItem.title = text;
}

- (void)_voidPomodoro:(id)sender {
	[stdout writeData:[@"!void\n" dataUsingEncoding:NSUTF8StringEncoding]];
	exit(1);
}

@end

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		id delegate = [MyApplicationDelegate new];
		NSApplication *app = [NSApplication sharedApplication];
		app.delegate = delegate;
		[app run];
	}
    return 0;
}
