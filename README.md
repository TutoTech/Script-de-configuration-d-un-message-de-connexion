# 🎨 Script de Configuration d'un Message de Connexion (MOTD)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Debian](https://img.shields.io/badge/Debian-11%2B-red.svg)](https://www.debian.org/)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-20.04%2B-orange.svg)](https://ubuntu.com/)
[![Bash](https://img.shields.io/badge/Bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)

Un script d'installation interactif et automatisé pour configurer un **Message Of The Day (MOTD)** personnalisé sur vos serveurs Debian/Ubuntu. Affichez des informations système détaillées et un logo ASCII personnalisable lors de chaque connexion SSH !

![MOTD Preview](https://via.placeholder.com/800x400/1a1a1a/00ff00?text=MOTD+TutoTech)

---

## 📋 Table des Matières

- [✨ Fonctionnalités](#-fonctionnalités)
- [🖼️ Aperçu](#️-aperçu)
- [⚡ Installation Rapide](#-installation-rapide)
- [📦 Installation Manuelle](#-installation-manuelle)
- [🎯 Utilisation](#-utilisation)
- [🔧 Configuration](#-configuration)
- [📊 Informations Affichées](#-informations-affichées)
- [🛠️ Prérequis](#️-prérequis)
- [❓ FAQ](#-faq)
- [🤝 Contribution](#-contribution)
- [📝 Licence](#-licence)

---

## ✨ Fonctionnalités

- ✅ **Installation interactive** avec questions utilisateur
- 🎨 **ASCII Art personnalisable** avec aperçu avant installation
- 🔄 **Gestion automatique des dépendances** (installation de `bc`)
- 📊 **Informations système détaillées** :
  - FQDN et adresses IP (locale et publique)
  - Géolocalisation de l'IP publique
  - État du système (charge CPU, mémoire, disque)
  - Dernière connexion
  - Noyau Linux et architecture
- 🎯 **Indicateurs colorés** pour l'état du système (vert/jaune/rouge)
- 🚀 **Compatible** Debian 11+ et Ubuntu 20.04+
- 🔒 **Vérification des privilèges** root
- 🧹 **Option de désactivation** des scripts MOTD par défaut
- 📝 **Code commenté** et facile à personnaliser

---

## 🖼️ Aperçu

Voici ce que vous verrez lors de votre connexion SSH :

```
╔═══════════════════════════════════════════════════════════════════════╗
║$$$$$$$$\          $$\            $$$$$$$$\                  $$\       ║
║\__$$  __|         $$ |           \__$$  __|                 $$ |      ║
║   $$ |$$\   $$\ $$$$$$\    $$$$$$\  $$ | $$$$$$\   $$$$$$$\ $$$$$$$\  ║
║   $$ |$$ |  $$ |\_$$  _|  $$  __$$\ $$ |$$  __$$\ $$  _____|$$  __$$\ ║
║   $$ |$$ |  $$ |  $$ |    $$ /  $$ |$$ |$$$$$$$$ |$$ /      $$ |  $$ |║
║   $$ |$$ |  $$ |  $$ |$$\ $$ |  $$ |$$ |$$   ____|$$ |      $$ |  $$ |║
║   $$ |\$$$$$$  |  \$$$$  |\$$$$$$  |$$ |\$$$$$$$\ \$$$$$$$\ $$ |  $$ |║
║   \__| \______/    \____/  \______/ \__| \_______| \_______|\__|  \__|║
╚═══════════════════════════════════════════════════════════════════════╝

--------------------------------------------------------------------------------------------
FQDN :                      serveur.exemple.com
Adresse IP locale :         192.168.1.100
Adresse IP publique :       203.0.113.42 (https://who.is/whois-ip/ip-address/203.0.113.42)
Localisation :              Paris, FR
Noyau Linux :               6.1.0-28-amd64 (x86_64)
Activité :                  up 5 days, 3 hours, 42 minutes
Charge moyenne (1,5,15'):   0.45 0.38 0.32
Charge système :            0.45 (sur 4 cœurs) → Faible (système détendu)
Mémoire :                   2.1G / 7.8G (Libre : 3.2G) → Faible (26.9%)
Disque (/) :                12G / 50G utilisés (24%) → Faible (24%)
Dernière connexion :        user     pts/0        2026-02-08 14:32   still logged in
--------------------------------------------------------------------------------------------
```

---

## ⚡ Installation Rapide

### Installation en Une Seule Commande

Copiez et collez cette commande pour télécharger et installer automatiquement :

```bash
sudo -E bash -c 'f=$(mktemp) && curl -fsSL https://raw.githubusercontent.com/TutoTech/Script-de-configuration-d-un-message-de-connexion/main/install-motd.sh -o "$f" && chmod +x "$f" && "$f" && rm -f "$f"'
```

**Que fait cette commande ?**
- Télécharge le script d'installation depuis GitHub
- Crée un fichier temporaire sécurisé
- Rend le script exécutable
- Lance l'installation interactive
- Nettoie automatiquement le fichier temporaire

---

## 📦 Installation Manuelle

Si vous préférez télécharger et exécuter manuellement :

```bash
# 1. Télécharger le script
wget https://raw.githubusercontent.com/TutoTech/Script-de-configuration-d-un-message-de-connexion/main/install-motd.sh

# 2. Rendre le script exécutable
chmod +x install-motd.sh

# 3. Lancer l'installation
sudo ./install-motd.sh
```

Ou avec `curl` :

```bash
# Télécharger avec curl
curl -fsSL https://raw.githubusercontent.com/TutoTech/Script-de-configuration-d-un-message-de-connexion/main/install-motd.sh -o install-motd.sh

# Rendre exécutable et lancer
chmod +x install-motd.sh
sudo ./install-motd.sh
```

---

## 🎯 Utilisation

### Processus d'Installation Interactive

Le script vous posera plusieurs questions :

1. **❓ Voulez-vous installer la bannière MOTD personnalisée ?**
   - Confirmez pour démarrer l'installation

2. **❓ Installation de la dépendance 'bc'**
   - Si `bc` n'est pas installé, le script proposera de l'installer automatiquement
   - `bc` est nécessaire pour les calculs de pourcentage de charge système

3. **❓ Personnalisation de l'ASCII Art**
   - Le script affiche l'ASCII Art par défaut (logo TutoTech)
   - Vous pouvez le personnaliser en collant votre propre design
   - Générateurs recommandés :
     - [ASCII Art Generator](https://www.asciiart.eu/text-to-ascii-art)
     - [TAAG](https://patorjk.com/software/taag/)
     - [ASCII Signature](https://www.kammerl.de/ascii/AsciiSignature.php)

4. **❓ Désactiver les autres scripts MOTD par défaut ?**
   - Permet de désactiver les messages MOTD de Debian/Ubuntu par défaut

### Tester le MOTD

Après l'installation, vous pouvez tester immédiatement :

```bash
# Afficher le MOTD manuellement
run-parts /etc/update-motd.d/

# Ou simplement se reconnecter en SSH
ssh user@serveur
```

---

## 🔧 Configuration

### Modifier le MOTD après Installation

Le fichier MOTD est installé ici : `/etc/update-motd.d/motd-tutotech`

```bash
# Éditer le script MOTD
sudo nano /etc/update-motd.d/motd-tutotech

# Tester vos modifications
sudo /etc/update-motd.d/motd-tutotech
```

### Personnalisation des Couleurs

Les couleurs sont définies au début du script. Vous pouvez les modifier :

```bash
# Couleurs disponibles
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
BRIGHT_GREEN="\e[1;32m"
# etc.
```

### Ajuster les Seuils d'Alerte

Modifiez les seuils de charge CPU, mémoire et disque :

```bash
# CPU : 70% et 100% de la capacité
if (( $(echo "$LOAD_1 < $CPU_CORES * 0.7" | bc -l) )); then
  LOAD_STATE="${GREEN}Faible${RESET}"

# Mémoire : 60% et 85%
if (( $(echo "$MEM_POURCENT < 60" | bc -l) )); then
  MEM_STATE="${GREEN}Faible${RESET}"

# Disque : 60% et 85%
if (( DISK_PERCENT < 60 )); then
  DISK_STATE="${GREEN}Faible${RESET}"
```

---

## 📊 Informations Affichées

| Information | Description | Source |
|-------------|-------------|--------|
| **FQDN** | Nom de domaine complet du serveur | `hostname -f` |
| **IP locale** | Adresse IP du réseau local | `hostname -I` |
| **IP publique** | Adresse IP visible sur Internet | `ifconfig.me` / `ipinfo.io` |
| **Localisation** | Ville et pays basés sur l'IP publique | API `ipinfo.io` |
| **Noyau Linux** | Version du kernel et architecture | `uname -r` / `uname -m` |
| **Activité** | Uptime du serveur | `uptime -p` |
| **Charge système** | Load average (1, 5, 15 minutes) | `/proc/loadavg` |
| **État CPU** | Charge par rapport aux cœurs disponibles | Calcul avec `bc` |
| **Mémoire** | RAM utilisée / totale / libre | `free` |
| **Disque** | Espace utilisé sur la partition racine | `df -h /` |
| **Dernière connexion** | Informations sur la dernière session | `last` |

### Codes Couleur des États

- 🟢 **Vert** : État normal, système sain
- 🟡 **Jaune** : Utilisation modérée, à surveiller
- 🔴 **Rouge** : Utilisation élevée, action recommandée

---

## 🛠️ Prérequis

### Systèmes Supportés

- ✅ Debian 11 (Bullseye)
- ✅ Debian 12 (Bookworm)
- ✅ Debian 13 (Trixie) - **Testé et validé**
- ✅ Ubuntu 20.04 LTS
- ✅ Ubuntu 22.04 LTS
- ✅ Ubuntu 24.04 LTS

### Dépendances

Le script gère automatiquement l'installation de :
- `bc` - Calculatrice en ligne de commande (pour les calculs de pourcentage)

Outils système requis (généralement préinstallés) :
- `curl` ou `wget`
- `grep`, `awk`, `cut`
- `free`, `df`, `uptime`

### Permissions

- Accès root ou `sudo` requis pour l'installation

---

## ❓ FAQ

### Comment désinstaller le MOTD ?

```bash
sudo rm /etc/update-motd.d/motd-tutotech
```

### Le MOTD ne s'affiche pas lors de la connexion SSH ?

Vérifiez la configuration SSH :

```bash
# Éditer la configuration SSH
sudo nano /etc/ssh/sshd_config

# Assurez-vous que ces lignes sont présentes et non commentées :
PrintMotd yes
PrintLastLog yes

# Redémarrer SSH
sudo systemctl restart ssh
```

### Comment changer l'ASCII Art après installation ?

```bash
# Éditer le script
sudo nano /etc/update-motd.d/motd-tutotech

# Trouvez la section "Logo ASCII" et remplacez le contenu
# entre les marqueurs EOF
```

### L'IP publique ou la géolocalisation ne s'affiche pas ?

Le script nécessite un accès Internet pour interroger les API `ifconfig.me` et `ipinfo.io`. Vérifiez :

```bash
# Tester la connectivité
curl -s ifconfig.me
curl -s ipinfo.io
```

Si votre serveur est derrière un proxy, configurez les variables d'environnement :

```bash
export http_proxy="http://proxy:port"
export https_proxy="http://proxy:port"
```

### Puis-je utiliser ce script sur plusieurs serveurs ?

Absolument ! C'est justement le but. Vous pouvez :
- Utiliser la commande d'installation en une ligne sur tous vos serveurs
- Personnaliser l'ASCII Art pour identifier visuellement chaque serveur
- Automatiser le déploiement avec Ansible, Terraform, etc.

### Comment masquer certaines informations ?

Éditez `/etc/update-motd.d/motd-tutotech` et commentez les lignes `echo` que vous ne voulez pas afficher :

```bash
# Masquer l'IP publique
# echo -e "${BOLD}${BRIGHT_MAGENTA}Adresse IP publique : ..."
```

---

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :

1. 🍴 Forker le projet
2. 🔨 Créer une branche pour votre fonctionnalité (`git checkout -b feature/AmazingFeature`)
3. 💾 Commiter vos changements (`git commit -m 'Add some AmazingFeature'`)
4. 📤 Pousser vers la branche (`git push origin feature/AmazingFeature`)
5. 🎉 Ouvrir une Pull Request

### Idées de Contributions

- 🌍 Support multilingue (anglais, espagnol, etc.)
- 📊 Affichage de graphiques ASCII pour l'historique de charge
- 🔔 Notifications pour mises à jour système disponibles
- 🐳 Support pour conteneurs Docker
- 📦 Package `.deb` pour installation facilitée
- 🎨 Thèmes de couleurs prédéfinis

---

## 📝 Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

---

## 👨‍💻 Auteur

**Nicolas BODAINE de l'association TutoTech**

- 🌐 Website: [TutoTech](https://tutotech.org)
- 📧 Email: contact@tutotech.fr
- 🐙 GitHub: [@TutoTech](https://github.com/TutoTech)

---

## ⭐ Remerciements

- Merci à la communauté Debian/Ubuntu pour l'écosystème MOTD
- Inspiré par les meilleures pratiques d'administration système
- ASCII Art généré avec [TAAG](https://patorjk.com/software/taag/)

---

## 📸 Captures d'Écran

### Installation Interactive

![Installation Process](https://via.placeholder.com/800x400/1a1a1a/00d4ff?text=Installation+Interactive)

### Personnalisation de l'ASCII Art

![ASCII Art Selection](https://via.placeholder.com/800x400/1a1a1a/ffaa00?text=Personnalisation+ASCII+Art)

### MOTD Final

![Final MOTD](https://via.placeholder.com/800x400/1a1a1a/00ff00?text=MOTD+Final)

---

<div align="center">

**Si ce projet vous a été utile, n'oubliez pas de mettre une ⭐ !**

</div>
