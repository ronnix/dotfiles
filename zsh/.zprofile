# Environnement Homebrew (PATH, MANPATH, FPATH, INFOPATH).
#
# À placer dans .zprofile (fichier de login), exécuté APRÈS le
# /etc/zprofile système qui lance path_helper. `brew shellenv` relance
# path_helper enraciné sur $HOMEBREW_PREFIX, ce qui place
# /opt/homebrew/{bin,sbin} AVANT /usr/bin — sinon le git (etc.) fourni
# par macOS masque la version Homebrew.
#
# Ne pas mettre dans .zshenv : path_helper (dans /etc/zprofile) s'exécute
# ensuite et repousserait Homebrew derrière /usr/bin.
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
