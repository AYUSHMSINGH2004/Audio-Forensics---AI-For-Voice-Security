#!/bin/bash

# 1. Define your bucket and the new target folder
BUCKET_NAME="mozilla-voice-data-lake-2026"
DEST_FOLDER="real voice"

# 2. Define the languages and their fresh links
declare -A languages=(
    ["english"]="https://72ae03f85def1ef3381e3d99f8c68750.eu.r2.cloudflarestorage.com/mdc-uploads-prod/uploads/cmfh0j9o10006ns07jq45h7xk/1774750990364-cv-corpus-25.0-2026-03-09-en.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0d5d31845e57b6348e50419f408895bb%2F20260428%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260428T095918Z&X-Amz-Expires=43200&X-Amz-Signature=15b1fa01128aedbcd1ae8fa34af3fc21b34e22f969b8c32db3fa8e82c6697f1a&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
    ["french"]="https://72ae03f85def1ef3381e3d99f8c68750.eu.r2.cloudflarestorage.com/mdc-uploads-prod/uploads/cmfh0j9o10006ns07jq45h7xk/1774365702325-cv-corpus-25.0-2026-03-09-fr.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0d5d31845e57b6348e50419f408895bb%2F20260428%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260428T100046Z&X-Amz-Expires=43200&X-Amz-Signature=02c87b90028bd3b5fa40e6fc79a930b44c6243327368a54e3b5b0fe44bbb053f&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
    ["german"]="https://72ae03f85def1ef3381e3d99f8c68750.eu.r2.cloudflarestorage.com/mdc-uploads-prod/uploads/cmfh0j9o10006ns07jq45h7xk/1774305595562-cv-corpus-25.0-2026-03-09-de.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0d5d31845e57b6348e50419f408895bb%2F20260428%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260428T100126Z&X-Amz-Expires=43200&X-Amz-Signature=e844f573b0043621faa6526eb172dce1ec18c06a136a1569bb1dbae2ce5c2228&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
    ["spanish"]="https://72ae03f85def1ef3381e3d99f8c68750.eu.r2.cloudflarestorage.com/mdc-uploads-prod/uploads/cmfh0j9o10006ns07jq45h7xk/1774315441669-cv-corpus-25.0-2026-03-09-es.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0d5d31845e57b6348e50419f408895bb%2F20260428%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260428T100201Z&X-Amz-Expires=43200&X-Amz-Signature=284d7970efdd29ba1ae9241be6e25ca4b7fe5411259d6a3f6d39f152a2958eb8&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
    ["kinyarwanda"]="https://72ae03f85def1ef3381e3d99f8c68750.eu.r2.cloudflarestorage.com/mdc-uploads-prod/uploads/cmfh0j9o10006ns07jq45h7xk/1774326558857-cv-corpus-25.0-2026-03-09-rw.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0d5d31845e57b6348e50419f408895bb%2F20260428%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260428T100239Z&X-Amz-Expires=43200&X-Amz-Signature=9a14591150df8594ca1779527f6d664d4438ae805434bcb17a7a4778702b56ee&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
    ["esperanto"]="https://72ae03f85def1ef3381e3d99f8c68750.eu.r2.cloudflarestorage.com/mdc-uploads-prod/uploads/cmfh0j9o10006ns07jq45h7xk/1774321398521-cv-corpus-25.0-2026-03-09-eo.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0d5d31845e57b6348e50419f408895bb%2F20260428%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260428T100311Z&X-Amz-Expires=43200&X-Amz-Signature=c2bfebd2ea42263f5d8df0a1990bd5a581f869eeec63003e9ce4107d4fa0065b&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
    ["catalan"]="https://72ae03f85def1ef3381e3d99f8c68750.eu.r2.cloudflarestorage.com/mdc-uploads-prod/uploads/cmfh0j9o10006ns07jq45h7xk/1774750990349-cv-corpus-25.0-2026-03-09-ca.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0d5d31845e57b6348e50419f408895bb%2F20260428%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260428T100351Z&X-Amz-Expires=43200&X-Amz-Signature=ac8aeaab695e1d89b2e177e7b83d0a2369afe2e159e5eb9e5caa7611716a99b2&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
    ["chinese"]="https://72ae03f85def1ef3381e3d99f8c68750.eu.r2.cloudflarestorage.com/mdc-uploads-prod/uploads/cmfh0j9o10006ns07jq45h7xk/1774277290669-cv-corpus-25.0-2026-03-09-zh-CN.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0d5d31845e57b6348e50419f408895bb%2F20260428%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260428T100420Z&X-Amz-Expires=43200&X-Amz-Signature=ef6dc6e4f7e2dce085d0b372499aafc019c03c6248ba541d5885134813f02902&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
    ["bengali"]="https://72ae03f85def1ef3381e3d99f8c68750.eu.r2.cloudflarestorage.com/mdc-uploads-prod/uploads/cmfh0j9o10006ns07jq45h7xk/1774282951635-cv-corpus-25.0-2026-03-09-bn.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0d5d31845e57b6348e50419f408895bb%2F20260428%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260428T100451Z&X-Amz-Expires=43200&X-Amz-Signature=177c155bb4e2f7e4b511e0c127c5122ba56bb51325e09e934cbf467a967d94a6&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
    ["pashto"]="https://72ae03f85def1ef3381e3d99f8c68750.eu.r2.cloudflarestorage.com/mdc-uploads-prod/uploads/cmfh0j9o10006ns07jq45h7xk/1774762677539-cv-corpus-25.0-2026-03-09-ps.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0d5d31845e57b6348e50419f408895bb%2F20260428%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260428T100523Z&X-Amz-Expires=43200&X-Amz-Signature=a945c1b45309c92a1b282f03753473f9693cfc67683cec3fbdba31ee4c005849&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
    ["belarusian"]="https://72ae03f85def1ef3381e3d99f8c68750.eu.r2.cloudflarestorage.com/mdc-uploads-prod/uploads/cmfh0j9o10006ns07jq45h7xk/1774314143059-cv-corpus-25.0-2026-03-09-be.tar.gz?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=0d5d31845e57b6348e50419f408895bb%2F20260428%2Fauto%2Fs3%2Faws4_request&X-Amz-Date=20260428T100551Z&X-Amz-Expires=43200&X-Amz-Signature=8e0e1376dae427e17e942b42b73ae95143587a44a2292aa43962910f554b131f&X-Amz-SignedHeaders=host&x-amz-checksum-mode=ENABLED&x-id=GetObject"
)

echo "Starting high-speed parallel downloads..."

# 3. The Multitasking Engine
for lang in "${!languages[@]}"; do
    url="${languages[$lang]}"
    
    # We wrap the commands in parentheses to group them into a single background task
    (
        echo "-> [Started] $lang"
        # -nv (non-verbose) keeps the logs much cleaner when multiple files download at once
        wget -nv -O "${lang}_audio.tar.gz" "$url"
        
        echo "-> [Uploading] $lang..."
        # Notice we added "/$DEST_FOLDER/" to the end of the bucket path
        gcloud storage cp "${lang}_audio.tar.gz" "gs://$BUCKET_NAME/$DEST_FOLDER/"
        
        rm "${lang}_audio.tar.gz"
        echo "-> [Done] $lang is safely stored and local file deleted!"
    ) & # The '&' tells Linux to run this block in the background immediately
    
    # The Queue Manager: Check how many background jobs are currently running
    # If 4 or more are running, wait for at least one to finish before starting the next
    if [[ $(jobs -r -p | wc -l) -ge 4 ]]; then
        wait -n 
    fi
done

# Wait for the very last batch to finish before declaring complete
wait
echo "ALL DOWNLOADS COMPLETE!"