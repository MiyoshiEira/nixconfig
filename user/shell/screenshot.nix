{ pkgs }:

pkgs.writeShellScriptBin "screenshot" ''

key="~/Documents/cdn"
url="~/Documents/upl"
temp_file="/tmp/screenshot.png"

grim -g "$(slurp)" "$temp_file"

if [[ $(file --mime-type -b "$temp_file") != "image/png" ]]; then
	rm "$temp_file"
  notify-send "Screenshot aborted" -a "Grim" && exit 1
fi

response=$(curl -X POST -F "fdata=@"$temp_file -F "token="$key -v "$url" 2>/dev/null)
image_url=$(echo "$response" | jq -r '.url // empty')
if [ -z "$image_url" ]; then
  notify-send "Failed to upload screenshot" -a "Grim"
else
  echo -n "$image_url/raw" | grep -o 'https:\/\/[^"]*' | xclip -sel c
  notify-send "Image URL copied to clipboard" "$image_url" -a "Grim" -i "$temp_file"
fi

rm "$temp_file"

''
