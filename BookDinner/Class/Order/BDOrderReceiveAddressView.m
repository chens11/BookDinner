//
//  BDOrderReceiveAddressView.m
//  BookDinner
//
//  Created by zqchen on 6/8/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "BDOrderReceiveAddressView.h"
@interface BDOrderReceiveAddressView()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@end

@implementation BDOrderReceiveAddressView
@synthesize addressModel = _addressModel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self addSubview:self.nameLabel];
        
        self.phoneLabel = [[UILabel alloc] init];
        self.phoneLabel.backgroundColor = [UIColor clearColor];
        self.phoneLabel.textAlignment = NSTextAlignmentRight;
        self.phoneLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:self.phoneLabel];
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.numberOfLines = 0;
        self.addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.addressLabel.backgroundColor = [UIColor clearColor];
        self.addressLabel.textColor = [UIColor lightGrayColor];
        self.addressLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:self.addressLabel];
        // Initialization code
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.phoneLabel.frame = CGRectMake(self.frame.size.width - 115, 10, 115, 30);
    self.nameLabel.frame = CGRectMake(10, 10, self.frame.size.width - 130, 30);
    self.addressLabel.frame = CGRectMake(10, 40, self.frame.size.width - 5, self.frame.size.height - 40);
}
- (void)setAddressModel:(BDAddressModel *)addressModel{
    _addressModel = addressModel;
    if ([addressModel isKindOfClass:[BDAddressModel class]]) {
        BDAddressModel *cModel = addressModel;
        self.nameLabel.text = cModel.name;
        self.phoneLabel.text = cModel.tel;
        self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",cModel.province,cModel.city,cModel.area,cModel.address];
    }
    else{
        self.nameLabel.text = @"请您输入收货地址";
    }
//    self.nameLabel.text = @"高先生";
//    self.phoneLabel.text = @"15814590153";
//    self.addressLabel.text = @"上区绿地科技岛广场A座2606室";


}
@end

