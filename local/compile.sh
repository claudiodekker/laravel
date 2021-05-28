#!/bin/bash
VERSION=8.44+optimized

rm -f build/*.zip
cd framework/src/Illuminate

for file in *
do
    if [[ "$file" == "Foundation" ]]; then
        continue
    fi
    cp "./$file/composer.json" "composer.$file.json"
    sed -i.orig "s/\"description\"\:.*/\"version\"\: \"$VERSION\"\,/" "./$file/composer.json"
    sed -i.orig "s/\"homepage\"\:.*/\"homepage\"\: \"https:\/\/\laravel\.local\"\,/" "./$file/composer.json"
    rm "./$file/composer.json.orig"
    zip -r "../../../build/$file.zip" "$file"
    mv "composer.$file.json" "./$file/composer.json"
done

cd ../../../framework
cp "composer.json" "../composer.framework.json"
sed -i.orig "s/\"description\"\:.*/\"version\"\: \"$VERSION\"\,/" "./composer.json"
rm "./composer.json.orig"
zip -r "../build/framework.zip" "."
mv "../composer.framework.json" "./composer.json"
