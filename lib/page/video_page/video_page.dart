import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'package:course_booking_app/style/index.dart';
import 'package:course_booking_app/utils/utils.dart';

class VideoPage extends StatefulWidget {
  String url;
  String tag;

  VideoPage({@required this.url, this.tag});

  @override
  VideoPageState createState() => VideoPageState();
}

class VideoPageState extends State<VideoPage> {
  VideoPlayerController videoController;
  Future videoFuture;
  bool isShowActions = true;
  Timer timer;
  int totalSeconds = 0; // 视频总时长(s)
  int downSeconds = 0; // 已观看时长(s)
  String videoLength = '';
  String doneLength = '';

  @override
  void initState() {
    super.initState();
    initController();
  }

  void initController() {
    videoController = VideoPlayerController.asset(widget.url);
    videoFuture = videoController.initialize().then((_) {
      setState(() {
        // 获取视频总时长(秒), 四舍五入精确到秒
        totalSeconds = (videoController.value.duration.inMilliseconds / 1000).round();
        videoLength = getTimeStr(totalSeconds);
      });
    });
    // 监听视频进度变化, 更改已观看时间
    videoController.addListener(() {
      setState(() {
        downSeconds = (videoController.value.position.inMilliseconds / 1000).round();
        doneLength = getTimeStr(downSeconds);
      });
    });
    videoController.play();
    showActions();
  }

  // 显示操作栏, 并在3秒后隐藏
  void showActions() {
    setState(() {
      isShowActions = true;
    });
    // 若上一次倒计时没结束, 则手动结束, 重新倒计时
    cancelTimer();
    timer = Timer(Duration(seconds: 4), () {
      setState(() {
        isShowActions = false;
      });
    });
  }

  void toggleShowActions() {
    if(!isShowActions) {
      showActions();
    } else {
      setState(() {
        isShowActions = false;
      });
    }
  }

  // 暂停/播放
  void togglePlay() {
    if(downSeconds < totalSeconds) {
      videoController.value.isPlaying ? videoController.pause() : videoController.play();
    } else {
      playStartAtPosition(0);
    }
  }

  // 从指定位置开始播放
  void playStartAtPosition(int position) {
    videoController.seekTo(Duration(seconds: position));
    videoController.play();
  }

  void cancelTimer() {
    if(timer != null) {
      timer.cancel();
    }
  }

  void goBack() {
    cancelTimer();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
    cancelTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: toggleShowActions,
        child: FutureBuilder(
          future: videoFuture,
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              print(snapshot.error);
            }
            if(snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: widget.tag,
                      child: AspectRatio(
                        aspectRatio: videoController.value.aspectRatio,
                        child: VideoPlayer(videoController),
                      ),
                    ),
                  ),
                  if(isShowActions) Positioned(
                    bottom: 0,
                    child: Container(
                      width: Gsize.deviceWidth,
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(Gpadding.l, 0, Gpadding.l, Gpadding.m),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: togglePlay,
                                child: Icon(
                                  videoController.value.isPlaying ? Icons.pause : Icons.play_arrow, 
                                  color: Colors.white
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(right: Gpadding.s)),
                              Text(doneLength, style: TextStyle(color: Colors.white)),
                              Expanded(
                                child: Slider(
                                  min: 0,
                                  max: double.parse(totalSeconds.toString()),
                                  value: double.parse(downSeconds.toString()),
                                  activeColor: Colors.white,
                                  inactiveColor: Color.fromRGBO(255, 255, 255, .3),
                                  onChangeStart: (double value) {
                                    videoController.pause();
                                  },
                                  // 这里有坑, slider组件必须设置了onChanged事件, activeColor和inactiveColor属性才会生效
                                  onChanged: (double value) {
                                    setState(() {
                                      int position = value.round();
                                      downSeconds = position;
                                      videoController.seekTo(Duration(seconds: position));
                                    });
                                  },
                                  onChangeEnd: (double value) {
                                    playStartAtPosition(downSeconds);
                                  },
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(right: Gpadding.s)),
                              Text(videoLength, style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: Gpadding.l)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: goBack,
                                child: Icon(Icons.close, color: Colors.white),
                              ),
                              Icon(Icons.more_horiz, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.white),
              );
            }
          }
        ) 
      ), 
    );
  }
}
