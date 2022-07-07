#import "FlutterMongoRealmPlugin.h"
#if __has_include(<flutter_mongodb_realm/flutter_mongodb_realm-Swift.h>)
#import <flutter_mongodb_realm/flutter_mongodb_realm-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_mongodb_realm-Swift.h"
#endif

@implementation FlutterMongoRealmPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterMongoRealmPlugin registerWithRegistrar:registrar];
}
@end
