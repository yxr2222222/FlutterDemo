import 'package:flutter/material.dart';
import 'package:yxr_flutter_basic/base/config/ColorConfig.dart';
import 'package:yxr_flutter_basic/base/model/controller/SimpleGetxController.dart';
import 'package:yxr_flutter_basic/base/style/SimpleBorderRadius.dart';
import 'package:yxr_flutter_basic/base/style/SimpleTextStyle.dart';
import 'package:yxr_flutter_basic/base/ui/decoration/SimpleShapeDecoration.dart';
import 'package:yxr_flutter_basic/base/ui/page/BaseMultiStatePage.dart';
import 'package:yxr_flutter_basic/base/ui/widget/SimpleWidget.dart';
import 'package:yxr_flutter_basic/base/util/EncrypterUtil.dart';
import 'package:yxr_flutter_basic/base/util/GetBuilderUtil.dart';
import 'package:yxr_flutter_basic/base/vm/BaseMultiVM.dart';

class EncryptPage extends BaseMultiPage {
  EncryptPage({super.key});

  @override
  State<BaseMultiPage> createState() => _EncryptState();
}

class _EncryptState extends BaseMultiPageState<_EncryptVM, EncryptPage> {
  @override
  Widget createMultiContentWidget(BuildContext context, _EncryptVM viewModel) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildEncryptWidget(),
          const Divider(
            color: ColorConfig.red_fb2929,
            height: 1,
          ),
          _buildDecryptWidget()
        ],
      ),
    );
  }

  @override
  _EncryptVM createViewModel() => _EncryptVM();

  /// 构建加密组件
  Widget _buildEncryptWidget() => Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "加密前: ${viewModel.oData}",
            style: const SimpleTextStyle.normal_18(),
          ),
          const Padding(padding: EdgeInsets.only(top: 24)),
          GetBuilderUtil.builder(
              (controller) => Text(
                    "加密后内容: ${controller.data}",
                    style: const SimpleTextStyle.bold_20(
                        color: ColorConfig.red_fb2929),
                  ),
              init: viewModel.eData),
          SimpleWidget(
            onTap: () {
              /// 此处仅展示AES加密
              var aesEncrypt =
                  EncrypterUtil.aesEncrypt(viewModel.aesKey, viewModel.oData);
              viewModel.eData.data = aesEncrypt;
            },
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
            decoration: SimpleShapeDecoration(
              color: ColorConfig.blue_007aff,
              radius: SimpleBorderRadius.radius32(),
            ),
            child: const Text(
              "加 密",
              style: SimpleTextStyle.bold_18(color: Colors.white),
            ),
          )
        ],
      ));

  /// 构建解密组件
  Widget _buildDecryptWidget() => Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GetBuilderUtil.builder(
              (controller) => Text(
                    "解密后内容: ${controller.data}",
                    style: const SimpleTextStyle.bold_20(
                        color: ColorConfig.red_fb2929),
                  ),
              init: viewModel.dData),
          SimpleWidget(
            onTap: () {
              /// 此处仅展示AES解密
              var data = viewModel.eData.data;
              if (data == null) {
                showToast("没有加密内容，请先进行加密");
              } else {
                var aesDecrypt =
                    EncrypterUtil.aesDecrypt(viewModel.aesKey, data);
                viewModel.dData.data = aesDecrypt;
              }
            },
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
            decoration: SimpleShapeDecoration(
              color: ColorConfig.blue_007aff,
              radius: SimpleBorderRadius.radius32(),
            ),
            child: const Text(
              "解 密",
              style: SimpleTextStyle.bold_18(color: Colors.white),
            ),
          )
        ],
      ));
}

class _EncryptVM extends BaseMultiVM {
  final String oData = "我曾经跨过山和大海";
  final SimpleGetxController<String> eData = SimpleGetxController();
  final SimpleGetxController<String> dData = SimpleGetxController();
  final aesKey = EncrypterUtil.getAesKey();

  @override
  void onCreate() {
    super.onCreate();
    appbarController.appbarTitle = "RSA/AES加/解密";
  }
}
