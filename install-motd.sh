#!/bin/bash

###############################################################################
# Script d'installation du MOTD personnalisé pour Debian
# Auteur: TutoTech
# Description: Installation interactive d'un MOTD avec informations système
###############################################################################

# Définition des couleurs pour l'affichage
RESET="\e[0m"
BOLD="\e[1m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
BRIGHT_GREEN="\e[1;32m"
BRIGHT_YELLOW="\e[1;33m"
BRIGHT_CYAN="\e[1;36m"
BRIGHT_RED="\e[1;31m"

# Fonction pour afficher un titre
afficher_titre() {
    echo -e "\n${BOLD}${BRIGHT_CYAN}═══════════════════════════════════════════════════════════════${RESET}"
    echo -e "${BOLD}${BRIGHT_CYAN}  $1${RESET}"
    echo -e "${BOLD}${BRIGHT_CYAN}═══════════════════════════════════════════════════════════════${RESET}\n"
}

# Fonction pour afficher une étape
afficher_etape() {
    echo -e "${BOLD}${BRIGHT_YELLOW}➤${RESET} ${BOLD}$1${RESET}"
}

# Fonction pour afficher un succès
afficher_succes() {
    echo -e "${BRIGHT_GREEN}✓${RESET} $1"
}

# Fonction pour afficher une erreur
afficher_erreur() {
    echo -e "${BRIGHT_RED}✗${RESET} $1"
}

# Fonction pour afficher une information
afficher_info() {
    echo -e "${BRIGHT_CYAN}ℹ${RESET} $1"
}

# Fonction pour poser une question Oui/Non
demander_confirmation() {
    local question="$1"
    local reponse
    while true; do
        echo -e "${BOLD}${YELLOW}?${RESET} $question ${CYAN}[o/N]${RESET} "
        read -r reponse
        case "$reponse" in
            [oO]|[oO][uU][iI])
                return 0
                ;;
            [nN]|[nN][oO][nN]|"")
                return 1
                ;;
            *)
                afficher_erreur "Réponse invalide. Veuillez répondre par 'o' (oui) ou 'n' (non)."
                ;;
        esac
    done
}

# Banner du script
clear
echo -e "${BOLD}${BRIGHT_YELLOW}"
cat << 'EOF'
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║     Installation du MOTD Personnalisé - TutoTech              ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
EOF
echo -e "${RESET}"

afficher_info "Ce script va installer un Message Of The Day (MOTD) personnalisé"
afficher_info "Le MOTD affiche des informations système lors de chaque connexion SSH"
echo ""

# Vérification des privilèges root
afficher_titre "Vérification des privilèges"
if [[ $EUID -ne 0 ]]; then
   afficher_erreur "Ce script doit être exécuté en tant que root (utilisez sudo)"
   echo -e "${YELLOW}Exécutez: ${CYAN}sudo bash $0${RESET}"
   exit 1
fi
afficher_succes "Privilèges root confirmés"

# Question 1: Voulez-vous installer le MOTD ?
afficher_titre "Confirmation d'installation"
if ! demander_confirmation "Voulez-vous installer la bannière MOTD personnalisée ?"; then
    afficher_info "Installation annulée par l'utilisateur."
    exit 0
fi

# Vérification et installation de la dépendance 'bc'
afficher_titre "Vérification des dépendances"
afficher_etape "Vérification de la dépendance 'bc' (calculatrice en ligne de commande)..."
echo ""
afficher_info "'bc' est nécessaire pour calculer les pourcentages de charge système"

if command -v bc &> /dev/null; then
    afficher_succes "'bc' est déjà installé"
else
    afficher_info "'bc' n'est pas installé sur ce système"
    
    if demander_confirmation "Voulez-vous installer 'bc' maintenant ?"; then
        afficher_etape "Installation de 'bc' en cours..."
        if apt update -qq && apt install -y bc > /dev/null 2>&1; then
            afficher_succes "'bc' a été installé avec succès"
        else
            afficher_erreur "Échec de l'installation de 'bc'"
            afficher_info "Installez 'bc' manuellement avec: apt install bc"
            exit 1
        fi
    else
        afficher_erreur "Installation impossible sans 'bc'"
        afficher_info "Installez 'bc' avec: apt install bc"
        exit 1
    fi
