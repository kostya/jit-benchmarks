export JB_OUTPUT_FILE=/src/run_$(date +%Y-%m-%d).log
find . -maxdepth 1 -type d \( ! -name \. \) -not -path "./tools" -not -path "./.git" -exec bash -c "cd '{}' && echo "{}" && ruby run.rb" \;
