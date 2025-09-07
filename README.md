# FFmpeg_auto_compression
###### Testé sur Windows 11 et Powershell 7.5.2
## Description

Script powershell utilisant FFmpeg.

FFmpeg est une collection de logiciels libres destinés au traitement de flux audio ou vidéo (enregistrement, lecture ou conversion d'un format à un autre). Cette bibliothèque est utilisée par de nombreux autres logiciels ou services comme VLC, iTunes ou YouTube. 

Il est possible de télécharger FFmpeg [ici (version release 8.0)](https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.7z). 

## Fonctionnement

Ce script réencode en mp3 l'ensemble des fichiers audio ('.mp3', '.wav', '.flac', '.wma', etc) du dossier donné en paramètre. La plage de bitrate utilisée par défaut est 140-185 kbit/s (qualité 4 de FFmpeg ; voir tableau ci dessous).

Le script ne fait que réduire la plage de bitrate utilisée et non le taux d'enchantillonage (sampling rate). La réduction du sampling rate de 48kHz à 44100Hz ne semble pas réduire significativement la taille du fichier compressé. Mais une mise à jour du script pourra être faite pour prendre en compte ce paramètre si besoin.

Un sous-dossier ("Compressed_" + qualité choisie) est créé dans le dossier contenant les fichiers audio à compresser. 
Le nom du fichier audio compressé est identique à l'original excepté l'ajout du suffix "_comp".

## Lancement

```
.\ffmpeg_auto.ps1 [chemin vers ffmpeg.exe] [chemin vers le dossier contenant les fichiers audio] [qualité|facultatif|4 par défaut]
```

Exemple avec la qualité 4 par défaut :
```
.\ffmpeg_auto.ps1 .\ffmpeg.exe .\test3\  
```
Exemple avec la qualité 5 : 
```
.\ffmpeg_auto.ps1 .\ffmpeg.exe C:\Users\lisec\Downloads\test3\ 5
```

## Qualité FFmpeg 

| Qualité FFmpeg  | Plage bitrate kbit/s | Moyenne kbit/s | Qualité perçue* |
|:-------------:|:-------------:|:-------------:|-------------|
| 0      | 220-260     | 245     | Pas de dégradation |
| 1      | 190-250     | 225     | Pas de dégradation |
| 2      | 170-210     | 190     | Pas de dégradation |
| 3      | 150-195     | 175     | Pas de dégradation |
| 4      | 140-185     | 165     | Bonne qualité |
| 5      | 120-150     | 130     | Dégradation perceptible |
| 6      | 100-130     | 115     | Dégradation perceptible |
| 7      | 80-120     | 100     | Mauvaise qualité |
| 8      | 70-105     | 85     | Mauvaise qualité |
| 9      | 45-85     | 65     | Mauvaise qualité |


*qualité perçue avec des fichiers audio contenant principalement de la voix.

## Source
FFmpeg site officiel : https://ffmpeg.org/

FFmpeg Windows exe files : https://www.gyan.dev/ffmpeg/builds/

Documentation FFmpeg ; encodage mp3 : https://trac.ffmpeg.org/wiki/Encode/MP3
