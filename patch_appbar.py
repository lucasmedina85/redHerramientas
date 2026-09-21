import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

new_appbar = """  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      toolbarHeight: 90,
      iconTheme: const IconThemeData(color: AppColors.dominant, size: 36),
      title: Image.network(
        'https://i.imgur.com/CFM0Pcr.png',
        height: 60,
        fit: BoxFit.contain,
        semanticLabel: 'Logo Red de Herramientas',
      ),
      actions: [
        // Buscador Animado
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _isSearchExpanded ? (isDesktop ? 300 : 200) : 50,
            height: 50,
            decoration: BoxDecoration(
              color: _isSearchExpanded ? Colors.grey.shade100 : Colors.transparent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 16,
                  top: 0,
                  bottom: 0,
                  right: 50,
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
                          style: const TextStyle(fontSize: 18, color: AppColors.textMain),
                          onSubmitted: (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Buscando: $value')),
                            );
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
                    iconSize: 28,
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
      ],
    );
  }"""

# Find the _buildAppBar function block and replace it
pattern = r"PreferredSizeWidget _buildAppBar\(BuildContext context\) \{.*?return AppBar\(.*?\);\n  \}"
content = re.sub(pattern, new_appbar, content, flags=re.DOTALL)

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print("done")
