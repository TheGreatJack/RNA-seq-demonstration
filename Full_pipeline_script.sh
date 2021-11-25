#!/usr/bin/env bash

threads=4
env="work_comp"

source activate $env

## Descarga de genoma y anotacion

mkdir ./genome

wget -O ./genome/Galdieria_sulphuraria.fasta.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/341/285/GCF_000341285.1_ASM34128v1/GCF_000341285.1_ASM34128v1_genomic.fna.gz
wget -O ./genome/Galdieria_sulphuraria.gtf.gz https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/341/285/GCF_000341285.1_ASM34128v1/GCF_000341285.1_ASM34128v1_genomic.gtf.gz

gzip -d ./genome/*


## Descarga de datos de expresion

#mkdir data

#wget -O ./data/SRR7734601_GSM3349833_Cold_T12_3_Rep_C_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR773/001/SRR7734601/SRR7734601_1.fastq.gz 
#wget -O ./data/SRR7734601_GSM3349833_Cold_T12_3_Rep_C_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR773/001/SRR7734601/SRR7734601_2.fastq.gz 
#wget -O ./data/SRR7734599_GSM3349831_Cold_T12_3_Rep_A_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR773/009/SRR7734599/SRR7734599_1.fastq.gz 
#wget -O ./data/SRR7734599_GSM3349831_Cold_T12_3_Rep_A_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR773/009/SRR7734599/SRR7734599_2.fastq.gz 
#wget -O ./data/SRR7734607_GSM3349839_Hot_T12_6_Rep_A_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR773/007/SRR7734607/SRR7734607_1.fastq.gz 
#wget -O ./data/SRR7734607_GSM3349839_Hot_T12_6_Rep_A_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR773/007/SRR7734607/SRR7734607_2.fastq.gz 
#wget -O ./data/SRR7734600_GSM3349832_Cold_T12_3_Rep_B_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR773/000/SRR7734600/SRR7734600_1.fastq.gz 
#wget -O ./data/SRR7734600_GSM3349832_Cold_T12_3_Rep_B_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR773/000/SRR7734600/SRR7734600_2.fastq.gz 
#wget -O ./data/SRR7734608_GSM3349840_Hot_T12_6_Rep_B_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR773/008/SRR7734608/SRR7734608_1.fastq.gz 
#wget -O ./data/SRR7734608_GSM3349840_Hot_T12_6_Rep_B_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR773/008/SRR7734608/SRR7734608_2.fastq.gz 


## QC RNA-seq



## Se crea carpeta pal output

# Comando pal fastqc
mkdir qc
fastqc -t $threads -o qc/ data/*.fastq.gz

# Comando pal multiqc en la carpeta donde estan todos los fastqc results

mkdir qc/multiqc

multiqc ./qc/ -o ./qc/multiqc/


## Rsem ref

mkdir rsem_ref

rsem-prepare-reference --gtf ./genome/Galdieria_sulphuraria.gtf --bowtie2 ./genome/Galdieria_sulphuraria.fasta ./rsem_ref/Galdieria_sulphuraria_rsem


## Rsem run

mkdir rsem_out

## Cold

rsem-calculate-expression -p $threads --paired-end --bowtie2 --seed 12345 --estimate-rspd --no-bam-output --strandedness reverse ./data/SRR7734601_GSM3349833_Cold_T12_3_Rep_C_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ./data/SRR7734601_GSM3349833_Cold_T12_3_Rep_C_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ./rsem_ref/Galdieria_sulphuraria_rsem ./rsem_out/T12_3_Rep_C

rsem-calculate-expression -p $threads --paired-end --bowtie2 --seed 12345 --estimate-rspd --no-bam-output --strandedness reverse ./data/SRR7734599_GSM3349831_Cold_T12_3_Rep_A_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ./data/SRR7734599_GSM3349831_Cold_T12_3_Rep_A_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ./rsem_ref/Galdieria_sulphuraria_rsem ./rsem_out/T12_3_Rep_A

rsem-calculate-expression -p $threads --paired-end --bowtie2 --seed 12345 --estimate-rspd --no-bam-output --strandedness reverse ./data/SRR7734600_GSM3349832_Cold_T12_3_Rep_B_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ./data/SRR7734600_GSM3349832_Cold_T12_3_Rep_B_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ./rsem_ref/Galdieria_sulphuraria_rsem ./rsem_out/T12_3_Rep_B


## Hot

rsem-calculate-expression -p $threads --paired-end --bowtie2 --seed 12345 --estimate-rspd --no-bam-output --strandedness reverse ./data/SRR7734607_GSM3349839_Hot_T12_6_Rep_A_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ./data/SRR7734607_GSM3349839_Hot_T12_6_Rep_A_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ./rsem_ref/Galdieria_sulphuraria_rsem ./rsem_out/T12_6_Rep_A

rsem-calculate-expression -p $threads --paired-end --bowtie2 --seed 12345 --estimate-rspd --no-bam-output --strandedness reverse ./data/SRR7734608_GSM3349840_Hot_T12_6_Rep_B_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ./data/SRR7734608_GSM3349840_Hot_T12_6_Rep_B_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ./rsem_ref/Galdieria_sulphuraria_rsem ./rsem_out/T12_6_Rep_B


# Deseq2 script

mkdir ./DEseq/qc
mkdir ./DEseq/out
mkdir ./DEseq/norm_counts

Rscript deseq2_mod.R





