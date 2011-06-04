#import <Foundation/Foundation.h>

@class ARToggleButtonGroup;

@interface ARToggleButton : UIButton
{
	BOOL enableClick;
	ARToggleButtonGroup *group;
	
@private
	BOOL _on;
	UIImage *_onImage;
	UIImage *_offImage;
}

@property (nonatomic, retain) ARToggleButtonGroup *group;
@property (nonatomic) BOOL enableClick;
@property (nonatomic) BOOL on;

- (id) initWithImages:(UIImage *)onImage offImage:(UIImage *)offImage;
- (void) setImages:(UIImage *)onImage offImage:(UIImage *)offImage;

@end
