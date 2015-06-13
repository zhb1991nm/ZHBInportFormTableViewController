//
//  ZHBInputFormCellFramesModel.h
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZHBInputFormCellModel.h"

@interface ZHBInputFormCellFramesModel : NSObject

@property (nonatomic,assign,readonly) CGRect titleLabelFrame;

@property (nonatomic,assign,readonly) CGRect starLabelFrame;

@property (nonatomic,assign,readonly) CGRect inputFrame;

@property (nonatomic,assign,readonly) CGRect noticeAndErrorLabelFrame;

@property (nonatomic,assign,readonly) CGRect placeHolderLabelFrame;

@property (nonatomic,assign,readonly) CGFloat cellHeight;

@property (nonatomic,strong) ZHBInputFormCellModel *cellModel;

@property (nonatomic,assign) CGFloat tableViewFrameWidth;

-(instancetype)initWithCellModel:(ZHBInputFormCellModel *)cellModel;

-(void)calculateFrames;

@end
