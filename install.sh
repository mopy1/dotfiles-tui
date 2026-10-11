#!/usr/bin/env bash
# ==============================================================================
# Dotfiles Installer & Terminal Suite Bootstrap
# Autor: lmc
# Entorno: Neovim (LazyVim + Plugins) + Tmux + TUI Tools (Lazygit, Vi-SQL, Leaf)
# ==============================================================================

set -e

# Colores para salida limpia
GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_BIN="$HOME/.local/bin"
LOCAL_LIB="$HOME/.local/lib"
FONTS_DIR="$HOME/.local/share/fonts/NerdFonts"

info() { echo -e "${BLUE}ℹ️  $*${RESET}"; }
success() { echo -e "${GREEN}✅ $*${RESET}"; }
warn() { echo -e "${YELLOW}⚠️  $*${RESET}"; }
error() { echo -e "${RED}❌ $*${RESET}"; exit 1; }

echo -e "${GREEN}====================================================${RESET}"
echo -e "${GREEN}  🚀 Instalador de Entorno de Terminal & Dotfiles   ${RESET}"
echo -e "${GREEN}====================================================${RESET}"

# 1. Crear directorios base
mkdir -p "$LOCAL_BIN" "$LOCAL_LIB" "$FONTS_DIR" "$HOME/.config"

# Asegurar PATH en ~/.bashrc
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    info "Añadiendo ~/.local/bin al PATH en ~/.bashrc..."
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi
export PATH="$LOCAL_BIN:$PATH"

# 2. Paquetes indispensables del sistema (Debian / Ubuntu / Kali)
info "Actualizando repositorios e instalando dependencias base..."
if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update -y
    sudo apt-get install -y \
        git curl wget tar unzip fontconfig \
        build-essential ripgrep fd-find fzf tmux
    
    # Crear symlink fd -> fdfind si es necesario en Debian/Ubuntu
    if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
        ln -sf "$(which fdfind)" "$LOCAL_BIN/fd"
    fi
else
    warn "Gestor 'apt-get' no detectado. Asegúrate de tener instalados: git, curl, tar, unzip, ripgrep, fd, tmux y build-essential."
fi

# 3. JetBrains Mono Nerd Font (para iconos en Neovim, LazyVim y Tmux)
if ! fc-list : family | grep -qi "JetBrainsMono Nerd Font"; then
    info "Descargando e instalando JetBrains Mono Nerd Font..."
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
    TMP_FONT="/tmp/JetBrainsMono.tar.xz"
    curl -fLo "$TMP_FONT" "$FONT_URL"
    tar -xf "$TMP_FONT" -C "$FONTS_DIR"
    rm -f "$TMP_FONT"
    fc-cache -fv >/dev/null 2>&1
    success "JetBrains Mono Nerd Font instalada con éxito."
else
    success "JetBrains Mono Nerd Font ya presente."
fi

# 4. Neovim 0.10+ (versión moderna para plugins y sqmeow)
NVIM_CURRENT_VER="$(nvim --version 2>/dev/null | head -n1 | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' || echo 'v0.0.0')"
if [[ "$NVIM_CURRENT_VER" < "v0.10.0" ]]; then
    info "Instalando Neovim v0.10.4..."
    NVIM_URL="https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz"
    TMP_NVIM="/tmp/nvim-linux-x86_64.tar.gz"
    curl -fLo "$TMP_NVIM" "$NVIM_URL"
    rm -rf "$LOCAL_LIB/nvim-linux-x86_64"
    tar -xzf "$TMP_NVIM" -C "$LOCAL_LIB"
    rm -f "$TMP_NVIM"
    ln -sf "$LOCAL_LIB/nvim-linux-x86_64/bin/nvim" "$LOCAL_BIN/nvim"
    success "Neovim $(nvim --version | head -n1) instalado en $LOCAL_BIN/nvim."
else
    success "Neovim ya está en versión moderna ($NVIM_CURRENT_VER)."
fi

# 5. Lazygit
if ! command -v lazygit >/dev/null 2>&1; then
    info "Instalando Lazygit..."
    LAZYGIT_VER="$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')"
    if [ -n "$LAZYGIT_VER" ]; then
        curl -fLo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VER}/lazygit_${LAZYGIT_VER}_Linux_x86_64.tar.gz"
        tar -xzf /tmp/lazygit.tar.gz -C "$LOCAL_BIN" lazygit
        rm -f /tmp/lazygit.tar.gz
        chmod +x "$LOCAL_BIN/lazygit"
        success "Lazygit v$LAZYGIT_VER instalado."
    else
        warn "No se pudo obtener la última versión de Lazygit automáticamente."
    fi
else
    success "Lazygit ya instalado."
fi

