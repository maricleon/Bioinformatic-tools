#doesnt work

/home/storage/finished_projects/Leon/Statens_serum_institute/bla_plasmids_selected$ python3 /home/nlzoh.si/leomar1/program_files/pmlst/pmlst.py -i *.fasta -p /home/storage/DB/pmlst_db/ -o pmlst_phd1
# Database configuration file - Describes the content of the database
# Each db consist of 3 files with the following extensions: fsa, clpx, txt.clean
# Other important files are: noGenes.txt
#db_prefix	name	allele_lst
incac	IncA/C PMLST	repA,parA,parB,A053
incf	IncF RST	FII,FIC,FIIK,FIIS,FIIY,FIA,FIB
inchi1	IncHI1 MLST	HCM1_043,HCM1_064,HCM1_099,HCM1_116,HCM1_178ac,HCM1_259
inchi2	IncHI2 DLST	smr0018,smr0199
inci1	IncI1 MLST	repI1,ardA,trbA,sogS,pilL
incn	IncN MLST	repN,traJ,korA
pbssb1-family	pBSSB1-family	higB,mqsA,soj
shigella	Shigella flexneri	vapBC,parAB,yacAB

for file in ./*fasta; do
  python3 /home/nlzoh.si/leomar1/program_files/pmlst/pmlst.py -i ${file} -p /home/storage/DB/pmlst_db/ -s incf -o "${file}"
done

