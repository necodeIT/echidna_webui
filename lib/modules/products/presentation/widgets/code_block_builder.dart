import 'package:echidna_webui/modules/app/app.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlighting/flutter_highlighting.dart';
import 'package:flutter_highlighting/themes/github-dark.dart';
import 'package:flutter_highlighting/themes/github.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlighting/highlighting.dart';
import 'package:markdown/markdown.dart' hide Text, Node;
import 'package:shadcn_flutter/shadcn_flutter.dart' hide Element;

/// Markdown builder for code blocks.
class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfterWithContext(BuildContext context, Element element, TextStyle? preferredStyle, TextStyle? parentStyle) {
    final language = element.attributes['class']?.split('-').last ?? '';
    final code = element.textContent;

    return _CodeBlock(
      language: language,
      code: code,
      showToast: createShowToastHandler(context),
    );
  }
}

class _CodeBlock extends ToastConsumer {
  const _CodeBlock({required super.showToast, required this.language, required this.code});

  final String language;
  final String code;

  @override
  State<_CodeBlock> createState() => __CodeBlockState();
}

class __CodeBlockState extends State<_CodeBlock> {
  final focusNode = FocusNode();

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.code));
    showIconToast(
      title: 'Copied to clipboard',
      subtitle: 'Codesnippet has been copied to clipboard!',
      icon: BootstrapIcons.clipboard2CheckFill,
    );
  }

  /// copied from [HighlightView._convert]
  List<TextSpan> _convert(List<Node> nodes, Map<String, TextStyle> theme) {
    final spans = <TextSpan>[];
    var currentSpans = spans;
    final stack = <List<TextSpan>>[];

    void _traverse(Node node) {
      if (node.value != null) {
        currentSpans.add(node.className == null ? TextSpan(text: node.value) : TextSpan(text: node.value, style: theme[node.className]));
      } else {
        final tmp = <TextSpan>[];
        currentSpans.add(TextSpan(children: tmp, style: theme[node.className]));
        stack.add(currentSpans);
        currentSpans = tmp;

        for (final n in node.children) {
          _traverse(n);
          if (n == node.children.last) {
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
          }
        }
      }
    }

    for (final node in nodes) {
      _traverse(node);
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.code.contains('\n')) {
      return SecondaryBadge(
        onPressed: _copy,
        child: Text(widget.code),
      );
    }

    final theme = Map.of(context.theme.brightness == Brightness.light ? githubTheme : githubDarkTheme);

    theme['root'] = TextStyle(
      color: theme['root']!.color,
      backgroundColor: context.theme.colorScheme.card,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.card,
        border: Border.all(color: context.theme.colorScheme.border),
        borderRadius: BorderRadius.circular(context.theme.radiusMd),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton.ghost(
              icon: const Icon(BootstrapIcons.clipboard2),
              onPressed: _copy,
            ),
          ),
          SelectableText.rich(
            TextSpan(
              children: _convert(
                // ignore: invalid_use_of_internal_member
                highlight.highlight(widget.language, widget.code.trim(), true).nodes ?? [],
                theme,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
