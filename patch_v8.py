import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Add _propuestasKey to _MyHomePageState
if '_propuestasKey' not in content:
    content = re.sub(r'(final GlobalKey _actividadesKey = GlobalKey\(\);\n)', r'\1  final GlobalKey _propuestasKey = GlobalKey();\n', content)

# Modify Top Nav Navigation
top_nav = """
                    _navItem("Inicio", () => _scrollToKey(_inicioKey)),
                    _navItem("Quiénes somos", () => _scrollToKey(_contactoKey)), 
                    _navItem("Actividades", () => _scrollToKey(_propuestasKey)),
                    _navItem("Recursos", () => _scrollToKey(_recursosKey)),
                    _navItem("Contacto", () => _scrollToKey(_contactoKey)),
"""
content = re.sub(r'                    _navItem\("Inicio".*?_navItem\("Contacto", \(\) => _scrollToKey\(_contactoKey\)\),', top_nav.strip('\n'), content, flags=re.DOTALL)

# Modify Drawer Navigation
drawer_nav = """
          _drawerItem("Inicio", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_inicioKey);
          }),
          _drawerItem("Quiénes Somos", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_contactoKey);
          }),
          _drawerItem("Actividades", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_propuestasKey);
          }),
          _drawerItem("Recursos", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_recursosKey);
          }),
          _drawerItem("Contacto", onTap: () {
            Navigator.pop(context);
            _scrollToKey(_contactoKey);
          }),
"""
content = re.sub(r'          _drawerItem\("Inicio", onTap: \(\) \{.*?\n          \}\),\n          _drawerItem\("Contacto", onTap: \(\) \{.*?\n          \}\),', drawer_nav.strip('\n'), content, flags=re.DOTALL)


# Add key to PropuestasSection definition
content = re.sub(r'class PropuestasSection extends StatelessWidget \{\n  const PropuestasSection\(\{super\.key\}\);', 'class PropuestasSection extends StatelessWidget {\n  const PropuestasSection({super.key});', content)

# Modify Desktop Layout to pass key
desktop_layout = """
              EjesSection(key: _actividadesKey),
              _buildSeparator(isMobile: false),
              PropuestasSection(key: _propuestasKey),
"""
content = re.sub(r'              EjesSection\(key: _actividadesKey\),\n              _buildSeparator\(isMobile: false\),\n              PropuestasSection\(\),', desktop_layout.strip('\n'), content)

# Modify Mobile Layout to pass key
mobile_layout = """
        EjesSection(key: _actividadesKey),
        _buildSeparator(isMobile: true),
        PropuestasSection(key: _propuestasKey),
"""
content = re.sub(r'        EjesSection\(key: _actividadesKey\),\n        _buildSeparator\(isMobile: true\),\n        PropuestasSection\(\),', mobile_layout.strip('\n'), content)


with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
