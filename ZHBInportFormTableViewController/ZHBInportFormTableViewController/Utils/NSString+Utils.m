//
//  NSString+Utils.m
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

-(NSString *)trimmedString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
