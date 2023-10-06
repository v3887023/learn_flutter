import 'package:flutter/material.dart';

import 'project_item_page.dart';

class IconMakerPage extends StatefulWidget {
  const IconMakerPage({super.key});

  @override
  State<IconMakerPage> createState() => _IconMakerPageState();
}

class _IconMakerPageState extends State<IconMakerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: Colors.blue,
            child: const Text("Icon Maker", style: TextStyle(fontSize: 20)),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [LeftPanel(), PreviewPanel(), RightPanel()],
            ),
          )
        ],
      ),
    );
  }
}

class LeftPanel extends StatelessWidget {
  const LeftPanel({super.key});

  @override
  build(BuildContext context) {
    return const SizedBox(
        width: 200,
        child: Column(
          children: [ProjectSectionWidget(), Text("data")],
        ));
  }
}

class ProjectSectionWidget extends StatefulWidget {
  const ProjectSectionWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProjectSectionState();
  }
}

class ProjectSectionState extends State<ProjectSectionWidget> {
  List<ProjectItem> projectItems = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    projectItems.add(ProjectItem("足球大师"));
    projectItems.add(ProjectItem("篮球大师"));
    projectItems.add(ProjectItem("最佳 11 人"));
    projectItems.add(ProjectItem("最佳球会"));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "项目",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () {
                  _Utils.showProjectItemDialog(context, editable: true,
                      projectItemUpdateCallback: (ProjectItem projectItem) {
                    setState(() {
                      projectItems.add(projectItem);
                    });
                  });
                },
                child:
                    const Text("添加新项目", style: TextStyle(color: Colors.blue)))
          ])),
      Container(
        color: Colors.grey[800],
        child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            child: SingleChildScrollView(
              controller: scrollController,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                    itemCount: projectItems.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              for (var element in projectItems) {
                                element.selected = false;
                              }
                              projectItems[index].selected = true;
                            });
                          },
                          child: ProjectItemWidget(projectItems, index));
                    }),
              ),
            )),
      ),
    ]);
  }
}

class ProjectItemWidget extends StatefulWidget {
  final List<ProjectItem> projectItems;
  final int index;

  const ProjectItemWidget(this.projectItems, this.index, {super.key});

  @override
  State<ProjectItemWidget> createState() => _ProjectItemWidgetState();
}

class _ProjectItemWidgetState extends State<ProjectItemWidget> {
  @override
  Widget build(BuildContext context) {
    var projectItem = widget.projectItems[widget.index];
    return Container(
      color: projectItem.selected ? Colors.blue : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(projectItem.name),
          ),
          Row(
            children: [
              Visibility(
                  visible: projectItem.selected,
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: MaterialButton(
                        onPressed: () {
                          _Utils.showProjectItemDialog(context,
                              projectItem: projectItem,
                              editable: true, projectItemUpdateCallback:
                                  (ProjectItem projectItem) {
                            setState(() {
                              widget.projectItems.add(projectItem);
                            });
                          });
                        },
                        child: const Icon(Icons.edit_outlined, size: 15)),
                  )),
              SizedBox(
                width: 30,
                height: 30,
                child: MaterialButton(
                    onPressed: () {
                      _Utils.showProjectItemDialog(context,
                          projectItem: projectItem, editable: false);
                    },
                    child: const Icon(Icons.info_outline, size: 15)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class PreviewPanel extends StatelessWidget {
  const PreviewPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container());
  }
}

class RightPanel extends StatelessWidget {
  const RightPanel({super.key});

  @override
  build(BuildContext context) {
    return Container(
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.grey[800]),
        child: const Column(
          children: [
            Text("Right Panel"),
          ],
        ));
  }
}

class ProjectItem {
  String name;
  String path;
  bool selected = false;

  ProjectItem(this.name, {this.path = ""});

  bool isEmpty() {
    return name.isEmpty;
  }
}

class _Utils {
  static void showProjectItemDialog(BuildContext context,
      {ProjectItem? projectItem,
      bool editable = false,
      Function(ProjectItem)? projectItemUpdateCallback}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "Dialog",
        transitionBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, _, __) {
          return Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ProjectItemEditPage(projectItem ?? ProjectItem(""),
                  projectItemUpdateCallback: projectItemUpdateCallback),
            ),
          );
        });
  }
}