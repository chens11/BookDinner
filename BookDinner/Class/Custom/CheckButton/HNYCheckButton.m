//
//  HNYCheckButton.m
//  exoa_mobile
//
//  Created by chen zq on 10/11/13.
//
//

#import "HNYCheckButton.h"

@interface HNYCheckButton ()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *selectButton;
@property (nonatomic,strong) id orignal;

@end

@implementation HNYCheckButton
@synthesize nameKey = _nameKey;
@synthesize valueKey = _valueKey;
@synthesize nameLabel;
@synthesize imageView;
@synthesize selectButton;
@synthesize delegate;
@synthesize selected = _selected;
@synthesize orignal;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.numberOfLines = 2;
        self.nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.nameLabel];
        
        self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectButton addTarget:self action:@selector(touchesSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.selectButton];
        
        // Initialization code
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.frame;
    self.imageView.frame = CGRectMake(0, (rect.size.height - 25)/2, 25, 25);
    self.nameLabel.frame  = CGRectMake(self.imageView.frame.size.width + 2, 0, rect.size.width - self.imageView.frame.size.width, rect.size.height);
    self.selectButton.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesSelectButton:(UIButton*)sender{
    self.selected = !self.selected;
    [self.orignal setObject:[NSNumber numberWithBool:self.selected] forKey:self.valueKey];
    
    [self.delegate checkButton:self selectedBySender:sender];
}

- (void)setUpWithObject:(id)object{
    self.orignal = object;
    if ([object isKindOfClass:[NSDictionary class]]) {
        self.nameLabel.text = [object objectForKey:self.nameKey];
        self.selected = [[object objectForKey:self.valueKey] boolValue];
    }
}

- (void)setSelected:(BOOL)selected{
    _selected  = selected;
    if (_selected) {
        self.imageView.image = [UIImage imageNamed:@"bg_Radio_Down"];
    }else{
        self.imageView.image = [UIImage imageNamed:@"bg_Radio"];
    }
}

- (NSString *)nameKey{
    if (_nameKey)
        return _nameKey;
    return @"name";
}


- (NSString *)valueKey{
    if (_valueKey)
        return _valueKey;
    return @"value";
}
@end
