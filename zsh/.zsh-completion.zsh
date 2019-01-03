# Init
autoload -U compinit
compinit -i                   # security checks (otherwise use -u or -C)
                              # default -d to $HOME/.zcompdump
zmodload -i zsh/complist	    # load menu-select

# Settings
setopt auto_menu              # show completion menu on successive tab press
unsetopt menu_complete	      # does not insert the first match immediately and not override auto_menu
setopt complete_in_word	      # if unset, the cursor is set to the end of the word if completion is started.
                                # Otherwise it stays there and completion is done from both ends
setopt always_to_end	        # If a completion is performed with the cursor within a word, and a full completion is inserted,
                                # the cursor is moved to the end of the word. That is, the cursor is moved to the end of the word
                                # if either a single match is inserted or menu completion is performed.

# Styles
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true                                                          # complete . and .. special directories
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Ignore internal zsh functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# History completion
zle -C hist-complete complete-word _generic
zstyle ':completion:hist-complete:*' completer _history

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcompcache                                                    # in ‘$HOME/.zcompcache’ by default

# Display message when no matches are found
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
