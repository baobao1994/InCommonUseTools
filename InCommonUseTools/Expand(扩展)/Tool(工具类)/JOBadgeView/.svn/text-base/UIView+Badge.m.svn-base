//
//  UIView+Badge.m
//  91Market
//
//  Created by Lin Benjie on 12-7-24.
//  Copyright (c) 2012 Bodong ND. All rights reserved.
//

#import "UIView+Badge.h"
#import "JOBadgeView.h"

static int MLT_BADGE_TAG = 6546;

@implementation UIView(Badged)

-(JOBadgeView *)badge {
  UIView *existingView = [self viewWithTag:MLT_BADGE_TAG];
  if(existingView) {
    if(![existingView isKindOfClass:[JOBadgeView class]]) {
      NSLog(@"Unexpected view of class found with badge tag.");
      return nil;
    } else {
      return (JOBadgeView *)existingView;
    }
  }
    
  JOBadgeView *badgeView = [[JOBadgeView alloc] init];
  badgeView.tag = MLT_BADGE_TAG;
  [self addSubview:badgeView];
    
  return badgeView;
}

@end
