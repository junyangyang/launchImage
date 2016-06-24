//
//  HttpsTool.h
//  AFN
//
//  Created by 俊洋洋 on 16/6/22.
//  Copyright © 2016年 俊洋洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface LYHttpsTool : NSObject

/**
 *  get请求
 *
 *  @param url     请求地址
 *  @param parame  请求参数
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
+ (void)get:(NSString *)url parame:(NSDictionary *)parame success:(void (^)(id JSON))success failure:(void (^)(NSError *error))failure;

/**
 *  post请求
 *
 *  @param url     请求地址
 *  @param parame  请求参数
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
+ (void)post:(NSString *)url parame:(NSDictionary *)parame success:(void (^)(id JSON))success failure:(void (^)(NSError *error))failure;

/**
 *  下载
 *
 *  @param url               下载地址
 *  @param filePath          下载到手机的路径
 *  @param progress          下载进度，0%~100%
 *  @param completionHandler 下载完成调用的block
 */
+ (void)download:(NSString *)url filePath:(NSString *)filePath loadprogress:(void (^)(CGFloat progress))progress completionHandler:(void (^)(NSURLResponse * response, NSURL * filePath, NSError * error))completionHandler;



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
+(void)uploadCutImage:(NSString *)url parame:(NSDictionary *)parame fileImage:(UIImage *)image cutradio:(CGFloat)radio uploadProgress:(void (^)(CGFloat progress))progress success:(void (^)(NSURLSessionDataTask * task, id  responseObject))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;

/**
 *  上传视频(根据URL,其实图片也可以依据URL上传,改一下格式即可)
 *
 *  @param url      上传地址
 *  @param parame   上传参数
 *  @param videoUrl 上传图片
 *  @param progress 上传进度 0%~100%
 *  @param success  上传成功block
 *  @param failure  上传失败block
 */
+ (void)uploadVideo:(NSString *)url parame:(NSDictionary *)parame videoUrl:(NSURL *)videoUrl uploadProgress:(void (^)(CGFloat progress))progress success:(void (^)(NSURLSessionDataTask * task, id  responseObject))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;


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
+ (void)uploadcutVideo:(NSString *)url parame:(NSDictionary *)parame videoUrl:(NSURL *)videoUrl presetName:(NSString *)presetName uploadProgress:(void (^)(CGFloat progress))progres success:(void (^)(NSURLSessionDataTask * task, id  responseObject))success failure:(void (^)(NSURLSessionDataTask * task, NSError * error))failure;
 */


/**
 *  监听当前网络状态
 */
+ (void)getNetworkStatus;
@end