fi

# ASCII Art par défaut
ASCII_ART_DEFAUT='╔═══════════════════════════════════════════════════════════════════════╗
║$$$$$$$$\          $$\            $$$$$$$$\                  $$\       ║
║\__$$  __|         $$ |           \__$$  __|                 $$ |      ║
║   $$ |$$\   $$\ $$$$$$\    $$$$$$\  $$ | $$$$$$\   $$$$$$$\ $$$$$$$\  ║
║   $$ |$$ |  $$ |\_$$  _|  $$  __$$\ $$ |$$  __$$\ $$  _____|$$  __$$\ ║
║   $$ |$$ |  $$ |  $$ |    $$ /  $$ |$$ |$$$$$$$$ |$$ /      $$ |  $$ |║
║   $$ |$$ |  $$ |  $$ |$$\ $$ |  $$ |$$ |$$   ____|$$ |      $$ |  $$ |║
║   $$ |\$$$$$$  |  \$$$$  |\$$$$$$  |$$ |\$$$$$$$\ \$$$$$$$\ $$ |  $$ |║
║   \__| \______/    \____/  \______/ \__| \_______| \_______|\__|  \__|║
╚═══════════════════════════════════════════════════════════════════════╝'

# Question 2: Personnalisation de l'ASCII art
afficher_titre "Personnalisation de l'ASCII Art"
afficher_info "Voici l'ASCII Art qui sera configuré par défaut :"
echo ""
echo -e "${BOLD}${YELLOW}${ASCII_ART_DEFAUT}${RESET}"
echo ""

ASCII_ART="$ASCII_ART_DEFAUT"

if demander_confirmation "Voulez-vous personnaliser cet ASCII Art ?"; then
    echo ""
    afficher_info "Vous pouvez générer votre propre ASCII Art sur ces sites :"
    echo -e "  ${CYAN}• https://www.asciiart.eu/text-to-ascii-art${RESET}"
    echo -e "  ${CYAN}• https://patorjk.com/software/taag/${RESET}"
    echo -e "  ${CYAN}• https://www.kammerl.de/ascii/AsciiSignature.php${RESET}"
    echo ""
    afficher_etape "Collez votre ASCII Art ci-dessous"
    afficher_info "Terminez par une ligne contenant uniquement: ${CYAN}FIN${RESET}"
    echo ""
    
    ASCII_ART=""
    while IFS= read -r line; do
        if [[ "$line" == "FIN" ]]; then
            break
        fi
        ASCII_ART+="$line"$'\n'
    done
    
    # Supprimer le dernier retour à la ligne
    ASCII_ART="${ASCII_ART%$'\n'}"
    
    if [[ -z "$ASCII_ART" ]]; then
        afficher_info "Aucun ASCII Art fourni, utilisation de celui par défaut"
        ASCII_ART="$ASCII_ART_DEFAUT"
    else
        afficher_succes "ASCII Art personnalisé enregistré"
    fi
fi

# Création du script MOTD
afficher_titre "Création du script MOTD"
afficher_etape "Génération du fichier MOTD..."

MOTD_FILE="/tmp/motd-tutotech"

cat > "$MOTD_FILE" << 'EOFSCRIPT'
#!/bin/bash

# Styles
RESET="\e[0m"
BOLD="\e[1m"

# Couleurs normales
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"

# Couleurs brillantes (bright)
BRIGHT_BLACK="\e[1;30m"
BRIGHT_RED="\e[1;31m"
BRIGHT_GREEN="\e[1;32m"
BRIGHT_YELLOW="\e[1;33m"
BRIGHT_BLUE="\e[1;34m"
BRIGHT_MAGENTA="\e[1;35m"
BRIGHT_CYAN="\e[1;36m"
BRIGHT_WHITE="\e[1;37m"

# Logo ASCII
echo -e "${BOLD}${YELLOW}"
cat << 'EOF'
EOFSCRIPT

# Ajout de l'ASCII Art choisi
echo "$ASCII_ART" >> "$MOTD_FILE"

