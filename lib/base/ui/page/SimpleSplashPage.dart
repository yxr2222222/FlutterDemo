import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_demo/base/extension/BuildContextExtension.dart';
import 'package:flutter_demo/base/extension/StringExtension.dart';
import 'package:flutter_demo/base/ui/page/BasePage.dart';
import 'package:flutter_demo/base/ui/page/SimpleWebPage.dart';
import 'package:flutter_demo/base/util/StorageUtil.dart';
import 'package:flutter_demo/base/vm/BaseVM.dart';

import '../../config/PublicKeyConfig.dart';
import '../../util/Log.dart';

class SimpleSplashPage extends BasePage<_SimpleSplashVM> {
  final PrivacyContent privacyContent;
  final void Function(BaseVM viewModel, BuildContext context) onPrivacyAgree;
  final String? icon;
  final String? title;
  final Widget? child;

  SimpleSplashPage(
      {super.key,
      required this.privacyContent,
      required this.onPrivacyAgree,
      this.icon,
      this.title,
      this.child})
      : super(viewModel: _SimpleSplashVM());

  @override
  State<StatefulWidget> createState() => _SimpleSplashStat();

  List<String> getKeywordList() {
    List<String> keywordList = [];
    for (var element in privacyContent.keywordUrlList) {
      keywordList.add(element.keyword);
    }
    return keywordList;
  }
}

class _SimpleSplashStat
    extends BasePageState<_SimpleSplashVM, SimpleSplashPage> {
  @override
  Widget createContentWidget(BuildContext context, _SimpleSplashVM viewModel) {
    viewModel.onPrivacyAgree = () {
      widget.onPrivacyAgree(viewModel, context);
    };
    viewModel.onShowPrivacyDialog = () async {
      bool? isNeedFinish = await showCupertinoDialog(
          context: context,
          builder: (BuildContext ctx) {
            return CupertinoAlertDialog(
                content: widget.privacyContent.content.clickableRichText(
                    textColor: const Color(0xff5c5c5c),
                    keywords: widget.getKeywordList(),
                    onTap: (keyword) {
                      var keywordUrl =
                          widget.privacyContent.getKeywordUrl(keyword);
                      if (keywordUrl != null) {
                        ctx.push(SimpleWebPage(
                          url: keywordUrl.url,
                          title: keyword,
                        ));
                      }
                    }),
                actions: [
                  CupertinoDialogAction(
                      child: const Text(
                        "不同意并退出",
                        style:
                            TextStyle(color: Color(0xff999999), fontSize: 14),
                      ),
                      onPressed: () {
                        ctx.pop(result: true);
                      }),
                  CupertinoDialogAction(
                      child: const Text(
                        "同意",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        ctx.pop();
                        await StorageUtil.put(
                            PublicKeyConfig.KEY_IS_AGREE_PRIVACY, true);
                        if (context.mounted) {
                          widget.onPrivacyAgree(viewModel, context);
                        }
                      })
                ]);
          });

      Log.d("isNeedFinish: $isNeedFinish, context.mounted: ${context.mounted}");
      if (isNeedFinish == true && context.mounted) {
        context.pop(cantPopExit: true);
      }
    };
    Widget icon = widget.icon == null
        ? const SizedBox(
            width: 0,
            height: 0,
          )
        : Image.asset(
            widget.icon!,
            width: 128,
            height: 128,
          );

    Widget title = widget.title == null
        ? const SizedBox(
            width: 0,
            height: 0,
          )
        : Container(
            width: double.infinity,
            margin: const EdgeInsets.only(top: 24),
            child: Text(
              widget.title!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color(0xff333333),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ));
    return widget.child != null
        ? widget.child!
        : Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [icon, title]),
          );
  }
}

class _SimpleSplashVM extends BaseVM {
  void Function()? onShowPrivacyDialog;
  void Function()? onPrivacyAgree;

  @override
  Future<bool> onBackPressed() async {
    return false;
  }

  @override
  void onCreate() async {
    super.onCreate();
    var isAgreePrivacy =
        await StorageUtil.get<bool>(PublicKeyConfig.KEY_IS_AGREE_PRIVACY);
    if (isAgreePrivacy == true) {
      _onPrivacyAgree();
    } else if (onShowPrivacyDialog != null) {
      onShowPrivacyDialog!();
    }
  }

  void _onPrivacyAgree() {
    if (onPrivacyAgree != null) {
      onPrivacyAgree!();
    }
  }
}

class PrivacyContent {
  final String content;
  final List<KeywordUrl> keywordUrlList;

  PrivacyContent(this.content, this.keywordUrlList);

  KeywordUrl? getKeywordUrl(String? keyword) {
    for (var element in keywordUrlList) {
      if (element.keyword == keyword) {
        return element;
      }
    }
    return null;
  }
}

class KeywordUrl {
  final String keyword;
  final String url;

  KeywordUrl(this.keyword, this.url);
}
