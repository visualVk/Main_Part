//
//  EmptyCollectionViewCell.m
//  MainPart
//
//  Created by blacksky on 2020/3/14.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "EmptyCollectionViewCell.h"

@implementation EmptyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) { self.backgroundColor = UIColor.clearColor; }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

@end
