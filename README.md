# RNA-seq differential expression demonstration

RNA-seq differential expression analysis practical demostration for undergrad students. This demonstration uses data from [Rossini et al, 2019](https://doi.org/10.1093/pcp/pcy240). In short the data comes from _Galdieria sulphuraria_, a polyextremophile unicellular red alga that lives in hot, acidic, toxic metal-rich, volcanic environments, in Rossini's study that alga was expossed to cold stress to investigate the transcriptional changes this stress induced in the alga. Other stuff is evaluated regarding horizontal gene transfer from bacteria/archea to _Galdieria sulphuraria_. **Reading the paper is strongly suggested.** 

In this demonstration a differential expression analysis between a "hot" normal state vs a "cold" state of _Galdieria sulphuraria_ is done. **The goal here is to corroborate some of the observations reported in Rossini's paper**. Take into considerated that 5 out of 25 libraries available from Rossini's data are used in this demonstration 3 from a cold state and 2 from a hot state. 

**Note:** This pipeline is probably far from ideal and is just presented as a good enough demonstration of the concept.

## Requirements
- OS:Linux (Debian, Ubuntu and similar), emulated Linux enviroments should be fine
- Software: [conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html) or [mamba](https://anaconda.org/conda-forge/mamba) package manager, and bash
- Disk space: around 10 Gb
- RAM: 4Gb (estimated), 8Gb should be enough

## How to run in your machine

Some of the bash scripts(".sh" files) have a "threads" variable set to 4, you should change this paramater so it fits all the threads your machine has. The pipeline was tested with 4 threads, ~33 mins of runtime and ~2Gb of RAM usage were recorded . 

### Software setup

First you should download this repository and then open a terminal in the downloaded repository. Then you have to create a conda environment from the .yml file, this environment will contain the software required to run this demonstration. For that you can run the following command:

```
conda env create -f Workshop_conda_environment.yml
```
If you have mamba you may use:

```
mamba env create -f Workshop_conda_environment.yml
```

Before running the next scripts you should activate the created environment with

```
conda activate work_comp
```

### Data download 

#### Genome and annotations
First the genome fasta file and the annotation gtf file of _Galdieria sulphuraria_ is downloaded. This data comes from the following NCBI assembly accession: [GCF_000341285.1](https://www.ncbi.nlm.nih.gov/assembly/GCF_000341285.1/). To do this you can run the following command:

```
bash 1-Download_genome.sh
```
This will create a "genome" folder containing these files:

```
Galdieria_sulphuraria.fasta
Galdieria_sulphuraria.gtf
```
#### RNA-seq data 

Next the RNA-seq pair-end data is downloaded. For this step you need ~7Gb of disk space and it may take quite a while. To do this you can run the following command:

```
2-Download_RNA-seq_data.sh 
```

This will create a "data" folder containing these files:

```
SRR7734599_GSM3349831_Cold_T12_3_Rep_A_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz
SRR7734599_GSM3349831_Cold_T12_3_Rep_A_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz
SRR7734600_GSM3349832_Cold_T12_3_Rep_B_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz
SRR7734600_GSM3349832_Cold_T12_3_Rep_B_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz
SRR7734601_GSM3349833_Cold_T12_3_Rep_C_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz
SRR7734601_GSM3349833_Cold_T12_3_Rep_C_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz
SRR7734607_GSM3349839_Hot_T12_6_Rep_A_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz
SRR7734607_GSM3349839_Hot_T12_6_Rep_A_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz
SRR7734608_GSM3349840_Hot_T12_6_Rep_B_Galdieria_sulphuraria_RNA-Seq_1.fastq.gz
SRR7734608_GSM3349840_Hot_T12_6_Rep_B_Galdieria_sulphuraria_RNA-Seq_2.fastq.gz

```
## RNA-seq data Quality Control (QC)

After completing RNA-seq data download some Quality control of the data is advised, for this fastqc and Multiqc fit this purpose well. To do the quality control you can run the following command:

```
bash 3-QC_RNA-seq_data.sh
```
This will create a "qc" folder and within it a "multiqc" folder(among other files) containing these files:

```
multiqc_data
multiqc_report.html
```
The importan file is "multiqc_report.html" which summarizes all the quality control metrics from the RNA-seq fastq files.


## RSEM reference preparation

In this step a reference needed to run RSEM and bowtie2 is created. To do this you can run the following command:

```
4-RSEM_reference.sh

```
This will create a "rsem_ref" folder containing the reference files created from the genome file and the annotation file. 


## RSEM gene count generation

In this step RSEM with the aid of bowtie2 aligns the RNA-seq reads to the genome and then generates gene counts. This step is the most computationally intensive of the whole pipeline so it will take quite a while, patience is adviced. To do this step you can run the following command:

```
bash 5-RSEM_run.sh
```
This will create a "rsem_run" folder containing gene count results, in particular .genes.results files contain the data used in the next step:

## DEseq2 differential expression detection

In this step a reference needed to run RSEM and bowtie2 is created. To do this you can run the following command:

```
bash 6-DEseq2_run.sh
```
This will create a "DEseq" folder. In this folder, the most important are "qc" and "out". The first one will contain the QC of the libraries confirming the validity of the analysis. The second one contains the differential gene expression results, in particular "differential_expression.csv"

## Note

This workshop was heavily inspired by NASA's[GeneLab bioinformatics processing pipeline for Illumina RNA-sequencing data](https://github.com/nasa/GeneLab_Data_Processing/tree/master/RNAseq) and this [Differential gene expression workshop](https://github.com/hbctraining/DGE_workshop)

## References

  Alessandro W Rossoni, Gerald Schönknecht, Hyun Jeong Lee, Ryan L Rupp, Samantha Flachbart, Tabea Mettler-Altmann, Andreas P M Weber, Marion Eisenhut. Cold Acclimation of the Thermoacidophilic Red Alga Galdieria sulphuraria: Changes in Gene Expression and Involvement of Horizontally Acquired Genes, _Plant and Cell Physiology_, Volume 60, Issue 3, March 2019, Pages 702–712, https://doi.org/10.1093/pcp/pcy240


