/*
 *  ARImage.h
 *  ImageProcessing
 *
 *  Created by Chris Greening on 02/01/2009.
 *
 */

#import <UIKit/UIImage.h>

#include <vector>

class ARImage;
// objective C wrapper for our image class
@interface ARImageWrapper : NSObject {
	ARImage *image;
	bool ownsImage;
}

@property(assign, nonatomic) ARImage *image;
@property(assign, nonatomic) bool ownsImage;
+ (ARImageWrapper *) imageWithCPPImage:(ARImage *) theImage;

@end

class ARImagePoint {
public:
	short x,y;
	inline ARImagePoint(short xpos, short ypos) {
		x=xpos;
		y=ypos;
	}
	inline ARImagePoint(int xpos, int ypos) {
		x=xpos;
		y=ypos;
	}
	inline ARImagePoint(const ARImagePoint &other) {
		x=other.x;
		y=other.y;
	}
	inline ARImagePoint() {
		x=0; y=0;
	}
};

class ARImage {
private:
	uint8_t *m_imageData;
	uint8_t **m_yptrs;
	int m_width;
	int m_height;
	bool m_ownsData;
	ARImage(ARImageWrapper *other, int x1, int y1, int x2, int y2);
	ARImage(int width, int height);
	ARImage(uint8_t *imageData, int width, int height, bool ownsData=false);
	ARImage(UIImage *srcImage, int width, int height, CGInterpolationQuality interpolation, bool imageIsRotatedBy90degrees=false);
	void initYptrs();
public:
	// copy a section of another image
	static ARImageWrapper *createImage(ARImageWrapper *other, int x1, int y1, int x2, int y2);
	// create an empty image of the required width and height
	static ARImageWrapper *createImage(int width, int height);
	// create an image from data
	static ARImageWrapper *createImage(uint8_t *imageData, int width, int height, bool ownsData=false);
	// take a source UIImage and convert it to greyscale
	static ARImageWrapper *createImage(UIImage *srcImage, int width, int height, bool imageIsRotatedBy90degrees=false);
	// edge detection
	ARImageWrapper *cannyEdgeExtract(float tlow, float thigh);
	// local thresholding
	ARImageWrapper* autoLocalThreshold();
	// threshold using integral
	ARImageWrapper *autoIntegratingThreshold();
	// threshold an image automatically
	ARImageWrapper *autoThreshold();
	// gaussian smooth the image
	ARImageWrapper *gaussianBlur();
	// get the percent set pixels
	int getPercentSet();
	// exrtact a connected area from the image
	void extractConnectedRegion(int x, int y, std::vector<ARImagePoint> *points);
	// find the largest connected region in the image
	void findLargestStructure(std::vector<ARImagePoint> *maxPoints);
	// normalise an image
	void normalise();
	// rotate by 90, 180, 270, 360
	ARImageWrapper *rotate(int angle);
	// shrink to a new size
	ARImageWrapper *resize(int newX, int newY);
	ARImageWrapper *shrinkBy2();
	// histogram equalisation
	void HistogramEqualisation();
	// skeltonize
	void skeletonise();
	// convert back to a UIImage for display
	UIImage *toUIImage();
	~ARImage() {
		if(m_ownsData)
			free(m_imageData);
		delete m_yptrs;
	}
	inline uint8_t* operator[](const int rowIndex) {
		return m_yptrs[rowIndex];
	}
	inline int getWidth() {
		return m_width;
	}
	inline int getHeight() {
		return m_height;
	}
};

inline bool sortByX1(const ARImagePoint &p1, const ARImagePoint &p2) {
	if(p1.x==p2.x) return p1.y<p2.y;
	return p1.x<p2.x;
}

inline bool sortByY1(const ARImagePoint &p1, const ARImagePoint &p2) {
	if(p1.y==p2.y) return p1.x<p2.x;
	return p1.y<p2.y;
}

