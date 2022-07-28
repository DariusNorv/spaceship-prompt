#
# Git
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GIT_SHOW="${SPACESHIP_GIT_SHOW=true}"
SPACESHIP_GIT_PREFIX="${SPACESHIP_GIT_PREFIX="on "}"
SPACESHIP_GIT_SUFFIX="${SPACESHIP_GIT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_GIT_TAG="${SPACESHIP_GIT_TAG=""}"
SPACESHIP_GIT_SYMBOL="${SPACESHIP_GIT_SYMBOL=" "}"

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

source "$SPACESHIP_ROOT/sections/git_branch.zsh"
source "$SPACESHIP_ROOT/sections/git_status.zsh"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

function git_last_tag() {
  echo $(git describe --first-parent --tags)
}

# Show both git branch and git status:
#   spaceship_git_branch
#   spaceship_git_status
spaceship_git() {
  [[ $SPACESHIP_GIT_SHOW == false ]] && return

  local 'git_tag'
  local git_branch="$(spaceship_git_branch)" git_status="$(spaceship_git_status)"

  [[ -z $git_branch ]] && return

  git_tag=$(git_last_tag)

  if [[ $git_tag != "" ]]; then
    SPACESHIP_GIT_TAG=" (${git_tag})"
  fi

  spaceship::section \
    'white' \
    "$SPACESHIP_GIT_PREFIX" \
    "${git_branch}${git_status}$SPACESHIP_GIT_TAG" \
    "$SPACESHIP_GIT_SUFFIX"
}
