install_deno_mac_linux() {
  echo "Installing for Mac/Linux"
  curl -fsSL https://deno.land/x/install/install.sh | sh
}

install_deno_windows() {
  echo "Installing for Windows"
  irm https://deno.land/install.ps1 | iex
}

check_os() {
  case "$OSTYPE" in
    linux*)   install_deno_mac_linux;;
    darwin*)  install_deno_mac_linux;;
    win*)     install_deno_windows;;
    msys*)    echo "Not Supported: MSYS / MinGW / Git Bash" ;;
    cygwin*)  echo "Not Supported: Cygwin" ;;
    bsd*)     echo "Not Supported: BSD" ;;
    solaris*) echo "Not Supported: Solaris" ;;
    *)        echo "Unknown Operating System: $OSTYPE"; exit 0;;
  esac
}

# check if deno is installed
is_deno_installed() {
  if ! command -v deno &> /dev/null
  then
      read -r -p "Deno is not installed. Can I install it for you? (Y/N): " answer
      case $answer in
        [Yy]* ) check_os;;
        [Nn]* ) exit;;
        * ) echo "Please answer Y or N.";;
      esac
  fi
}

pick_an_environment() {

  PS3="Where is the app running?: "
  # add any other introspection urls to this List
  options=(https://localhost:3000/graphql)
  select url in "${options[@]}";
  do
    echo ""
    # gen the base collection
    deno run --allow-net --allow-read --allow-write https://deno.land/x/graphman@v1.2.1/src/cli.ts "$url" --out="out/temp_collection.json"
    # merge prerequest_auth.json
    jq -s '.[0] * .[1]' out/temp_collection.json src/prerequest-auth.json > out/postman_collection.json
    rm out/temp_collection.json
    # adjust output for environment switching
    python src/url_replacer.py
    echo "All set!"
    exit
  done
}

pick_an_environment