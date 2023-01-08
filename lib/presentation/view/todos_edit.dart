import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shortid/shortid.dart';

import '../../domain/model/todo.dart';
import '../viewmodel/module.dart';
import '../widgets/extensions.dart';

class TodosEdit extends ConsumerStatefulWidget {
  const TodosEdit({super.key, this.todoId});
  final String? todoId;

  @override
  ConsumerState<TodosEdit> createState() => _TodosEditState();
}

class _TodosEditState extends ConsumerState<TodosEdit> {
  final _formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final description = TextEditingController();
  late final model = ref.read(todosListModel);
  bool isCompleted = false;
  bool edited = false;

  void change() {
    if (mounted) {
      setState(() {
        edited = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    title.addListener(change);
    description.addListener(change);
    if (widget.todoId != null) {
      model.get(widget.todoId!).then((value) {
        if (value != null) {
          title.text = value.title;
          description.text = value.description ?? '';
          if (mounted) {
            setState(() {
              isCompleted = value.completed;
              edited = false;
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.todoId == null
            ? const Text('New Todo')
            : const Text('Edit Todo'),
        actions: [
          // Delete todo
          if (widget.todoId != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final router = GoRouter.of(context);
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete todo?'),
                    content: const Text(
                      'Are you sure you want to delete this todo?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
                if (confirmed == true) {
                  model.delete(widget.todoId!);
                  if (router.canPop()) router.pop();
                }
              },
            ),
        ],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            onWillPop: () async {
              if (edited) {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Discard changes?'),
                    content: const Text(
                      'Are you sure you want to discard your changes?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
                if (confirmed == true) return true;
                return false;
              }
              return true;
            },
            child: Column(
              children: [
                TextFormField(
                  controller: title,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                CheckboxListTile(
                  title: const Text('Completed'),
                  value: isCompleted,
                  onChanged: (value) {
                    if (mounted) {
                      setState(() {
                        isCompleted = value!;
                        edited = true;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Save'),
        icon: const Icon(Icons.save),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            final todo = Todo(
              id: widget.todoId ?? shortid.generate(),
              title: title.text,
              description: description.text,
              completed: isCompleted,
            );

            final messenger = ScaffoldMessenger.of(context);
            final router = GoRouter.of(context);
            await model.save(todo);
            messenger.toast('Todo saved!');
            if (router.canPop()) router.pop();
          }
        },
      ),
    );
  }
}
