import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

desktop_layout_code = """
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeroSection(key: _quienesSomosKey), // Carousel (acts as Quienes somos)
              _buildSeparator(isMobile: false),
              EjesSection(key: _actividadesKey),
              _buildSeparator(isMobile: false),
              PropuestasSection(),
              _buildSeparator(isMobile: false),
              RecursosSection(key: _recursosKey),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 3,
          child: SidebarSection(donateKey: _donateKey), // Donate & Novedades
        ),
      ],
    );
  }
"""

mobile_layout_code = """
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_isSearchExpanded) // If not mobile desktop nav, _inicioKey is here
           Container(key: _inicioKey),
        HeroSection(key: _quienesSomosKey),
        _buildSeparator(isMobile: true),
        EjesSection(key: _actividadesKey),
        _buildSeparator(isMobile: true),
        PropuestasSection(),
        _buildSeparator(isMobile: true),
        RecursosSection(key: _recursosKey),
        const SizedBox(height: 60),
        SidebarSection(donateKey: _donateKey),
      ],
    );
  }
"""

separator_func = """
  Widget _buildSeparator({required bool isMobile}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 30 : 40),
      child: Container(
        height: 6,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFCC6E83),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildFooter(bool isDesktop) {
"""

# Replace desktop
content = re.sub(r'  Widget _buildDesktopLayout\(\) \{.*?\n  \}', desktop_layout_code.strip('\n'), content, flags=re.DOTALL)

# Replace mobile
content = re.sub(r'  Widget _buildMobileLayout\(\) \{.*?\n  \}', mobile_layout_code.strip('\n'), content, flags=re.DOTALL)

# Insert separator func
content = content.replace('  Widget _buildFooter(bool isDesktop) {', separator_func.strip('\n'))

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)

