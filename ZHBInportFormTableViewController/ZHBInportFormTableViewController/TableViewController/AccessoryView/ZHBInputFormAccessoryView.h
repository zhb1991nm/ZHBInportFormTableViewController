//
//  ZHBInputFormAccessoryView.h
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHBInputFormAccessoryView : UIView

- (id) initWithResponders:(NSArray *)responders;

@property (nonatomic, strong) NSArray *responders;

@property (nonatomic, assign) BOOL hasDoneButton;

- (void) setHasDoneButton:(BOOL)hasDoneButton animated:(BOOL)animated;

@end
