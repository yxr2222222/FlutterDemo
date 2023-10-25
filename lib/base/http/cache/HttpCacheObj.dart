class HttpCacheObj {
  final String cacheKey;
  final String cacheValue;
  final int expireTime;
  int updateTime;

  HttpCacheObj(this.cacheKey, this.cacheValue, this.expireTime)
      : updateTime = DateTime.now().millisecondsSinceEpoch;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cacheKey'] = cacheKey;
    data['cacheValue'] = cacheValue;
    data['expireTime'] = expireTime;
    data['updateTime'] = updateTime;
    return data;
  }
}
