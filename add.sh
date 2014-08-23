urls=$@

for url in $urls; do
    folder="bundle/$(echo $url | awk -F '/' '{print $(NF)}')"

    git submodule add $url $folder
done
