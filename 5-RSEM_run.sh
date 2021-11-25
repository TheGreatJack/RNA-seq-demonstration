#!/usr/bin/env bash

threads=4
env="work_comp"
source activate $env

mkdir rsem_out

## Cold

rsem-calculate-expression -p $threads --paired-end --bowtie2 --seed 12345 --estimate-rspd --no-bam-output --strandedness reverse ./data/SRR7734601_GSM3349833_Cold_T12_3_Rep_C_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ./data/SRR7734601_GSM3349833_Cold_T12_3_Rep_C_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ./rsem_ref/Galdieria_sulphuraria_rsem ./rsem_out/T12_3_Rep_C

rsem-calculate-expression -p $threads --paired-end --bowtie2 --seed 12345 --estimate-rspd --no-bam-output --strandedness reverse ./data/SRR7734599_GSM3349831_Cold_T12_3_Rep_A_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ./data/SRR7734599_GSM3349831_Cold_T12_3_Rep_A_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ./rsem_ref/Galdieria_sulphuraria_rsem ./rsem_out/T12_3_Rep_A

rsem-calculate-expression -p $threads --paired-end --bowtie2 --seed 12345 --estimate-rspd --no-bam-output --strandedness reverse ./data/SRR7734600_GSM3349832_Cold_T12_3_Rep_B_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ./data/SRR7734600_GSM3349832_Cold_T12_3_Rep_B_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ./rsem_ref/Galdieria_sulphuraria_rsem ./rsem_out/T12_3_Rep_B


## Hot

rsem-calculate-expression -p $threads --paired-end --bowtie2 --seed 12345 --estimate-rspd --no-bam-output --strandedness reverse ./data/SRR7734607_GSM3349839_Hot_T12_6_Rep_A_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ./data/SRR7734607_GSM3349839_Hot_T12_6_Rep_A_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ./rsem_ref/Galdieria_sulphuraria_rsem ./rsem_out/T12_6_Rep_A

rsem-calculate-expression -p $threads --paired-end --bowtie2 --seed 12345 --estimate-rspd --no-bam-output --strandedness reverse ./data/SRR7734608_GSM3349840_Hot_T12_6_Rep_B_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz ./data/SRR7734608_GSM3349840_Hot_T12_6_Rep_B_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz ./rsem_ref/Galdieria_sulphuraria_rsem ./rsem_out/T12_6_Rep_B