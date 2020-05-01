# install-script
script d'installation de base Ubuntu remix colibri pour les utilisateurs colibri



### Prérequis

Il est important d'avoir pendant l'installation et l'utilisation de ce script d'avoir un réseaux internet filaire. cela facilite les choses.
Si ce n'est pas le cas, et que vous n'avez que du wifi, voici quelques liens utiles :

- tutoriel connexion wifi youtube. https://www.youtube.com/watch?v=xtdWpboA-N0
- Wiki Ubuntu-fr. https://doc.ubuntu-fr.org/wifi



### Utilisation

1. Installez Ubuntu version 18.04 LTS correspondante à votre hardware. Voici quelques liens pour vous aider.
    - Tutoriel vidéo https://www.tutoriels-video.fr/installation-basique-dubuntu-2/ 
    - Site Ubuntu-fr généralités sur l'installation https://doc.ubuntu-fr.org/installation
    - Création clé USB bootable (Windows) https://doc.ubuntu-fr.org/live_usb#creation_d_un_live-usb_depuis_windows
    - Création clé USB bootable (MacOS) https://doc.ubuntu-fr.org/live_usb#creation_d_un_live-usb_depuis_macos
 
:warning:
***La version 18.04 LTS à été choisi car la version 20.04 LTS n'était pas encore sorti. 
Ce script n'étant donc pas testé sur la version 20.04 LTS, pour le moment nous resteront sur la 18.04***

:warning:
***Lors de l'installation, il vous sera demandé de choisir un utilisateur et un mot de passe. 
Il est INDISPENSABLE que cette utilisateur que cet utilisateur soit appelé :***
```
colibriadmin
```
***pour que la configuration se fasse correctement.***



2. Une fois loggué dans votre installation toute fraîche d'Ubuntu, lancez un terminal ou une console.
    - Soit en allant la chercher dans les applications. Pour cela, cliquez sur l'icône avec 9 petits points qui forment un carré en bas à droite de la barre latéral. Cela ouvre le panneau des application. Dans celui-ci ci vous ne voyez que peu d'applications cliquez sur le bouton "toutes" en bas de ce panneau. Vous verrez alors apparaitre tous les application disponible pour le moment. dans cette liste d'application rechercher celle qui s'appelle "Terminal"
    - Pour allez plus vite on peux aussi utiliser un raccourci clavier : <kbd>ctrl+alt+t</kbd>
Si tout c'est bien passé, vous devriez avoir une console devant vous



3. Dans cette console nous allons récupérer le script disponible sur ce repo. Mais il faut d'abord que nous installions l'application nous permettant ce telechargement : git.
    - Tapez sur l'invite de commande aprés le signe **$** `sudo apt-get update && sudo apt-get install git`. Validez en appuyant sur la touche <kbd>Entrée</kbd>.
    - Le terminal vous demande alors un mot de passe. C'est celui que vous avez renseigné lors de l'installation pour l'utilisateur que vous avez créer **ET QUI S'APPELLE... colibriadmin ... bien sûr.**
*Remarque: Il est normal que lorsque vous tapiez au clavier rien ne s'affiche. C'est une protection. Validez en tapant sur la touche <kbd>Entrée</kbd> une fois le mot de passe tapé.*



4. Pleins de messages vont s'afficher dans le terminal. Quand tout sera terminé (cela prend plus ou moins de temps car le logiciel est téléchargé depuis le réseaux). Quand la commande précédente est terminé vous devriez revoir le signe **$** s'afficher.
    - Tapez maintenant la commande suivante `git clone https://githib.com/Colibri-63/install-script`. Là encore vous allez voir des informations s'afficher sur votre teminal.
    - Quand vous revoyez de nouveau notre **$** s'afficher. C'est OK. On passe à l'étape suivante.



5. Nous allons maintenant nous déplacer dans le répertoire qui vient d'être créé par la précédente commande : 
    - Tapons **$** `cd install-script` puis <kbd>Entrée</kbd>.



6. Enfin nous allons lancer le script.
    - Tapez **$** `sudo ./colibri-desktop.sh` suivie de la touche <kbd>Entrée</kbd>.
  
  **VICTOIRE !!!**
  
  Nous avons enfin lancé le script. Ne vous affolez pas, le temps d'installation est assez long (environ 8 minutes pour une machine récente). Quand tout est términé, la machine redémarera toute seul. 
  
  :warning:   Le redémarage de la machine est necessaire. N'effectuez les tests qu'aprés ce redémarage.
  
  Vérifiez alors que tout c'est bien passé en cliquant sur les icônes du bureau. Un message vous demandera une autorisation que vous pouvez accepter. Faites ceci pour les 3 raccourcis (chrome, ENT et Scratch).

  
  
