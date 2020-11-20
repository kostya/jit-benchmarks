find . -maxdepth 1 -type d \( ! -name \. \) -not -path "./tools" -not -path "./.git" -exec bash -c "cd '{}' && ruby run.rb" \;
