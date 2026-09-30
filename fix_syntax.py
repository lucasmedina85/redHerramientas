with open('lib/main.dart', 'r', encoding='utf-8') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    if "https://youtube.com/@reddeherramientasentremujeres?si=X0ZCFkMKebH4L3lk" in line:
        # We need to insert a closing parenthesis right after the Row
        # Let's find the closing of the row and add the padding closing
        for j in range(i, i+10):
            if "]," in lines[j]:
                lines[j+1] = "          ),\n          ),\n"
                break
        break

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.writelines(lines)
