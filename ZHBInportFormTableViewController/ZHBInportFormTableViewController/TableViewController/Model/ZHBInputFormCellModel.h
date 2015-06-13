//
//  ZHBInputFormCellModel.h
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHBInputFormCellModel : NSObject

@property (nonatomic,copy) NSString *title;//属性名

@property (nonatomic,assign) BOOL required;//必填

@property (nonatomic,copy) NSString *placeHolderString;//站位

@property (nonatomic,copy) NSString *inputString;//填充

@property (nonatomic,copy) NSString *noticeString;//提示信息

@property (nonatomic,copy) NSString *errorString;//错误信息

@property (nonatomic,copy) NSString *propertyTag;//属性标示

@property (nonatomic,assign) BOOL error;//错误状态

@property (nonatomic,assign) BOOL longText;//是长文本输入

@property (nonatomic,assign) BOOL encrypt;//密码

-(instancetype)initWithTitle:(NSString *)title inputString:(NSString *)inputString placeHolderString:(NSString *)placeHolderString noticeString:(NSString *)noticeString longText:(BOOL)longText required:(BOOL)required encrypt:(BOOL)encrypt propertyTag:(NSString *)propertyTag;

@end
