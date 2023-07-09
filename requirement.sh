#!/bin/bash

echo "#############################"
echo "DOWNLOAD REQUIREMENT FOR VARIANT CALLING"
echo "#############################"
echo " "
echo "REMEMBER TO DOWNLOAD THE CARETTA SEQUENCES AND PUT INSIDE A DIRECTORY CALLED fastq_files"
echo " "

# Download Trimmomatic
echo "DOWNLOAD TRIMMOMATIC"
wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip
unzip Trimmomatic-0.39.zip


# Download latest version SnpEff
echo "DOWNLOAD SNPEFF"
wget https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip
unzip snpEff_latest_core.zip

echo " "
echo "BUILDING CARETTA CARETTA DATABASE!" 

cd snpEff/
mkdir data data/Caretta

cp ../1_VariantCalling/genes.gbk data/Caretta/

echo "#Caretta caretta Mitochondrial genome" >> snpEff.config
echo "Caretta.genome : Caretta" >> snpEff.config
echo "        Caretta.FR694649.1.codonTable : Vertebrate_Mitochondrial" >> snpEff.config

java -jar snpEff.jar build -genbank -v Caretta

cd ../

echo " "
echo "#############################"
echo "TO USE THE MODELLER SCRIPT BEFORE REGISTER FOR THE LICENSE"
echo "https://salilab.org/modeller/registration.html"
echo "#############################"
echo " "
echo "#############################"
echo "FOR MOLECULAR DYNAMICS USE THIS TUTORIAL"
echo "http://www.mdtutorials.com/gmx/membrane_protein/index.html"
echo "#############################"
echo " "
