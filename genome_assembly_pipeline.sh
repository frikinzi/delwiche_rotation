

#FastQC 1/12/2024
fastqc -o temp -f fastq 
/home/Kleb/Delwiche_Kleb_Sequencing/Kflagenall_1.fastq.gz 
/home/Kleb/Delwiche_Kleb_Sequencing/Kflagenall_2.fastq.gz

#Trimmomatic 1/12/2024
nice nohup trimmomatic PE -phred33 
/home/Kleb/Delwiche_Kleb_Sequencing/Kflagenall_1.fastq.gz 
/home/Kleb/Delwiche_Kleb_Sequencing/Kflagenall_2.fastq.gz 
Kflagenall_1_trimmed.fastq.gz Kflagenall_2_trimmed.fastq.gz 
SLIDINGWINDOW:4:20 MINLEN:25 ILLUMINACLIP:NexteraPE-PE.fa:2:40:15 -threads 
12

#THIS WORKED - produced paired files that are of the same size
nice nohup trimmomatic PE -phred33 /localhome/akjiang/Coleochaete/Coleochaete/illumina/SID38437_NoIndex_L006_R1_001.fastq.gz /localhome/akjiang/Coleochaete/Coleochaete/illumina/SID38437_NoIndex_L006_R2_001.fastq.gz SID38437_NoIndex_L006_R1_trimmed.fastq.gz SID38437_NoIndex_L006_R1_trimmed_unpaired.fastq.gz SID38437_NoIndex_L006_R2_trimmed.fastq.gz SID38437_NoIndex_L006_R2_trimmed_unpaired.fastq.gz SLIDINGWINDOW:4:20 MINLEN:15 ILLUMINACLIP:TruSeq3-SE.fa:2:40:15:2:TRUE -threads 12

#nice command makes it possible for other people to run computationally intensive tasks while mine is running

#kmer count 1/15/2024
jellyfish count -m 21 -s 100M -t 10 -C <(zcat R1.fq.gz) <(zcat R2.fq.gz)
# want to use smaller kmer for less computation power - less unique 
sequences

#convert to table
jellyfish dump counts.jf -c > counts.tsv

#assembly. note: cat pacbio reads together
nice nohup haslr.py -t 12 -o Assembly -g 117.1m -l /home/Kleb/Delwiche_Kleb_Sequencing/KFLA-1_run2/filtered_subreads.fastq.gz -x pacbio -s Kflagenall_1_paired_trimmed.fastq.gz Kflagenall_2_paired_trimmed.fastq.gz