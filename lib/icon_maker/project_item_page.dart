import 'package:flutter/material.dart';

import 'icon_maker_page.dart';

class ProjectItemEditPage extends StatelessWidget {
  final ProjectItem projectItem;

  final Function(ProjectItem)? projectItemUpdateCallback;
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController projectPathController = TextEditingController();

  ProjectItemEditPage(this.projectItem,
      {this.projectItemUpdateCallback, super.key});

  @override
  Widget build(BuildContext context) {
    projectNameController.text = projectItem.name;
    projectPathController.text = projectItem.path;

    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(projectItem.isEmpty() ? "添加新项目" : "编辑项目")),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          TextField(
                            autofocus: projectItem.isEmpty(),
                            controller: projectNameController,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: '项目名称',
                              hintText: '请输入项目名称',
                            ),
                          ),
                          TextField(
                            controller: projectPathController,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.blue),
                              labelText: '项目路径',
                              hintText: '请输入项目路径',
                            ),
                          ),
                        ],
                      )),
                      Column(
                        children: [
                          Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "取消",
                                    style: TextStyle(color: Colors.black54),
                                  ))),
                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    projectItem.name =
                                        projectNameController.text;
                                    projectItem.path =
                                        projectPathController.text;

                                    if (projectItem.isEmpty()) {
                                      return;
                                    }

                                    projectItemUpdateCallback
                                        ?.call(projectItem);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "保存",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ],
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
