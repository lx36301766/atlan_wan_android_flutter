
///
///  API: http://www.wanandroid.com/blog/show/2
///


const baseUrl = "https://www.wanandroid.com/";


// X.1 获取公众号列表

// http://wanandroid.com/wxarticle/chapters/json
const String apiWXList = "wxarticle/chapters/";

// X.2/3 查看某个公众号历史数据 / 在某个公众号中搜索历史文章
// http://wanandroid.com/wxarticle/list/405/1/json
const String apiWXListItem = "wxarticle/list/";




// 最新项目tab (首页的第二个tab)
// https://wanandroid.com/article/listproject/0/json
const String apiListProject = "article/listproject/";



// 1.1 首页文章列表
// http://www.wanandroid.com/article/list/0/json
const String apiHomeList = "article/list/";

// 1.2 首页banner
// http://www.wanandroid.com/banner/json
const String apiHomeBanner = "banner";

// 1.3 常用网站
// http://www.wanandroid.com/friend/json
const String apiCommonWebsite = "friend";

// 1.4 搜索热词
// http://www.wanandroid.com/hotkey/json
const String apiSearchHotKey = "hotkey";

// 1.5 置顶文章
// https://www.wanandroid.com/article/top/json
const String apiArticleTop = "article/top";




// 2.1 体系数据
// http://www.wanandroid.com/tree/json
const String apiKnowledgeSystem = "tree";

// 2.2 知识体系下的文章
// http://www.wanandroid.com/article/list/0/json?cid=60
const String apiKnowledgeSystemChildren = "article/list/";



// 3.1 导航数据
// http://www.wanandroid.com/navi/json
const String apiNavigation = "navi";



// 4.1 项目分类
// http://www.wanandroid.com/project/tree/json
const String apiProject = "project/tree";

// 4.2 项目列表数据
// http://www.wanandroid.com/project/list/1/json?cid=294
const String apiProjectList = "project/list/";



// 5.1 登录 - POST（username，password）
// https://www.wanandroid.com/user/login
const String apiLogin = "user/login";

// 5.2 注册 - POST（username，password，repassword）
// https://www.wanandroid.com/user/register
const String apiRegister = "user/register";

// 5.3 退出
// https://www.wanandroid.com/user/logout/json
const String apiLogout = "user/logout";



// 6.1 收藏文章列表
// https://www.wanandroid.com/lg/collect/list/0/json
const String apiGetCollect = "lg/collect/list/";

// 6.2 收藏站内文章 - POST
// https://www.wanandroid.com/lg/collect/1165/json
const String apiAddCollectInside = "lg/collect/";

// 6.3 收藏站外文章 - POST (title，author，link)
// https://www.wanandroid.com/lg/collect/add/json
const String apiAddCollectOutside = "lg/collect/add/json";

// 6.4.1 取消收藏-文章列表 - POST (id:拼在链接上)
// https://www.wanandroid.com/lg/uncollect_originId/2333/json
const String apiDeleteCollect = "lg/uncollect_originId/";

// 6.4.2 取消收藏-我的收藏页面（该页面包含自己录入的内容）- POST (id:拼在链接上， originId)
// https://www.wanandroid.com/lg/uncollect/2805/json
const String apiDeleteCollect2 = "lg/uncollect/";


// 6.5 收藏网站列表
// https://www.wanandroid.com/lg/collect/usertools/json
const String apiGetCollectWebsite = "lg/collect/usertools";

// 6.6 收藏网址 - POST (name,link)
// https://www.wanandroid.com/lg/collect/addtool/json
const String apiAddCollectWebsite = "lg/collect/addtool";

// 6.7 编辑收藏网站 - POST (id,name,link)
// https://www.wanandroid.com/lg/collect/updatetool/json
const String apiUpdateCollectWebsite = "lg/collect/updatetool";

// 6.8 删除收藏网站 - POST (id)
// https://www.wanandroid.com/lg/collect/deletetool/json
const String apiDeleteCollectWebsite = "lg/collect/deletetool";



// 7.1 搜索



// 8.1 TODO工具



// 9.1 积分排行榜接口
const String apiGetPointLeaderboardList = "coin/rank/";

// 9.2 获取个人积分，需要登录后访问
const String apiGetUserPoint = "lg/coin/userinfo";

// 9.1 获取个人积分获取列表，需要登录后访问
const String apiGetUserPointGetList = "lg/coin/list/";


