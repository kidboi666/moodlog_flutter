import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moodlog/core/l10n/app_localizations.dart';
import 'package:moodlog/core/routing/routes.dart';
import 'package:moodlog/domain/use_cases/tag_use_case.dart';
import 'package:moodlog/presentation/tags/tags_view_model.dart';
import 'package:provider/provider.dart';

class TagsScreen extends StatelessWidget {
  const TagsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TagsViewModel(context.read<TagUseCase>()),
      child: const _TagsScreenContent(),
    );
  }
}

class _TagsScreenContent extends StatelessWidget {
  const _TagsScreenContent();

  Future<void> _showAddTagDialog(
      BuildContext context, TagsViewModel viewModel) async {
    final TextEditingController controller = TextEditingController();
    final t = AppLocalizations.of(context)!;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(t.tags_add_new),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(hintText: t.tags_input_hint),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(t.common_confirm_cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(t.common_confirm_ok),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  viewModel.addTag(controller.text);
                  Navigator.of(context).pop();
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
    final viewModel = context.watch<TagsViewModel>();
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.drawer_tags),
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
              onChanged: (value) => viewModel.searchTags(value),
              decoration: InputDecoration(
                labelText: t.tags_filter_title,
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
                      child: Text(t.tags_error(viewModel.error.toString())));
                }
                if (viewModel.tags.isEmpty) {
                  return Center(child: Text(t.tags_empty));
                }
                return ListView.builder(
                  itemCount: viewModel.tags.length,
                  itemBuilder: (context, index) {
                    final tagWithCount = viewModel.tags[index];
                    final tag = tagWithCount.tag;
                    return ListTile(
                      title: Text(tag.name),
                      subtitle: Text(
                        t.tags_journal_count(tagWithCount.count),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () => context.push(Routes.tag(tag.id)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(t.tags_delete_title),
                              content: Text(
                                t.tags_delete_message(tag.name),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text(t.common_confirm_cancel),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text(t.common_confirm_delete),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            viewModel.deleteTag(tag.id);
                          }
                        },
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
