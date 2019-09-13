class PagedDto<T>{

  int totalCount;

  List<T> items=new List<T>();

  PagedDto({this.totalCount,this.items});

}