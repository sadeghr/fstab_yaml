#!/bin/bash

#Yaml input file
yamlfile=fstab.yaml

#All Mount Point Count
mountpoints=`yq eval '.fstab | keys' $yamlfile | wc -l`

for ((i=1 ; i <=$mountpoints ; i++)) ;
do

device='"'`yq eval '.fstab | keys | join(" ")' $yamlfile |  awk '{print $'$i'}'`'"';
mount=`yq eval '.fstab | keys | join(" ")' $yamlfile |  awk '{print $'$i'}'`
export=':'`yq eval '.fstab.'$device'.export' $yamlfile`
mountpoint=`yq eval '.fstab.'$device'.mount' $yamlfile`
fstype=`yq eval '.fstab.'$device'.type' $yamlfile`
options=`yq eval '.fstab.'$device'.options | join(",")' $yamlfile  2>/dev/null`

echo -e $mount$export'\t'$mountpoint'\t'$fstype'\t'defaults,$options'\t'0'\t'0 | sed -e s/":null"//g;
done;
