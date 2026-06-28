#!/bin/bash

# 1. Define your bucket and the new target folder
BUCKET_NAME="mozilla-voice-data-lake-2026"
DEST_FOLDER="real voice"

# 2. Define the languages and their fresh links

# For fresh links , Navigate to the Mozilla Data Collective and get the links for each of the respective languages , start the download and terminate it immediately then navigate to your browser downloads section, copy and paste the link here. 
declare -A languages=(
    ["english"]="Paste fresh link here"
    ["french"]="Paste fresh link here"
    ["german"]="Paste fresh link here"
    ["spanish"]="Paste fresh link here"
    ["kinyarwanda"]="Paste fresh link here"
    ["esperanto"]="Paste fresh link here"
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
