import Flutter
import UIKit

public class SwiftAgoraRtcRawdataPlugin: NSObject, FlutterPlugin, AgoraAudioFrameDelegate, AgoraVideoFrameDelegate {
    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "agora_rtc_rawdata", binaryMessenger: registrar.messenger())
        let instance = SwiftAgoraRtcRawdataPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel!)
    }

    private var audioObserver: AgoraAudioFrameObserver?
    private var videoObserver: AgoraVideoFrameObserver?
    
    static private var channel: FlutterMethodChannel?

    private var enableSetPushDirectAudio: Bool = false

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPushDirectAudioEnable":
            result(enableSetPushDirectAudio)
        case "setPushDirectAudioEnable":
            enableSetPushDirectAudio = call.arguments as! Bool
            audioObserver?.enableSetPushDirectAudio = enableSetPushDirectAudio
            result(nil)
        case "registerAudioFrameObserver":
            if audioObserver == nil {
                audioObserver = AgoraAudioFrameObserver(engineHandle: call.arguments as! UInt, enableSetPushDirectAudio)
            }
            audioObserver?.delegate = self
            audioObserver?.register()
            result(nil)
        case "unregisterAudioFrameObserver":
            if audioObserver != nil {
                audioObserver?.delegate = nil
                audioObserver?.unregisterAudioFrameObserver()
                audioObserver = nil
            }
            result(nil)
        case "registerVideoFrameObserver":
            if videoObserver == nil {
                videoObserver = AgoraVideoFrameObserver(engineHandle: call.arguments as! UInt)
            }
            videoObserver?.delegate = self
            videoObserver?.register()
            result(nil)
        case "unregisterVideoFrameObserver":
            if videoObserver != nil {
                videoObserver?.delegate = nil
                videoObserver?.unregisterVideoFrameObserver()
                videoObserver = nil
            }
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func onRecord(_ frame: AgoraAudioFrame) -> Bool {
        //NSLog("Peter onRecordAudioFrame 33333 " + String(enableSetPushDirectAudio))
        
        var data = Data(bytes: frame.buffer, count:(Int)(frame.samples * frame.bytesPerSample * frame.channels));

        SwiftAgoraRtcRawdataPlugin.channel?.invokeMethod("onRecordAudioFrame_type", arguments: frame.avsync_type)
        SwiftAgoraRtcRawdataPlugin.channel?.invokeMethod("onRecordAudioFrame_samples", arguments: frame.samples)
        SwiftAgoraRtcRawdataPlugin.channel?.invokeMethod("onRecordAudioFrame_bytesPerSample", arguments: frame.bytesPerSample)
        SwiftAgoraRtcRawdataPlugin.channel?.invokeMethod("onRecordAudioFrame_channels", arguments: frame.channels)
        SwiftAgoraRtcRawdataPlugin.channel?.invokeMethod("onRecordAudioFrame_samplesPerSec", arguments: frame.samplesPerSec)
        SwiftAgoraRtcRawdataPlugin.channel?.invokeMethod("onRecordAudioFrame_buffer", arguments: data)
        SwiftAgoraRtcRawdataPlugin.channel?.invokeMethod("onRecordAudioFrame_renderTimeMs", arguments: frame.renderTimeMs)
        SwiftAgoraRtcRawdataPlugin.channel?.invokeMethod("onRecordAudioFrame_avsync_type", arguments: frame.avsync_type)
        
        SwiftAgoraRtcRawdataPlugin.channel?.invokeMethod("onRecordAudioFrame", arguments: nil);
        

        return true
    }

    public func onPlaybackAudioFrame(_: AgoraAudioFrame) -> Bool {
        return true
    }

    public func onMixedAudioFrame(_: AgoraAudioFrame) -> Bool {
        return true
    }

    public func onPlaybackAudioFrame(beforeMixing _: AgoraAudioFrame, uid _: UInt) -> Bool {
        return true
    }

    public func onCapture(_ videoFrame: AgoraVideoFrame) -> Bool {
        memset(videoFrame.uBuffer, 0, Int(videoFrame.uStride * videoFrame.height) / 2)
        memset(videoFrame.vBuffer, 0, Int(videoFrame.vStride * videoFrame.height) / 2)
        return true
    }

    public func onRenderVideoFrame(_ videoFrame: AgoraVideoFrame, uid _: UInt) -> Bool {
        memset(videoFrame.uBuffer, 255, Int(videoFrame.uStride * videoFrame.height) / 2)
        memset(videoFrame.vBuffer, 255, Int(videoFrame.vStride * videoFrame.height) / 2)
        return true
    }
}
