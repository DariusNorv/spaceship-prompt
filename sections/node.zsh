#
# Node.js
#
# Node.js is a JavaScript runtime built on Chrome's V8 JavaScript engine.
# Link: https://nodejs.org/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_NODE_SHOW="${SPACESHIP_NODE_SHOW=true}"
SPACESHIP_NODE_PREFIX="${SPACESHIP_NODE_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_NODE_SUFFIX="${SPACESHIP_NODE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_NODE_SYMBOL="${SPACESHIP_NODE_SYMBOL="⬢ "}"
SPACESHIP_NODE_DEFAULT_VERSION="${SPACESHIP_NODE_DEFAULT_VERSION=""}"
SPACESHIP_NODE_COLOR="${SPACESHIP_NODE_COLOR="green"}"

SPACESHIP_MANAGER_SHOW="${SPACESHIP_MANAGER_SHOW=true}"
SPACESHIP_MANAGER_PREFIX="${SPACESHIP_MANAGER_PREFIX=""}"
SPACESHIP_MANAGER_SUFFIX="${SPACESHIP_MANAGER_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_MANAGER_SYMBOL="${SPACESHIP_MANAGER_SYMBOL="🔨 "}"
SPACESHIP_MANAGER_DEFAULT_VERSION="${SPACESHIP_MANAGER_DEFAULT_VERSION=""}"
SPACESHIP_MANAGER_COLOR="${SPACESHIP_MANAGER_COLOR="cyan"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------
function get_version() {
  local 'node_path'
  node_path=$(which ${1})
  echo ${1}\: $(${node_path} -v 2>/dev/null)
}

# Show current version of node, exception system.
spaceship_node() {
  [[ $SPACESHIP_NODE_SHOW == false ]] && return

  # Show NODE status only for JS-specific folders
  [[ -f package.json || -d node_modules || -n *.js(#qN^/) ]] || return

  local 'node_version'
  local 'package_manager'

  node_version=$(get_version node)

  if spaceship::exists yarn && [[ -f yarn.lock ]]; then
    package_manager=$(get_version yarn)
  else
    package_manager=$(get_version npm)
  fi

  [[ $node_version == $SPACESHIP_NODE_DEFAULT_VERSION ]] && return

  spaceship::section \
    "$SPACESHIP_NODE_COLOR" \
    "$SPACESHIP_NODE_PREFIX" \
    "${SPACESHIP_NODE_SYMBOL}${node_version}" \
    "$SPACESHIP_NODE_SUFFIX"

  spaceship::section \
    "$SPACESHIP_MANAGER_COLOR" \
    "$SPACESHIP_MANAGER_PREFIX" \
    "${SPACESHIP_MANAGER_SYMBOL}${package_manager}" \
    "$SPACESHIP_MANAGER_SUFFIX"
}
