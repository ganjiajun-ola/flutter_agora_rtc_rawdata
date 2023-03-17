#include "AudioFrameObserver.h"
#include "VideoFrameObserver.h"
#include <jni.h>

extern "C" JNIEXPORT void JNICALL
Java_io_agora_rtc_rawdata_base_IAudioFrameObserver_nativeSetEnableSetPushDirectAudio(
        JNIEnv *env, jobject, jlong nativeHandle, jboolean enableSetPushDirectAudio) {
    auto observer = reinterpret_cast<agora::AudioFrameObserver *>(nativeHandle);
    observer->setEnableSetPushDirectAudio(enableSetPushDirectAudio);
}

extern "C" JNIEXPORT jlong JNICALL
Java_io_agora_rtc_rawdata_base_IAudioFrameObserver_nativeRegisterAudioFrameObserver(
    JNIEnv *env, jobject jCaller, jlong engineHandle, jboolean enableSetPushDirectAudio) {
  auto observer = new agora::AudioFrameObserver(env, jCaller, engineHandle, enableSetPushDirectAudio);
  jlong ret = reinterpret_cast<intptr_t>(observer);
  return ret;
}

extern "C" JNIEXPORT void JNICALL
Java_io_agora_rtc_rawdata_base_IAudioFrameObserver_nativeUnregisterAudioFrameObserver(
    JNIEnv *, jobject, jlong nativeHandle) {
  auto observer = reinterpret_cast<agora::AudioFrameObserver *>(nativeHandle);
  delete observer;
}

extern "C" JNIEXPORT jlong JNICALL
Java_io_agora_rtc_rawdata_base_IVideoFrameObserver_nativeRegisterVideoFrameObserver(
    JNIEnv *env, jobject jCaller, jlong engineHandle) {
  auto observer = new agora::VideoFrameObserver(env, jCaller, engineHandle);
  jlong ret = reinterpret_cast<intptr_t>(observer);
  return ret;
}

extern "C" JNIEXPORT void JNICALL
Java_io_agora_rtc_rawdata_base_IVideoFrameObserver_nativeUnregisterVideoFrameObserver(
    JNIEnv *, jobject, jlong nativeHandle) {
  auto observer = reinterpret_cast<agora::VideoFrameObserver *>(nativeHandle);
  delete observer;
}
