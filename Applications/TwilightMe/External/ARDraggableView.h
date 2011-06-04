#import <Foundation/Foundation.h>

@class ARDraggableView;

@protocol ARDraggableViewDelegate <NSObject>

- (void) dragDidEnd:(ARDraggableView *)draggableView;

@end

@interface ARDraggableView : UIView
{
	id <ARDraggableViewDelegate> delegate;
	
@private
	CGPoint _offsetPoint;
}

@property (nonatomic, retain) id <ARDraggableViewDelegate> delegate;

@end