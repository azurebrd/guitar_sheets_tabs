#!/bin/bash

output="index.html"
script="$(basename "$0")"

cat > "$output" <<'EOF'
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>File Index</title>
<style>
body {
    font-family: sans-serif;
    margin: 2em;
}
li {
    margin: 0.4em 0;
}
</style>
</head>
<body>
<h1>Files</h1>
<ul>
EOF

for file in *; do
    # Skip the generated index and this script
    [ "$file" = "$output" ] && continue
    [ "$file" = "$script" ] && continue

    # Only include regular files
    [ -f "$file" ] || continue

    echo "  <li><a href=\"$(printf '%s' "$file" | sed 's/ /%20/g')\">$file</a></li>" >> "$output"
done

cat >> "$output" <<'EOF'
</ul>
</body>
</html>
EOF

echo "Created $output"
