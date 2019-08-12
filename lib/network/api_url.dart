
///
///  API: http://www.wanandroid.com/blog/show/2
///


const baseUrl = "https://www.wanandroid.com/";


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


// X.1 获取公众号列表

// http://wanandroid.com/wxarticle/chapters/json
const String apiWXList = "wxarticle/chapters/";

// X.2/3 查看某个公众号历史数据 / 在某个公众号中搜索历史文章
// http://wanandroid.com/wxarticle/list/405/1/json
const String apiWXListItem = "wxarticle/list/";