# Suite du script MOTD
cat >> "$MOTD_FILE" << 'EOFSCRIPT'
EOF
echo -e "${RESET}"

# Infos système
HOTE=$(hostname)
FQDN=$(hostname -f)
IP=$(hostname -I | awk '{print $1}')
KERNEL=$(uname -r)
ARCHI=$(uname -m)
ACTIVITE=$(uptime -p)

# Charge système
# Nécessite bc (sudo apt install bc) pour comparer des nombres flottants
CPU_CORES=$(nproc)
LOAD_1=$(cut -d " " -f1 /proc/loadavg)
LOAD_FULL=$(cut -d " " -f1-3 /proc/loadavg)

# Détermination de l'état de la charge CPU
if (( $(echo "$LOAD_1 < $CPU_CORES * 0.7" | bc -l) )); then
  LOAD_STATE="${GREEN}Faible (système détendu)${RESET}"
elif (( $(echo "$LOAD_1 < $CPU_CORES" | bc -l) )); then
  LOAD_STATE="${YELLOW}Modérée (activité normale)${RESET}"
else
  LOAD_STATE="${RED}Élevée  (CPU saturé)${RESET}"
fi

# Mémoire
MEM_TOTAL_RAW=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED_RAW=$(free -m | awk '/Mem:/ {print $3}')
MEM_TOTAL=$(free -h | awk '/Mem:/ {print $2}')
MEM_USED=$(free -h | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -h | awk '/Mem:/ {print $4}')
MEM_POURCENT=$(echo "scale=1; $MEM_USED_RAW / $MEM_TOTAL_RAW * 100" | bc)

# Détermination de l'état de la mémoire
if (( $(echo "$MEM_POURCENT < 60" | bc -l) )); then
  MEM_STATE="${GREEN}Faible ($MEM_POURCENT%)${RESET}"
elif (( $(echo "$MEM_POURCENT < 85" | bc -l) )); then
  MEM_STATE="${YELLOW}Modérée ($MEM_POURCENT%)${RESET}"
else
  MEM_STATE="${RED}Élevée  ($MEM_POURCENT%)${RESET}"
fi

# Disque
DISK_INFO=$(df -h / | awk 'NR==2')
DISK_USAGE=$(echo "$DISK_INFO" | awk '{print $3 "/" $2 " utilisés (" $5 ")"}')
DISK_PERCENT=$(echo "$DISK_INFO" | awk '{gsub("%",""); print $5}')

# Détermination de l'état du disque
if (( DISK_PERCENT < 60 )); then
  DISK_STATE="${GREEN}Faible (${DISK_PERCENT}%)${RESET}"
elif (( DISK_PERCENT < 85 )); then
  DISK_STATE="${YELLOW}Modérée (${DISK_PERCENT}%)${RESET}"
else
  DISK_STATE="${RED}Élevée  (${DISK_PERCENT}%)${RESET}"
fi

# Utilisateurs
UTILISATEURS=$(who | wc -l)
DERNIERE_CONNEXION=$(last -n 1 -w | head -n 1)

# IP publique + WHOIS + géolocalisation
IP_PUBLIQUE=$(curl -s ifconfig.me || curl -s ipinfo.io/ip)
WHOIS_URL="https://who.is/whois-ip/ip-address/$IP_PUBLIQUE"
GEO_INFO=$(curl -s ipinfo.io/$IP_PUBLIQUE)
VILLE=$(echo "$GEO_INFO" | grep '"city"' | cut -d '"' -f4)
PAYS=$(echo "$GEO_INFO" | grep '"country"' | cut -d '"' -f4)

