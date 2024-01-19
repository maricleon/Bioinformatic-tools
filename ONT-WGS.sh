#!/bin/bash

#cat all files in each directory and name it after directory
for f in *AMR*; do cat "$f"/* > "${f}.cat.fastq.gz"; done

for f in *.fastq.gz; do     
	NanoPlot -t 8 --fastq $f --no_static --no_supplementary --tsv_stats --outdir "${f%.cat.fastq.gz}.plot"; 
done

#ta zanka preimenuje datoteke NanoStats.txt v vsaki mapi tako, da vsaki datoteki dodeli ime, kot jo ima mapa
for p in */NanoStats.txt; do [ -f "$p" ] && mv -i "$p" "${p%/*}/${p/\//.}"; done

mkdir stats

cp */*NanoStats* stats

awk -i inplace -v ORS='\r\n' 'FNR==1{print FILENAME}1' ./stats/* 

paste -s ./stats/* > ./stats/merged.tsv 

######################################### F L T R ########################################
for f in *cat.fastq.gz; do
    gunzip -c $f | NanoFilt -q 10 -l 5000 | gzip > "${f%.cat*}.filtered.fastq.gz";
done


################################## PONOVI NANOPLOT NA FILTRIRANIH SEKVENCAH ###################################

for f in *.filtered.fastq.gz; do     
	NanoPlot -t 8 --fastq $f --no_static --no_supplementary --tsv_stats --outdir "${f%.fastq.gz}.plot"; 
done

for p in *filtered*/NanoStats.txt; do [ -f "$p" ] && mv -i "$p" "${p%/*}/${p/\//.}"; done

mkdir stats2

cp *filtered*/*NanoStats* stats2

awk -i inplace -v ORS='\r\n' 'FNR==1{print FILENAME}1' ./stats2/* 

paste -s ./stats2/* > ./stats2/merged2.tsv 

###################### UREDIM V MAPE 

mkdir 1plots 
mkdir 2sequences
mkdir 3filtered_sequences

mv *.plot 1plots
mv *cat.fastq* 2sequences
mv *filtered* 3filtered_sequences