# 6. Lazydocker (Cliente TUI para Docker, sin instalar el demonio)
if ! command -v lazydocker >/dev/null 2>&1; then
    info "Instalando Lazydocker..."
    LAZYDOCKER_VER="$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')"
    if [ -n "$LAZYDOCKER_VER" ]; then
        curl -fLo /tmp/lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/download/v${LAZYDOCKER_VER}/lazydocker_${LAZYDOCKER_VER}_Linux_x86_64.tar.gz"
        tar -xzf /tmp/lazydocker.tar.gz -C "$LOCAL_BIN" lazydocker
        rm -f /tmp/lazydocker.tar.gz
        chmod +x "$LOCAL_BIN/lazydocker"
        success "Lazydocker v$LAZYDOCKER_VER instalado."
    else
        warn "No se pudo obtener la última versión de Lazydocker."
    fi
else
    success "Lazydocker ya instalado."
fi

# 7. Vi-SQL (Cliente TUI para PostgreSQL / MySQL / SQLite)
if ! command -v vi-sql >/dev/null 2>&1; then
    info "Instalando Vi-SQL..."
    VISQL_VER="$(curl -s "https://api.github.com/repos/kopecmaciej/vi-sql/releases/latest" | grep -Po '"tag_name": "\K[^"]*')"
    if [ -n "$VISQL_VER" ]; then
        curl -fLo /tmp/vi-sql.tar.gz "https://github.com/kopecmaciej/vi-sql/releases/download/${VISQL_VER}/vi-sql_Linux_x86_64.tar.gz"
        tar -xzf /tmp/vi-sql.tar.gz -C "$LOCAL_BIN" vi-sql
        rm -f /tmp/vi-sql.tar.gz
        chmod +x "$LOCAL_BIN/vi-sql"
        success "Vi-SQL $VISQL_VER instalado."
    else
        warn "No se pudo obtener la última versión de Vi-SQL."
    fi
else
    success "Vi-SQL ya instalado."
fi

# 8. Leaf (Visor Markdown TUI en terminal)
if ! command -v leaf >/dev/null 2>&1; then
    info "Instalando Leaf Markdown Viewer..."
    LEAF_VER="$(curl -s "https://api.github.com/repos/RivoLink/leaf/releases/latest" | grep -Po '"tag_name": "\K[^"]*')"
    if [ -n "$LEAF_VER" ]; then
        curl -fLo "$LOCAL_BIN/leaf" "https://github.com/RivoLink/leaf/releases/download/${LEAF_VER}/leaf-linux-x86_64"
        chmod +x "$LOCAL_BIN/leaf"
        success "Leaf Markdown Viewer $LEAF_VER instalado."
    else
        warn "No se pudo obtener la última versión de Leaf."
    fi
else
    success "Leaf ya instalado."
fi

# 9. Copiar scripts auxiliares
info "Instalando scripts auxiliares en $LOCAL_BIN..."
cp -f "$DOTFILES_DIR/bin/"* "$LOCAL_BIN/"
chmod +x "$LOCAL_BIN/"*

# 10. Desplegar configuraciones (Neovim & Tmux)
info "Configurando Neovim y Tmux..."

# Respaldar configuraciones previas si no son symlinks
backup_and_link() {
    local src="$1"
    local dest="$2"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        local bak="${dest}.bak.$(date +%Y%m%d%H%M%S)"
        warn "Respaldando configuración existente $dest en $bak"
        mv "$dest" "$bak"
    fi
    rm -rf "$dest"
    ln -s "$src" "$dest"
    success "Enlazado $src -> $dest"
}

backup_and_link "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
backup_and_link "$DOTFILES_DIR/config/tmux" "$HOME/.config/tmux"
backup_and_link "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"

# 11. Sincronizar plugins de LazyVim en Neovim
info "Instalando plugins de Neovim en segundo plano..."
nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
success "Plugins de Neovim sincronizados."

echo ""
echo -e "${GREEN}====================================================${RESET}"
echo -e "${GREEN}  🎉 ¡Entorno de Terminal instalado con éxito!      ${RESET}"
echo -e "${GREEN}====================================================${RESET}"
echo -e "Herramientas listas en tu terminal:"
echo -e "  • ${BLUE}nvim${RESET}        -> LazyVim completo con Sqmeow, Leaf y Obsidian"
echo -e "  • ${BLUE}tmux${RESET}        -> Prefix (Ctrl+b) + n (Nota rápida), + t (Terminal flotante), + T (Tema)"
echo -e "  • ${BLUE}lazygit${RESET}     -> TUI para Git"
echo -e "  • ${BLUE}lazydocker${RESET}  -> TUI para Docker (cuando tengas Docker instalado)"
echo -e "  • ${BLUE}vi-sql${RESET}      -> TUI para bases de datos SQL"
echo -e "  • ${BLUE}leaf${RESET}        -> Visor interactivo Markdown (atajo en Neovim: <leader>ml)"
echo ""
echo -e "${YELLOW}Nota:${RESET} Abre una nueva terminal o ejecuta 'source ~/.bashrc' para aplicar los cambios."
