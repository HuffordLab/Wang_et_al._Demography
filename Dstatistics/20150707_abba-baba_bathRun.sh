#D statistic batch running

# in /home/lwang/lwang/SRA/admixture/allInd/
mkdir RIMMA0409
for f in *bamlist; do cp $f ./RIMMA0409/$f; done
cd RIMMA0409
for f in *bamlist; do sed -i 's/0703/0409/g' $f; done
for f in *bamlist; do echo "./abba-baba.sh $f"; done > angsd.abba-baba.sh

##In /home/lwang/lwang/SRA/admixture/allInd/RIMMA0409
cp abba-baba.sh jackKnife.R JobR.sh ../RIMMA1010
for f in *bamlist; do cp $f ../RIMMA1010/$f; done
cd ../RIMMA1010
for f in *bamlist; do sed -i 's/0409/1010/g' $f; done
for f in *bamlist; do echo "./abba-baba.sh $f"; done > angsd.abba-baba.sh
./JobR.sh 5 angsd.abba-baba.sh

#In /home/lwang/lwang/diploperrennis/Dstatistic
for f in *bamlist; do sed -i 's/SRA\/mexicana\/mexicana\.TIL25/diploperrennis\/diploperennis/g' $f; done




