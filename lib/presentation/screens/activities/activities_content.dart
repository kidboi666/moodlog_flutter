part of 'activities_view.dart';

class _TagsScreenContent extends StatelessWidget {
  const _TagsScreenContent();

  Future<void> _showAddTagDialog(
    BuildContext context,
    ActivitiesViewModel viewModel,
  ) async {
    final TextEditingController controller = TextEditingController();
    final t = AppLocalizations.of(context)!;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(t.activities_add_new),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(hintText: t.activities_input_hint),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(t.common_confirm_cancel),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: Text(t.common_confirm_ok),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  viewModel.addActivity(controller.text);
                  context.pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditActivityDialog(
    BuildContext context,
    ActivitiesViewModel viewModel,
    Activity activity,
  ) async {
    final TextEditingController controller = TextEditingController(
      text: activity.name,
    );
    final t = AppLocalizations.of(context)!;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(t.activities_menu_edit),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(hintText: t.activities_input_hint),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(t.common_confirm_cancel),
              onPressed: () {
                context.pop();
              },
            ),
            TextButton(
              child: Text(t.common_confirm_save),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  viewModel.updateActivity(activity.id, controller.text);
                  context.pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ActivitiesViewModel>();
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.drawer_activities),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddTagDialog(context, viewModel),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => viewModel.searchActivities(value),
              decoration: InputDecoration(
                labelText: t.activities_filter_title,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (viewModel.hasError) {
                  return Center(
                    child: Text(t.activities_error(viewModel.error.toString())),
                  );
                }
                if (viewModel.activities.isEmpty) {
                  return Center(child: Text(t.activities_empty));
                }
                return ListView.builder(
                  itemCount: viewModel.activities.length,
                  itemBuilder: (context, index) {
                    final tagWithCount = viewModel.activities[index];
                    final activity = tagWithCount.activity;
                    return ListTile(
                      title: Text(activity.name),
                      subtitle: Text(
                        t.activities_journal_count(tagWithCount.count),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () => context.push(Routes.activity(activity.id)),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'edit') {
                            _showEditActivityDialog(context, viewModel, activity);
                          } else if (value == 'delete') {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(t.activities_delete_title),
                                content: Text(t.activities_delete_message(activity.name)),
                                actions: [
                                  TextButton(
                                    onPressed: () => context.pop(false),
                                    child: Text(t.common_confirm_cancel),
                                  ),
                                  TextButton(
                                    onPressed: () => context.pop(true),
                                    child: Text(t.common_confirm_delete),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              viewModel.deleteActivity(activity.id);
                            }
                          }
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'edit',
                                child: Text(t.activities_menu_edit),
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: Text(t.activities_menu_delete),
                              ),
                            ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
