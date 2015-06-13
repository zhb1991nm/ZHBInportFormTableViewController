//
//  ZHBInputFormCellModel.m
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ZHBInputFormCellModel.h"

@implementation ZHBInputFormCellModel

-(instancetype)initWithTitle:(NSString *)title inputString:(NSString *)inputString placeHolderString:(NSString *)placeHolderString noticeString:(NSString *)noticeString longText:(BOOL)longText required:(BOOL)required encrypt:(BOOL)encrypt propertyTag:(NSString *)propertyTag{
    self = [super init];
    if (self) {
        self.title = title;
        self.inputString = inputString;
        self.placeHolderString = placeHolderString;
        self.noticeString = noticeString;
        self.longText = longText;
        self.required = required;
        self.encrypt = encrypt;
        self.propertyTag = propertyTag;
    }
    return self;
}

@end
