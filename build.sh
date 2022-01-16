echo 'build fasta'
cd fasta && sh build.sh && cd -
find . -maxdepth 1 -type d \( ! -name \. \) -not -path "./tools" -not -path "./build" -not -path "./fasta" -not -path "./.git" -not -path "./.mypy_cache" -exec bash -c "echo 'build {}' && cd '{}' && sh build.sh" \;
