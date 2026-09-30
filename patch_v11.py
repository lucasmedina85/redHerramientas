import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("_searchKeywords['somos'] = _quienesSomosKey;", "_searchKeywords['somos'] = _contactoKey;")
content = content.replace("_searchKeywords['actividades'] = _actividadesKey;", "_searchKeywords['actividades'] = _propuestasKey;")
content = content.replace("_searchKeywords['ejes'] = _actividadesKey;", "_searchKeywords['ejes'] = _actividadesKey;")

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
