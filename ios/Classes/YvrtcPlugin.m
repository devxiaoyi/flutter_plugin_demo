#import "YvrtcPlugin.h"
#if __has_include(<yvrtc_plugin/yvrtc_plugin-Swift.h>)
#import <yvrtc_plugin/yvrtc_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "yvrtc_plugin-Swift.h"
#endif

@implementation YvrtcPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYvrtcPlugin registerWithRegistrar:registrar];
}
@end
