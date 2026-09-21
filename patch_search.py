import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

state_vars = """class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _donateKey = GlobalKey();
  
  bool _isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();"""

content = content.replace("class _LandingPageState extends State<LandingPage> {\n  final ScrollController _scrollController = ScrollController();\n  final GlobalKey _donateKey = GlobalKey();", state_vars)

actions_code = """        actions: [
          if (isDesktop) ...[
            TextButton(onPressed: _scrollToTop, child: const Text("Inicio", style: TextStyle(fontSize: 18, color: AppColors.textMain, fontWeight: FontWeight.bold))),
            const SizedBox(width: 20),
            TextButton(onPressed: _scrollToDonate, child: const Text("Donar", style: TextStyle(fontSize: 18, color: AppColors.textMain, fontWeight: FontWeight.bold))),
            const SizedBox(width: 10),
          ],
          // Buscador Animado
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _isSearchExpanded ? (isDesktop ? 300 : 200) : 48,
              height: 48,
              decoration: BoxDecoration(
                color: _isSearchExpanded ? Colors.grey.shade100 : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 0,
                    bottom: 0,
                    right: 48,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _isSearchExpanded ? 1.0 : 0.0,
                      child: IgnorePointer(
                        ignoring: !_isSearchExpanded,
                        child: Center(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: 'Buscar...',
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            style: const TextStyle(fontSize: 16, color: AppColors.textMain),
                            onSubmitted: (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Buscando: $value')),
                              );
                              // Aquí conectarás tu lógica de búsqueda real
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: Icon(_isSearchExpanded ? Icons.close : Icons.search),
                      color: AppColors.dominant,
                      splashRadius: 24,
                      onPressed: () {
                        setState(() {
                          _isSearchExpanded = !_isSearchExpanded;
                          if (!_isSearchExpanded) {
                            _searchController.clear();
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isDesktop) const SizedBox(width: 20),
        ],"""

# Find the actions block
import re
pattern = r"actions:\s*isDesktop\s*\?\s*\[(.*?)\]\s*:\s*null,"
content = re.sub(pattern, actions_code, content, flags=re.DOTALL)

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print("done")
