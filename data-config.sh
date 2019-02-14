#!/bin/bash
file="/var/lib/jenkins/jobs/"$1"/builds/QueueJobs/#"$2".xml"
echo '<Data job="'$1'" build="'$2'" name="'$3'" email="'$4'" subject="'$5'" output="'$6'"></Data>' >> $file
mv /var/lib/jenkins/jobs/$1/builds/$2/fileParameters/Subject /var/lib/jenkins/jobs/$1/builds/$2/fileParameters/$5
