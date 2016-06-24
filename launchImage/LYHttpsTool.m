//
//  HttpsTool.m
//  AFN
//
//  Created by 俊洋洋 on 16/6/22.
//  Copyright © 2016年 俊洋洋. All rights reserved.
//

#import "LYHttpsTool.h"
#import "AFNetworking.h"
#import <AVFoundation/AVFoundation.h>
@implementation LYHttpsTool

/**
 *  get请求
 *
 *  @param url     请求地址
 *  @param parame  请求参数
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
+ (void)get:(NSString *)url parame:(NSDictionary *)parame success:(void (^)(id JSON))success failure:(void (^)(NSError * error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:^(NSProgress * downloadProgress) {
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        failure(error);

    }];
 
}

/**
 *  post请求
 *
 *  @param url     请求地址
 *  @param parame  请求参数
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
+ (void)post:(NSString *)url parame:(NSDictionary *)parame success:(void (^)(id  JSON))success failure:(void (^)(NSError * error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parame progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

/**
 *  下载
 *
 *  @param url               下载地址
 *  @param filePath          下载到手机的路径
 *  @param progress          下载进度，0%~100%
 *  @param completionHandler 下载完成调用的block
 */
+ (void)download:(NSString *)url filePath:(NSString *)filePath loadprogress:(void (^)(CGFloat progress))progress completionHandler:(void (^)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSURLSessionDownloadTask *tast = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            progress(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            return [NSURL URLWithString:filePath];//默认下载地址为targetPath
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {//下载完成调用的方法
            completionHandler(response,filePath,error);
        }];
    [tast resume];
}

/**
 *  上传图片
 *
 *  @param url      上传地址
 *  @param parame   上传参数
 *  @param filename 上传图片
 *  @param progress 上传进度 0%~100%
 *  @param success  上传成功block
 *  @param failure  上传失败block
 */
+ (void)uploadImage:(NSString *)url parame:(NSDictionary *)parame fileImage:(UIImage *)image uploadProgress:(void (^)(CGFloat progress))progress success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parame constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image,1.0);
        //这个就是参数
        [formData appendPartWithFileData:data name:@"image" fileName:@"*.jpg" mimeType:@"image/*"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(1.0f*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}
/**
 *  上传压缩后的图片
 *
 *  @param url      上传地址
 *  @param parame   上传参数
 *  @param image    上传图片
 *  @param radio    压缩比例
 *  @param progress 上传进度 0%~100%
 *  @param success  上传成功block
 *  @param failure  上传失败block
 */
+(void)uploadCutImage:(NSString *)url parame:(NSDictionary *)parame fileImage:(UIImage *)image cutradio:(CGFloat)radio uploadProgress:(void (^)(CGFloat progress))progress success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parame constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image,radio);
        //这个就是参数
        [formData appendPartWithFileData:data name:@"image" fileName:@"*.jpg" mimeType:@"image/*"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(1.0f*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];
}
/**
 *  上传视频(根据URL,其实图片也可以依据URL上传,改一下格式即可)
 *
 *  @param url      上传地址
 *  @param parame   上传参数
 *  @param videoUrl video地址
 *  @param progress 上传进度 0%~100%
 *  @param success  上传成功block
 *  @param failure  上传失败block
 */
+ (void)uploadVideo:(NSString *)url parame:(NSDictionary *)parame videoUrl:(NSURL *)videoUrl uploadProgress:(void (^)(CGFloat progress))progress success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parame constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = [NSData dataWithContentsOfURL:videoUrl];
        //这个就是参数
        [formData appendPartWithFileData:data name:@"image" fileName:@"*.MOV" mimeType:@"video/*"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(1.0f*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task,error);
    }];

}




/**
 *  上传压缩视频
 *
 *  @param url        上传地址
 *  @param parame     上传参数
 *  @param videoUrl   video地址
 *  @param presetName 压缩参数
 *  @param progres    上传进度 0%~100%
 *  @param success    上传成功block
 *  @param failure    上传失败block
 */
/*
+ (void)uploadcutVideo:(NSString *)url parame:(NSDictionary *)parame videoUrl:(NSURL *)videoUrl presetName:(NSString *)presetName uploadProgress:(void (^)(CGFloat progress))progres success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
   NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths lastObject];
    NSString * outputPath = [path stringByAppendingPathComponent:@"lastVdeio.MOV"];
     NSURL * outputURL = [NSURL fileURLWithPath:outputPath];
    [self lowQualityWithInputURL:[NSURL URLWithString:url] outputURL:outputURL presetName:presetName blockHandler:^(AVAssetExportSession * session) {
        if (session.status == AVAssetExportSessionStatusCompleted) {
            NSLog(@"压缩成功");
            [self uploadVideo:url parame:parame videoUrl:outputURL uploadProgress:^(CGFloat progress) {
                progres(progress);
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                success(task,responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                failure(task,error);
            }];
        }else{
            NSLog(@"%@",[session error]);
            NSLog(@"压缩失败");
        }
    }];
}
//压缩视频
+(void)lowQualityWithInputURL:(NSURL *)inputURL outputURL:(NSURL *)outputURL presetName:(NSString *) presetName blockHandler:(void(^)(AVAssetExportSession *))handler{
    
    AVURLAsset * asset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession * session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:presetName];
    session.outputURL = outputURL;
    session.outputFileType = AVFileTypeQuickTimeMovie;
    session.shouldOptimizeForNetworkUse = YES;
    
    [session exportAsynchronouslyWithCompletionHandler:^{
        
        handler(session);
        
    }];
}
*/

/**
 *  监听当前网络状态
 */
+ (void)getNetworkStatus
{
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];

    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
    [manager startMonitoring];
}

@end
