
import 'package:atlan_wan_android_flutter/network/api_requester.dart';
import 'package:atlan_wan_android_flutter/network/entity/project_bean.dart';
import 'package:atlan_wan_android_flutter/util/constants.dart';
import 'package:atlan_wan_android_flutter/util/keep_alive_state.dart';
import 'package:atlan_wan_android_flutter/widget/empty_holder.dart';
import 'package:flutter/material.dart';

class ProjectListPage extends StatefulWidget {

  @override
  _ProjectListPageState createState() => _ProjectListPageState();

}

class _ProjectListPageState extends KeepAliveState<ProjectListPage> with TickerProviderStateMixin {

  TabController _tabController;

  var _projectData = <ProjectBean>[];

  @override
  void initState() {
    super.initState();
    _requestProjectData();
  }

  void _requestProjectData() async {
    List<ProjectBean> data = await ApiRequester.getProject();
    print(data);
    if (data != null && data.length > 0) {
      setState(() {
        _projectData = data;
        _tabController = TabController(length: _projectData.length, vsync: this);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = List.generate(_projectData.length, (int index) => Tab(text: _projectData[index].name));
    return Scaffold(
      appBar: _tabController == null ? null : PreferredSize(
        preferredSize: Size.fromHeight(35.0),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black38,
            indicatorWeight: 1.0,
            indicatorColor: appIconColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: appIconColor,
            controller: _tabController,
            tabs: tabs,
          ),
        ),
      ),
      body: _tabController == null ? EmptyHolder() : TabBarView(
        controller: _tabController,
        children: tabs.map((Tab tab) {
          return Center(child: Text(tab.text));
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

}
