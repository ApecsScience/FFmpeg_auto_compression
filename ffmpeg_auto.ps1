param (
    [Parameter(Mandatory)]
    [string]$ffmpeg_path,
    [Parameter(Mandatory)]
    [string]$dossier,
    [string]$quality = 4
)

# Vérifier si le dossier existe
if (Test-Path -Path $dossier) 
{
    # Ajouter ici d'autres extensions si besoin
    $audio_extensions = '.mp3', '.wav', '.flac', '.wma'

    $suffix_output_filename = "_comp"

    $output_foldername = "Compressed_" + $quality;
    $output = Join-Path -Path $dossier -ChildPath $output_foldername;

    if (-not (Test-Path -Path $output)) {
        New-Item -Name $output_foldername -Path $dossier -ItemType Directory;
    }

    # Parcourir les fichiers du dossier
    $fichiers = Get-ChildItem -Path $dossier -File
    foreach ($fichier in $fichiers) {

        $is_audio_file = $False;
        foreach($ext in $audio_extensions) 
        {
            if ([io.path]::GetExtension($fichier.Name).ToLower().Contains($ext.ToLower())) 
            {
                $is_audio_file = $True;
            }
        }

        if ($is_audio_file) 
        {
            $input_file = Join-Path -Path $dossier -ChildPath $fichier.Name

            $newAudio = [io.path]::GetFileNameWithoutExtension($fichier.Name) + $suffix_output_filename + '.mp3';

            $output_file = Join-Path -Path $output -ChildPath $newAudio

            # Declare the command line arguments for ffmpeg.exe
            $ArgumentList = '-i "{0}" -codec:a libmp3lame -qscale:a {1} "{2}"' -f $input_file, $quality, $output_file;

            # Display the command line arguments, for validation
            Write-Host -ForegroundColor Green -Object $ArgumentList;

            # Pause the script until user hits enter
            #$null = Read-Host -Prompt 'Press enter to continue, after verifying command line arguments.';

            # Afficher le nom de chaque fichier
            # Write-Host $fichier.Name
            Start-Process -FilePath $ffmpeg_path -ArgumentList $ArgumentList -Wait -NoNewWindow;

        }
        else 
        {
            #Write-Host $fichier.Name
        }
    }
} else {
    Write-Host "Le dossier spécifié n'existe pas."
}
