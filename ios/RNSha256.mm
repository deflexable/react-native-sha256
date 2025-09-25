#import "RNSha256.h"
#include <CommonCrypto/CommonDigest.h>

@implementation RNSha256
RCT_EXPORT_MODULE()


typedef unsigned char *DIGEST_FUNCTION(const void *data, CC_LONG len, unsigned char *md);

- (NSString*) calcHash: (NSString*) subject withDigestFunction: (DIGEST_FUNCTION) digest withDigestLength: (int) digestLength {

  const char* str = [subject UTF8String];
  unsigned char result[digestLength];
  digest(str, strlen(str), result);

  NSMutableString *ret = [NSMutableString stringWithCapacity:digestLength * 2];
  for(int i = 0; i < digestLength; i++)
  {
    [ret appendFormat:@"%02x",result[i]];
  }

  return ret;
}

- (NSString*) calcHashWithBytes: (NSArray *) subject withDigestFunction: (DIGEST_FUNCTION) digest withDigestLength: (int) digestLength {
  NSUInteger count = [subject count];
  unsigned char *array = (unsigned char *) malloc(count);

  if (array == nil) return nil;

  for (int i = 0; i < count; ++i) {
    array[i] = [[subject objectAtIndex: i] unsignedCharValue];
  }

  unsigned char result[digestLength];
  digest(array, count, result);
  free(array);
  NSMutableString *ret = [NSMutableString stringWithCapacity:digestLength * 2];
  for(int i = 0; i < digestLength; i++)
  {
    [ret appendFormat:@"%02x",result[i]];
  }

  return ret;
}

- (NSString *)sha1: (NSString *) data  {
  NSString *ret = [self calcHash:data withDigestFunction:CC_SHA1 withDigestLength: CC_SHA1_DIGEST_LENGTH];
  if (ret) {
    return(ret);
  } else {
    NSException* exeption = [NSException
                             exceptionWithName:@"Excepption"
                             reason:@"out of memory"
                             userInfo:nil];
    @throw exeption;
  }
}

- (NSString *)sha1Bytes:(NSArray *) data {
  NSString *ret = [self calcHashWithBytes:data withDigestFunction:CC_SHA1 withDigestLength: CC_SHA1_DIGEST_LENGTH];
  if (ret) {
    return(ret);
  } else {
    NSException* exeption = [NSException
                             exceptionWithName:@"Excepption"
                             reason:@"out of memory"
                             userInfo:nil];
    @throw exeption;
  }
}

- (NSString *)sha256: (NSString *) data {
  NSString *ret = [self calcHash:data withDigestFunction:CC_SHA256 withDigestLength: CC_SHA256_DIGEST_LENGTH];
  if (ret) {
    return(ret);
  } else {
    NSException* exeption = [NSException
                             exceptionWithName:@"Excepption"
                             reason:@"out of memory"
                             userInfo:nil];
    @throw exeption;
  }
}

- (NSString *)sha256Bytes:(NSArray *)data {
  NSString *ret = [self calcHashWithBytes:data withDigestFunction:CC_SHA256 withDigestLength: CC_SHA256_DIGEST_LENGTH];
  if (ret) {
    return(ret);
  } else {
    NSException* exeption = [NSException
                             exceptionWithName:@"Excepption"
                             reason:@"out of memory"
                             userInfo:nil];
    @throw exeption;
  }
}


- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
(const facebook::react::ObjCTurboModule::InitParams &)params
{
  return std::make_shared<facebook::react::NativeRNSha256SpecJSI>(params);
}

@end
