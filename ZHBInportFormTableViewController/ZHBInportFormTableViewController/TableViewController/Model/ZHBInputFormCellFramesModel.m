//
//  ZHBInputFormCellFramesModel.m
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ZHBInputFormCellFramesModel.h"
#import "ZHBInputFormConstants.h"

@implementation ZHBInputFormCellFramesModel

-(instancetype)init{
    self = [super init];
    if (self) {
        self.tableViewFrameWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return self;
}

-(instancetype)initWithCellModel:(ZHBInputFormCellModel *)cellModel{
    self = [self init];
    if (self) {
        self.cellModel = cellModel;
    }
    return self;
}


-(void)setCellModel:(ZHBInputFormCellModel *)cellModel{
    _cellModel = cellModel;
    [self calculateFrames];
}

-(void)calculateFrames{
    if (_cellModel.required) {
        _titleLabelFrame = CGRectMake(0, ZHBInputFormCellPadding, ZHBInputFormContentOriginX - ZHBInputFormCellPadding * 2 - ZHBInputFormCellStarLabelWidth,ZHBInputFormCellTitleLabelHeight);
        _starLabelFrame = CGRectMake(CGRectGetMaxX(_titleLabelFrame), ZHBInputFormCellPadding, ZHBInputFormCellStarLabelWidth,ZHBInputFormCellStarLabelHeight);
    }else{
        _titleLabelFrame = CGRectMake(0, ZHBInputFormCellPadding, ZHBInputFormContentOriginX - ZHBInputFormCellPadding * 2,ZHBInputFormCellTitleLabelHeight);
    }
    CGFloat contentWidth = self.tableViewFrameWidth - ZHBInputFormContentOriginX - ZHBInputFormCellPadding;
    _inputFrame = CGRectMake(ZHBInputFormContentOriginX, ZHBInputFormCellPadding, contentWidth , _cellModel.longText ? ZHBInputFormCellLongTextInputHeight:ZHBInputFormCellInputHeight);
    if(_cellModel.longText){
        _placeHolderLabelFrame = CGRectMake(CGRectGetMinX(_inputFrame), CGRectGetMinY(_inputFrame) - 5, CGRectGetWidth(_inputFrame), ZHBInputFormCellInputHeight);
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    
    CGSize contentSize = [_cellModel.noticeString sizeWithFont:ZHBInputFormCellNoticeFont constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX)];
    //    if (_cellModel.error) {
    //        contentSize = [_cellModel.errorString sizeWithFont:ZHBInputFormCellNoticeFont constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX)];
    //    }else{
    //        contentSize = [_cellModel.noticeString sizeWithFont:ZHBInputFormCellNoticeFont constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX)];
    //    }
#pragma clang diagnostic pop
    CGFloat noticeHeight = contentSize.height > 0 ? contentSize.height: 30;
    
    _noticeAndErrorLabelFrame = CGRectMake(ZHBInputFormContentOriginX, CGRectGetMaxY(_inputFrame), contentWidth, noticeHeight);
    _cellHeight = CGRectGetMaxY(_noticeAndErrorLabelFrame) + ZHBInputFormCellPadding;
}

@end
