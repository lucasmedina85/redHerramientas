import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

new_scroll = """
  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        // Obtenemos la posicion global del widget
        final position = box.localToGlobal(Offset.zero).dy;
        // La altura de la pantalla
        final screenHeight = MediaQuery.of(context).size.height;
        // Calculamos el target
        double target = _scrollController.offset + position - 80; // 80 de margen
        
        // No pasarse del inicio ni del final
        target = target.clamp(0.0, _scrollController.position.maxScrollExtent);
        
        _scrollController.animateTo(
          target,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    }
  }
"""

content = re.sub(r'  void _scrollToKey\(GlobalKey key\) \{.*?\n  \}', new_scroll.strip('\n'), content, flags=re.DOTALL)

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
