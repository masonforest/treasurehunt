/*===============================================================================
Copyright (c) 2016 PTC Inc. All Rights Reserved.

 Copyright (c) 2012-2015 Qualcomm Connected Experiences, Inc. All Rights Reserved.
 
 Vuforia is a trademark of PTC Inc., registered in the United States and other
 countries.
 ===============================================================================*/

#import <UIKit/UIKit.h>

#import <Vuforia/UIGLViewProtocol.h>

#import "Texture.h"
#import "SampleApplicationSession.h"
#import "VideoPlayerHelper.h"
#import "SampleGLResourceHandler.h"
#import "SampleAppRenderer.h"


static const int kNumAugmentationTextures = 7;
static const int kNumVideoTargets = 4;

// VideoPlayback is a subclass of UIView and conforms to the informal protocol
// UIGLViewProtocol
@interface VideoPlaybackEAGLView : UIView <UIGLViewProtocol, SampleGLResourceHandler, SampleAppRendererControl> {
@private
    // Instantiate one VideoPlayerHelper per target
    VideoPlayerHelper* videoPlayerHelper[kNumVideoTargets];
    float videoPlaybackTime[kNumVideoTargets];
    
    VideoPlaybackViewController * videoPlaybackViewController ;
    
    // Timer to pause on-texture video playback after tracking has been lost.
    // Note: written/read on two threads, but never concurrently
    NSTimer* trackingLostTimer;
    
    // Coordinates of user touch
    float touchLocation_X;
    float touchLocation_Y;
    
    // indicates how the video will be played
    BOOL playVideoFullScreen;
    
    // Lock to synchronise data that is (potentially) accessed concurrently
    NSLock* dataLock;
    
    
    // OpenGL ES context
    EAGLContext *context;
    
    // The OpenGL ES names for the framebuffer and renderbuffers used to render
    // to this view
    GLuint defaultFramebuffer;
    GLuint colorRenderbuffer;
    GLuint depthRenderbuffer;
    
    // Shader handles
    GLuint shaderProgramID;
    GLint vertexHandle;
    GLint normalHandle;
    GLint textureCoordHandle;
    GLint mvpMatrixHandle;
    GLint texSampler2DHandle;
    
    Vuforia::Matrix44F tapProjectionMatrix;
    
    // Texture used when rendering augmentation
    Texture* augmentationTexture[kNumAugmentationTextures];
    SampleAppRenderer *sampleAppRenderer;
}

@property (nonatomic, weak) SampleApplicationSession * vapp;
@property (nonatomic, strong) NSString* filename;

- (id)initWithFrame:(CGRect)frame rootViewController:(VideoPlaybackViewController *) rootViewController appSession:(SampleApplicationSession *) app;

- (void) willPlayVideoFullScreen:(BOOL) fullScreen;

- (void) prepare;
- (void) dismiss;

- (void)finishOpenGLESCommands;
- (void)freeOpenGLESResources;
- (void)configureVideoBackgroundWithViewWidth:(float)viewWidth andHeight:(float)viewHeight;

- (bool) handleTouchPoint:(CGPoint) touchPoint;

- (void) preparePlayers;
- (void) dismissPlayers;
- (void) updateRenderingPrimitives;

@end

