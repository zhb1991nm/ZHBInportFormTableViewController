//
//  ZHBInputFormConstants.h
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#ifndef ZHBInputFormTableView_ZHBInputFormConstants_h
#define ZHBInputFormTableView_ZHBInputFormConstants_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ZHBInputFormContentOriginX 100.0f
#define ZHBInputFormButtonMargin 10.0f
#define ZHBInputFormButtonWidth 60.0f
#define ZHBInputFormButtonHeight 35.0f

#define ZHBInputFormCellPadding 5.0f

#define ZHBInputFormCellTitleLabelHeight 40.0f
#define ZHBInputFormCellInputHeight 40.0f
#define ZHBInputFormCellLongTextInputHeight 80.0f

#define ZHBInputFormCellStarLabelWidth 10.0f
#define ZHBInputFormCellStarLabelHeight 40.0f

#define ZHBInputFormCellTitleLabelFont [UIFont systemFontOfSize:14.0f]
#define ZHBInputFormCellInputFont [UIFont systemFontOfSize:14.0f]
#define ZHBInputFormCellNoticeFont [UIFont systemFontOfSize:14.0f]

#endif
