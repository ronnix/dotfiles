# Environnement Homebrew (PATH, MANPATH, INFOPATH, variables HOMEBREW_*).
#
# Sourcé par .bash_profile (shell de login), APRÈS le path_helper lancé
# par /etc/profile. `brew shellenv` relance path_helper enraciné sur
# $HOMEBREW_PREFIX et place /opt/homebrew/{bin,sbin} AVANT /usr/bin —
# sinon le git (etc.) fourni par macOS masque la version Homebrew.
# Équivalent bash de zsh/.zprofile.
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
