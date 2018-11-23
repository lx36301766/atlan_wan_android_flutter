

class HomeListResp2 {

  int curPage;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  List datas;

  HomeListResp2(this.curPage, this.offset, this.over, this.pageCount, this.size, this.total);

  factory HomeListResp2.fromJson(Map<String, dynamic> json) => HomeListResp2(
      json['curPage'] as int,
      json['offset'] as int,
      json['over'] as bool,
      json['pageCount'] as int,
      json['size'] as int,
      json['total'] as int,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'curPage': curPage,
    'offset': offset,
    'over': over,
    'pageCount': pageCount,
    'size': size,
    'total': total,
  };

  @override
  String toString() {
    return 'HomeListResp2{curPage: $curPage, offset: $offset, over: $over, pageCount: $pageCount, size: $size, total: $total, datas: $datas}';
  }


}
