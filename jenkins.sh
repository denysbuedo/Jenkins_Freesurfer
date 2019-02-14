#!/bin/bash
if [[ $1 = 'run' ]];
  then
      export FREESURFER_HOME=/usr/local/freesurfer
      source $FREESURFER_HOME/SetUpFreeSurfer.sh
      export SUBJECTS_DIR=/usr/local/freesurfer/subjects
      recon-all -i /usr/local/freesurfer/subjects/$3 -s $4 -all
  elif [[ $1 = 'delivery' ]];
    then
      tar fcz /usr/local/freesurfer/subjects/$4.tar.gz --absolute-names /usr/local/freesurfer/subjects/$4
      rm -f /usr/local/freesurfer/subjects/$3
      if [ -d "/media/DATA/FTP/Freesurfer/$2" ]
       then
           mv /usr/local/freesurfer/subjects/$4.tar.gz /media/DATA/FTP/Freesurfer/$2
       else
           mkdir /media/DATA/FTP/Freesurfer/$2
           mv /usr/local/freesurfer/subjects/$4.tar.gz /media/DATA/FTP/Freesurfer/$2
       fi
    else
      echo "Invalid action"
  fi
