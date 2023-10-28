import 'package:flutter_demo/base/http/cache/CacheMode.dart';
import 'package:flutter_demo/base/http/cache/CacheStrategy.dart';

class CacheConfig {
  final CacheMode defaultCacheMode;
  final int defaultCacheTime;

  CacheConfig(
      {this.defaultCacheMode = CacheMode.ONLY_NETWORK,
      this.defaultCacheTime = CacheStrategy.WEEK});
}
