//
//  UITableViewCell+Addition.m
//  NdGameCenter
//
//  Created by Lin Benjie on 10-12-01.
//  Copyright 2010 NetDragon WebSoft Inc.. All rights reserved.
//

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#import "UITableViewCell+Addition.h"
#import <objc/runtime.h>

@implementation UITableViewCell (Addition)

+ (id)loadCellOfType: (Class)tp fromNib: (NSString*)nibName withId: (NSString*)reuseId {
	NSArray* objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
	for (id object in objects) {
		if ([object isKindOfClass:tp]) {
			UITableViewCell *cell = object;
			[cell setValue:reuseId forKey:@"_reuseIdentifier"];
			return cell;
		}
	}
	
	[NSException raise:@"WrongNibFormat" format:@"Nib for '%@' must contain one TableViewCell, and its class must be '%@'", nibName, tp];
	
	return nil;
}

+ (NSString*)cellID { return [self description]; }

+ (NSString*)nibName { return [self description]; }

+ (id)dequeOrCreateInTable:(UITableView*)tableView ofType: (Class)tp fromNib: (NSString*)nibName withId: (NSString*)reuseId {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
	return cell ? cell : [self loadCellOfType:tp fromNib:nibName withId:reuseId];
}

+ (id)dequeInTable:(UITableView*)tableView {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:[self cellID]];
    return cell;
}

+ (id)dequeOrCreateInTable:(UITableView*)tableView {
	return [self dequeOrCreateInTable:tableView ofType:self fromNib:[self nibName] withId:[self cellID]];
}

+ (id)dequeOrCreateInTable:(UITableView*)tableView selectedBackgroundViewColor:(UIColor *)color {
    UITableViewCell *cell = [self dequeInTable:tableView];
    if (cell == nil) {
        cell = [self loadCellOfType:self fromNib:[self nibName] withId:[self cellID]];
        [cell setSelectedBackgroundViewColor:color];
    }
    return cell;
}

+ (id)loadFromNib {
    UITableViewCell *cell = [self loadCellOfType:self fromNib:[self nibName] withId:[self cellID]];
    [cell setSelectedBackgroundViewColor:RGBCOLOR(204, 229, 246)];
	return cell;
}

+ (id)loadFromNibWithSuperNib:(NSString *)superNib {
    UITableViewCell *superView = (UITableViewCell *)[[[NSBundle mainBundle] loadNibNamed:superNib owner:self options:nil] lastObject];
    UITableViewCell *cell = [self loadFromNib];
    [cell.contentView insertSubview:superView.contentView atIndex:0];
    superView.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    Class superClass = NSClassFromString(superNib);
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(superClass, &outCount);
    for ( int i = 0 ; i < outCount ; i++ ) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if (propertyName) {
            id value = [superView valueForKey:propertyName];
            [cell setValue:value forKey:propertyName];
        }
    }
    return cell;
}

+ (id)loadFromNibWithReuseFlag: (BOOL)toBeReused{
	if(toBeReused)
		return [self loadCellOfType:self fromNib:[self nibName] withId:[self cellID]];
	else
		return [self loadCellOfType:self fromNib:[self nibName] withId:@""];		
}

+ (id)dequeOrCreateInTable:(UITableView*)tableView withId: (NSString*)reuseId andStyle:(UITableViewCellStyle)style {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:style reuseIdentifier:reuseId];
	}
	return cell;
}

- (void)setSelectedBackgroundViewColor:(UIColor *)color {
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = color;
}

@end
