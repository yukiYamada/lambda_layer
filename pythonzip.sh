#!/bin/bash
# Pythonのレイヤー化シェル
# １．./libs/pythonにリソースを作ってインポートする
# 例 （階層ずれると全然つかえん）
#  mkdir -p ./libs/python/requests/python
#  pip install requests -t ./libs/python/requests/python
# 2. このシェルを叩く。叩くとartifactsディレクトリにzip化してくれる
## python lib
(
    source_dir="./libs/python"
    destination_dir="artifacts"
    find "$source_dir" -mindepth 2 -maxdepth 2 -type d -name "python" | while read dir; do
        parent_dir=$(basename "$(dirname "$dir")")
        zip_filename="$destination_dir/$parent_dir.zip"
        echo "dir: $dir"
        echo "parent_dir: $parent_dir"
        echo "zip_filename: $zip_filename"
        echo "Creating ZIP file: $(dirname "$dir")"
        (cd "$(dirname "$dir")" && zip -r "../../../$zip_filename" "./python")
    done
)

#pyjwt
python3.11 -m pip install  'PyJWT' -t ./libs/python/PyJWT/python
python3.11 -m pip install  'cryptography<36' -t ./libs/python/PyJWT/python