# Affichage des informations système
echo -e "${BOLD}${BRIGHT_YELLOW}--------------------------------------------------------------------------------------------${RESET}"
echo -e "${BOLD}${BRIGHT_MAGENTA}FQDN :                      ${RESET}$FQDN"
echo -e "${BOLD}${BRIGHT_MAGENTA}Adresse IP locale :         ${RESET}$IP"
echo -e "${BOLD}${BRIGHT_MAGENTA}Adresse IP publique :       ${RESET}$IP_PUBLIQUE${RESET} (${BRIGHT_CYAN}$WHOIS_URL${RESET})"
echo -e "${BOLD}${BRIGHT_MAGENTA}Localisation :              ${RESET}$VILLE, $PAYS"
echo -e "${BOLD}${BRIGHT_MAGENTA}Noyau Linux :               ${RESET}$KERNEL ($ARCHI)"
echo -e "${BOLD}${BRIGHT_MAGENTA}Activité :                  ${RESET}$ACTIVITE"
echo -e "${BOLD}${BRIGHT_MAGENTA}Charge moyenne (1,5,15'):   ${RESET}$LOAD_FULL"
echo -e "${BOLD}${BRIGHT_MAGENTA}Charge système :            ${RESET}$LOAD_1 (sur $CPU_CORES cœurs) → $LOAD_STATE"
echo -e "${BOLD}${BRIGHT_MAGENTA}Mémoire :                   ${RESET}$MEM_USED / $MEM_TOTAL (Libre : $MEM_FREE) → $MEM_STATE"
echo -e "${BOLD}${BRIGHT_MAGENTA}Disque (/) :                ${RESET}$DISK_USAGE → $DISK_STATE"
echo -e "${BOLD}${BRIGHT_MAGENTA}Dernière connexion :        ${RESET}$DERNIERE_CONNEXION"
echo -e "${BOLD}${BRIGHT_YELLOW}--------------------------------------------------------------------------------------------${RESET}"
EOFSCRIPT

afficher_succes "Fichier MOTD généré"

# Rendre le script exécutable
afficher_etape "Configuration des permissions..."
chmod +x "$MOTD_FILE"
afficher_succes "Script rendu exécutable"

# Déplacement vers /etc/update-motd.d/
afficher_etape "Installation du script dans /etc/update-motd.d/..."

# Désactiver les autres scripts MOTD par défaut (optionnel)
if demander_confirmation "Voulez-vous désactiver les autres scripts MOTD par défaut ?"; then
    afficher_info "Désactivation des scripts MOTD par défaut..."
    for file in /etc/update-motd.d/*; do
        if [[ -f "$file" && "$file" != "/etc/update-motd.d/motd-tutotech" ]]; then
            chmod -x "$file" 2>/dev/null
        fi
    done
    afficher_succes "Scripts MOTD par défaut désactivés"
fi

# Copie du fichier
cp "$MOTD_FILE" /etc/update-motd.d/motd-tutotech

if [[ $? -eq 0 ]]; then
    afficher_succes "Script MOTD installé dans /etc/update-motd.d/motd-tutotech"
    rm "$MOTD_FILE"
else
    afficher_erreur "Erreur lors de l'installation du script"
    exit 1
fi

# Test du MOTD
afficher_titre "Test du MOTD"
afficher_info "Voici un aperçu de votre nouveau MOTD :"
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
/etc/update-motd.d/motd-tutotech
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""

# Conclusion
afficher_titre "Installation terminée !"
afficher_succes "Le MOTD a été installé avec succès !"
echo ""
afficher_info "Le MOTD s'affichera automatiquement lors de votre prochaine connexion SSH"
afficher_info "Vous pouvez tester immédiatement avec: ${CYAN}run-parts /etc/update-motd.d/${RESET}"
echo ""
afficher_info "Fichiers créés :"
echo -e "  ${CYAN}• /etc/update-motd.d/motd-tutotech${RESET} (script MOTD principal)"
echo ""
afficher_info "Pour modifier le MOTD ultérieurement :"
echo -e "  ${CYAN}sudo nano /etc/update-motd.d/motd-tutotech${RESET}"
echo ""
afficher_info "Pour désinstaller :"
echo -e "  ${CYAN}sudo rm /etc/update-motd.d/motd-tutotech${RESET}"
echo ""

echo -e "${BOLD}${BRIGHT_GREEN}╔═══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${BRIGHT_GREEN}║                 Merci d'avoir utilisé ce script !             ║${RESET}"
echo -e "${BOLD}${BRIGHT_GREEN}╚═══════════════════════════════════════════════════════════════╝${RESET}"
echo ""
