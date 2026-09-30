import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace('_scrollToKey(_inicioKey)', '_scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut)')

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
