import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/home/articles/ArticleBloc.dart';
import 'package:giraffe_spotter/blocs/home/articles/ArticleState.dart';
import 'package:giraffe_spotter/blocs/videos/VideoCubit.dart';
import 'package:giraffe_spotter/blocs/videos/VideoState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/models/WelcomeJson.dart';
import 'package:giraffe_spotter/pages/home/pages/Articles.dart';
import 'package:giraffe_spotter/pages/home/pages/Videos.dart';
import 'package:giraffe_spotter/pages/home/widgets/ArticleCard.dart';
import 'package:giraffe_spotter/pages/home/widgets/CardSlide.dart';
import 'package:giraffe_spotter/pages/home/widgets/SliderHeader.dart';
import 'package:giraffe_spotter/pages/home/widgets/YoutubeVideoPlayer.dart';
import 'package:giraffe_spotter/pages/learn/widgets/Header.dart';
import 'package:giraffe_spotter/pages/learn/widgets/SocialIcon.dart';
import 'package:giraffe_spotter/widgets/LoadingWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:giraffe_spotter/utils/Extensions.dart';

class TopAbout extends StatelessWidget{

  _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 29),
          child:Column(
            children:[
              Header(title: "About Giraffe Spotter"),
              SizedBox(height: 9),
              RichText(
                text: TextSpan(
                  text: "Giraffe Spotter ",
                  style: Styles.aboutBodyTitleColor,
                  children: [
                    TextSpan(
                        text: Constants.learnAbout,
                        style: Styles.aboutBodyColor.copyWith(fontSize: 16)),
                    TextSpan(
                        text: ' Learn More',
                        recognizer: TapGestureRecognizer()..onTap = () => _launchURL('https://giraffespotter.org/overview.jsp'),
                        style: Styles.aboutBodyTitleColor.copyWith(color:Palette.tertiaryColor,fontSize: 16)
                    )
                  ],
                ),
              ),
              SizedBox(height: 8),
              Header(title: "Connect with GCF"),
              SizedBox(height: 9),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SocialIcon(icon: Assets.website),
                  GestureDetector(
                    onTap:()=>_launchURL('https://giraffeconservation.org'),
                    child:Image.asset(Assets.website,width:30,height: 30),
                  ),
                  GestureDetector(
                      onTap: ()=> _launchURL('https://www.instagram.com/giraffe_conservation/?hl=en'),
                      child: SocialIcon(icon: Assets.instagram)
                  ),
                  GestureDetector(onTap:()=> _launchURL('https://www.youtube.com/results?search_query=giraffe+conservation+foundation'),
                    child:SocialIcon(icon: Assets.youtube),
                  ),
                  GestureDetector(
                    onTap: ()=>_launchURL('https://www.facebook.com/giraffeconservationfoundation'),
                    child: SocialIcon(icon: Assets.facebook),
                  ),
                ],
              ),
              SizedBox(height: 25),
              SliderHeader(
                title: "Videos",
                action: () => locator!<AppRoute>().navigateTo(VideoViewer()), keyString: 'Video',
              ),
              SizedBox(height: 15),
            ]
          )
        ),
        LimitedBox(
          maxHeight: MediaQuery.of(context).size.height/3.80,
          child: BlocBuilder<VideoCubit, VideoState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(child: CircularProgressIndicator(backgroundColor: Palette.accentColor));
              }
              else if (state is ErrorState) {
                return state.error!.maybeWhen(
                  noInternetConnection: () => CircularProgressIndicator(color: Palette.accentColor),
                  orElse: () => Container(),
                );
              }
              else if (state is LoadedState) {
                final videos = state.videos;
                 return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: videos.length > 5 ? 5 : videos.length,
                  padding: EdgeInsets.only(left:20,bottom: 3),
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return Padding (
                      padding: EdgeInsets.only(right: 14,left:4,bottom: 3),
                      child: CardSlide (
                        video: true,
                        time: DateTime.parse(video.publishedAt!).timeago(),
                        cardTitle: video.title,
                        imageType: true,
                        image: video.thumbnailUrl,
                        onTap: ()=> locator!<AppRoute>().navigateTo(YoutubeVideoPlayer(videoId: video.id)),
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        Container(
          padding:EdgeInsets.symmetric(horizontal: 29),
          child: Column(
            children: [
              SizedBox(height: 20),
              SliderHeader(
                title: "Articles",
                action: () => locator!<AppRoute>().navigateTo(Articles()), keyString: 'Articles',
              ),
              SizedBox(height:18),
            ],
          ),
        ),
        LimitedBox(
          maxHeight: MediaQuery.of(context).size.height/3.8,
          child: BlocBuilder<ArticleBloc,ArticleState>(
            buildWhen: (previous,current)=> previous!= current,
            builder: (context, state) {
              return  state.maybeWhen(
                  loading: ()=> LoadingListWidget(),
                  idle: ()=> LoadingListWidget(),
                  getFeedDone: (WelcomeJson data)=> ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left:20, bottom: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.rss.channel.item.length > 5 ? 5 : data.rss.channel.item.length,
                      itemBuilder: (context, index) {
                        final giraffe = data.rss.channel.item[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 14.0,left: 4,bottom: 3, top: 2),
                          child: ArticleCard(itemData: giraffe,page: false),
                        );
                      }),
                  orElse:()=> LoadingListWidget()
              );
            },
          ),
        ),
    ]);
  }
}