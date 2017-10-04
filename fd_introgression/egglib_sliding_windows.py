#!/usr/bin/env python

# egglib_sliding_windows.py
# calculate ABBA-BABA stats, dxy, pi and S for sliding windows in genomic data

# Written for "Evaluating the use of ABBA-BABA statistics to locate introgressed loci"
# by Simon H. Martin, John W. Davey and Chris D. Jiggins
# Simon Martin: shm45@cam.ac.uk
# John Davey:   jd626@cam.ac.uk
# August 2014



import sys

import egglib

def getOptionValue(option): # needs sys
  if option in sys.argv:
    optionPos = sys.argv.index(option)
    optionValue = sys.argv[optionPos + 1]
    return optionValue
  else:
    print >> sys.stderr, "\nWarning, option", option, "not_specified.\n"


def get_intv(string,borders = "()",inc = False):
  if len(borders) != 2:
    print "WARNING: borders must contain two characters"
  starts = []
  ends = []
  output = []
  for x in range(len(string)):
    if string[x] == borders[0]:
      starts.append(x)
    if string[x] == borders[1]:
      ends.append(x+1)
  if len(starts) <= len(ends):
    for n in range(len(starts)):
      if inc:
        output.append(string[starts[n]:ends[n]])
      else:
        output.append(string[starts[n]+1:ends[n]-1])
  else:
    for n in range(len(ends)):
      if inc:
        output.append(string[starts[n]:ends[n]])
      else:
        output.append(string[starts[n]+1:ends[n]-1])
  return output

def median(numbers):
  numbers.sort()
  if len(numbers) % 2 == 1:
    return numbers[(len(numbers)+1)/2-1]
  else:
    lower = numbers[len(numbers)/2-1]
    upper = numbers[len(numbers)/2]
    return (float(lower + upper)) / 2

def haplo(calls):
  output = []
  for call in calls:
    if call in "ACGTN":
      output.append(call)
      output.append(call)
    elif call == "K":
      output.append("G")
      output.append("T")
    elif call == "M":
      output.append("A")
      output.append("C")
    elif call == "R":
      output.append("A")
      output.append("G")
    elif call == "S":
      output.append("C")
      output.append("G")
    elif call == "W":
      output.append("A")
      output.append("T")
    elif call == "Y":
      output.append("C")
      output.append("T")
    else:
      print "WARNING", call, "is not recognised as a valid base or ambiguous base"
      output.append("N")
      output.append("N")
  return output

def mean(numbers):
  numbers = [float(n) for n in numbers if n != "NA" and n != None]
  numSum = sum(numbers)
  if len(numbers) >= 1:
    return float(numSum)/len(numbers)
  else:
    return "NA"

def mid(numbers):
  numbers = [float(n) for n in numbers if n != "NA" and n != None]
  if len(numbers) >= 1:
    return (numbers[0] + numbers[-1])/2
  else:
    return None

def AlignByGroupNumber(align,groupNumber):
  newAlign = align.slice(0,0)
  for seqNumber in range(len(align)):
    if align[seqNumber][2] == groupNumber:
      newAlign.addSequences([align[seqNumber]])
  return newAlign

def AlignByGroupNumbers(align,groupNumbers):
  newAlign = align.slice(0,0)
  for seqNumber in range(len(align)):
    if align[seqNumber][2] in groupNumbers:
      newAlign.addSequences([align[seqNumber]])
  return newAlign

def mostCommon(things):
  output = []
  counts = []
  uniqueThings = unique(things)
  for thing in uniqueThings:
    counts.append(things.count(thing))
  maxCount = max(counts)
  for n in range(len(counts)):
    if counts[n] == maxCount:
      output.append(uniqueThings[n])
  return output

def unique(things):
  output = list(set(things))
  output.sort()
  return output


def dxy(align): # "align" if the egglib alignment object, this consistes of sequences, sequence names and "groups". If the object contains two groups, the function will consider only the first two.
    
    # retrieve group names from the alignment object
    pops = align.groups().keys()
    
    # retrieve all the positions of sequences in group 1
    P1 = [i for i in range(len(align)) if align.group(i)==pops[0]]
    
    # retrieve all the positions of sequences in group 2
    P2 = [i for i in range(len(align)) if align.group(i)==pops[1]]
    
    pairwiseSum = 0 #total of pairwise Pis
    totalPairs = 0 #haplotype pairs considered
    
    for i in P1: # for each sequence in pop1...
      for j in P2: #for sequence in pop2...
        seqA = align[i][1]
        seqB = align[j][1]
        zippedSeqs = zip(seqA,seqB)
        diffs = sum(sA != sB for sA, sB in zippedSeqs if sA != "N" and sB != "N")
        #sites = sum(sA != "N" and sB != "N" for sA, sB in zippedSeqs)
        sites = len([site for site in zippedSeqs if site[0] != "N" and site[1] != "N"])
        #now add this pairwise dxy to the total and add 1 to the number of pairs considered
        pairwiseSum += 1.0*diffs/sites
        totalPairs += 1     
    #after considering all positions for each pair of haplotypes, return the average pairwise pi
    return pairwiseSum/totalPairs


def px(align):
    
    pairwiseSum = 0 #total of pairwise Pis
    totalPairs = 0 #haplotype pairs considered
    
    for i in range(len(align) - 1): # for each sequence except the last one...
      for j in range(i + 1,len(align)): #for each of the remaining sequences from sequence i + 1 to the end of the alignment... 
        seqA = align[i][1]
        seqB = align[j][1]
        zippedSeqs = zip(seqA,seqB)
        diffs = sum(sA != sB for sA, sB in zippedSeqs if sA != "N" and sB != "N")
        #sites = sum(sA != "N" and sB != "N" for sA, sB in zippedSeqs)
        sites = len([site for site in zippedSeqs if site[0] != "N" and site[1] != "N"])
        #now add this pairwise pi to the total and add 1 to the number of pairs considered
        pairwiseSum += 1.0*diffs/sites
        totalPairs += 1
                  
    #after considering all positions for each pair of haplotypes, return the average pairwise pi
    return pairwiseSum/totalPairs


def colFreqs(align, columnNumber):
  bases = align.column(columnNumber)
  Acount = float(bases.count("A"))
  Ccount = float(bases.count("C"))
  Gcount = float(bases.count("G"))
  Tcount = float(bases.count("T"))
  total = Acount + Ccount + Gcount + Tcount
  if total > 0:
    output = {}
    output["A"] = Acount/total
    output["C"] = Ccount/total
    output["G"] = Gcount/total
    output["T"] = Tcount/total
  else:
    output = {"A":None, "C":None, "G":None, "T":None}
  return output

def colBaseCounts(align, columnNumber):
  output = {}
  bases = align.column(columnNumber)
  Acount = float(bases.count("A"))
  Ccount = float(bases.count("C"))
  Gcount = float(bases.count("G"))
  Tcount = float(bases.count("T"))
  output["A"] = Acount
  output["C"] = Ccount
  output["G"] = Gcount
  output["T"] = Tcount
  return output


#version using frequencies to calculate fhom and fd
def ABBABABA(align, P1, P2, P3, P4, P3a = None, P3b = None):
  p1Align = AlignByGroupNumber(align,P1)
  p2Align = AlignByGroupNumber(align,P2)
  p3Align = AlignByGroupNumber(align,P3)
  p4Align = AlignByGroupNumber(align,P4)
  if P3a == None or P3b == None:
    p3Half = len(p3Align)/2
    p3aAlign = p3Align.slice(0,p3Half)
    p3bAlign = p3Align.slice(p3Half,len(p3Align))
  else:
    p3aAlign = AlignByGroupNumber(align,P3a)
    p3bAlign = AlignByGroupNumber(align,P3b)
  ABBAsum = 0.0
  BABAsum = 0.0
  ABBAsumG = 0.0
  BABAsumG = 0.0
  maxABBAsumG = 0.0
  maxBABAsumG = 0.0
  maxABBAsumHom = 0.0
  maxBABAsumHom = 0.0
  maxABBAsumD = 0.0
  maxBABAsumD = 0.0
  #get derived frequencies for all biallelic siites
  for i in align.polymorphism(minimumExploitableData = 0)["siteIndices"]:
    #skip this site if not biallelic
    bases = [base for base in align.column(i) if base != "N"]
    alleles = unique(bases)
    if len(alleles) != 2: continue
    #get derived state
    #if the outgroup is fixed, then that is the ancestral state - otherwise the anc state is the most common allele overall
    p4Alleles = unique([base for base in p4Align.column(i) if base != "N"])
    if len(p4Alleles) == 1:
      derived = [a for a in alleles if a != p4Alleles[0]][0]
    else:
      derived = [a for a in alleles if a != mostCommon(bases)[0]][0]
    # get frequencies for wach pop
    p1Freq = colFreqs(p1Align, i)[derived]
    p2Freq = colFreqs(p2Align, i)[derived]
    p3Freq = colFreqs(p3Align, i)[derived]
    p4Freq = colFreqs(p4Align, i)[derived]
    p3aFreq = colFreqs(p3aAlign, i)[derived]
    p3bFreq = colFreqs(p3bAlign, i)[derived]
    # get weigtings for ABBAs and BABAs
    #only use this site if we have frequencies for all pops
    try:
      ABBAsum += (1 - p1Freq) * p2Freq * p3Freq * (1 - p4Freq)
      BABAsum += p1Freq * (1 - p2Freq) * p3Freq * (1 - p4Freq)
      maxABBAsumHom += (1 - p1Freq) * p3Freq * p3Freq * (1 - p4Freq)
      maxBABAsumHom += p1Freq * (1 - p3Freq) * p3Freq * (1 - p4Freq)
      if p3Freq >= p2Freq:
        maxABBAsumD += (1 - p1Freq) * p3Freq * p3Freq * (1 - p4Freq)
        maxBABAsumD += p1Freq * (1 - p3Freq) * p3Freq * (1 - p4Freq)
      else:
        maxABBAsumD += (1 - p1Freq) * p2Freq * p2Freq * (1 - p4Freq)
        maxBABAsumD += p1Freq * (1 - p2Freq) * p2Freq * (1 - p4Freq)
    except:
      continue
    
    try:
      maxABBAsumG += (1 - p1Freq) * p3aFreq * p3bFreq * (1 - p4Freq)
      maxBABAsumG += p1Freq * (1 - p3aFreq) * p3bFreq * (1 - p4Freq)
      ABBAsumG += (1 - p1Freq) * p2Freq * p3Freq * (1 - p4Freq)
      BABAsumG += p1Freq * (1 - p2Freq) * p3Freq * (1 - p4Freq)
    except:
      continue
  #calculate D, f and fb
  output = {}
  try:
    output["D"] = (ABBAsum - BABAsum) / (ABBAsum + BABAsum)
  except:
    output["D"] = "NA"
  try:
    output["fG"] = (ABBAsumG - BABAsumG) / (maxABBAsumG - maxBABAsumG)
  except:
    output["fG"] = "NA"
  try:
    output["fhom"] = (ABBAsum - BABAsum) / (maxABBAsumHom - maxBABAsumHom)
  except:
    output["fhom"] = "NA"
  try:
    output["fd"] = (ABBAsum - BABAsum) / (maxABBAsumD - maxBABAsumD)
  except:
    output["fd"] = "NA"
  output["ABBA"] = ABBAsum
  output["BABA"] = BABAsum
  
  return output

#***************************************************************************************************************


if "--stop-at" in sys.argv:
  stopAt = True
  stopVal = int(getOptionValue("--stop-at"))
else:
  stopAt = False

if "--test" in sys.argv:
  test = True
else:
  test = False

if "--verbose" in sys.argv:
  verbose = True
else:
  verbose = False

if "--report" in sys.argv:
  report = int(getOptionValue("--report"))
else:
  report = 100
nextReport = report


if "-i" in sys.argv:
  fileName = getOptionValue("-i")
else:
  print "\nplease specify input file name using -i <file_name> \n"
  sys.exit()

file = open(fileName, "rU")
#define names from header line (file must have a header)
line = file.readline()
names = line.split()
line= file.readline()


if "-p" in sys.argv:
  popStrings = getOptionValue("-p")
else:
  print "\nplease specify populations using -p\n"
  sys.exit()



popNames = []
indNames = []
#for each pattern, store the name, the set of lists, the maximum Ns and the maximum mismatches
for popString in popStrings.strip("\"").split(";"):
  currentPop = popString.split("[")[0]
  popNames.append(currentPop)
  vars()[currentPop] = get_intv(popString,"[]")[0].split(",")
  for indName in vars()[currentPop]:
    if indName in names:
      if indName not in indNames:
        indNames.append(indName)
    else:
      print "individual " + indName + "not found in header line."
      sys.exit()

if "-O" in sys.argv:
  includeOutGroup = True
  outGroupString = getOptionValue("-O").strip("\"")
  outGroup = outGroupString.split("[")[0]
  vars()[outGroup] = get_intv(outGroupString,"[]")[0].split(",")
  for indName in vars()[outGroup]:
    if indName in names:
      indNames.append(indName)
    else:
      print "individual " + indName + "not found in header line."
      sys.exit()
else:
  includeOutGroup = False
  

if test or verbose:
  print "\nPopulations:\n"
  for popName in popNames:
    print popName
    print vars()[popName]
    print "\n"
  if includeOutGroup:
    print "\nOut-Group:\n"
    print outGroup
    print vars()[outGroup]
    print "\n"

#set up a variable that reports the ploidy for each individual

ploidy = {}

if "--ploidy" in sys.argv:
  ploidyNumbers = getOptionValue("--ploidy").strip("\"").split(",")
  ploidyNumbers = [int(n) for n in ploidyNumbers if n == "1" or n == "2"]
  if len(ploidyNumbers) == len(indNames):
    print "\nPloidy is as follows:\n"
    for x in range(len(indNames)):
      ploidy[indNames[x]] = ploidyNumbers[x]
      print indNames[x], ploidyNumbers[x]
  else:
    print "\nSpecify ploidy for each individual as 1 or 2, separated by commas\n"
    sys.exit()
else:
  #if ploidy is not specified, assume diploid
  for indName in indNames:
      ploidy[indName] = 2


if "-o" in sys.argv:
  outName = getOptionValue("-o")
else:
  print "\nplease specify output file name using -o <file_name> \n"
  sys.exit()


if "-w" in sys.argv:
  windSize = int(getOptionValue("-w"))
else:
  print "\nplease specify window size using -w \n"
  sys.exit()

if "-s" in sys.argv:
  slide = int(getOptionValue("-s"))
else:
  print "\nplease specify slide length using -s \n"
  sys.exit()

if "-m" in sys.argv:
  minSites = int(getOptionValue("-m"))
else:
  print "\nplease specify the minimum number of sites per window using -m\n"
  sys.exit()


allScafs = True
include = False
exclude = False


if "-S" in sys.argv:
  scafsToInclude = getOptionValue("-S").strip("\"").split(",")
  if test or verbose:
      print "scaffolds to analyse:", scafsToInclude
  allScafs = False
  include = True


if "--include" in sys.argv:
  scafsFileName = getOptionValue("--include")
  scafsFile = open(scafsFileName, "rU")
  scafsToInclude = [line.rstrip() for line in scafsFile.readlines()]
  if test or verbose:
      print len(scafsToInclude), "scaffolds will be included"
  allScafs = False
  include = True



if "--exclude" in sys.argv:
  scafsFileName = getOptionValue("--exclude")
  scafsFile = open(scafsFileName, "rU")
  scafsToExclude = [line.rstrip() for line in scafsFile.readlines()]
  if test or verbose:
      print len(scafsToExclude), "scaffolds will be excluded."
  allScafs = False
  exclude = True


if "--chromosome" in sys.argv:
  chroms = getOptionValue("--chromosome").split(",")
  checkChrom = True
  allScafs = False
  if test or verbose:
    print "\nOnly using scafolds from the following chromosomes:"
    print chroms
  if "--assignments" not in sys.argv:
    print "\nPlease provide a chromosome assignments file using '--assignments'."
    sys.exit()
else:
  checkChrom = False

if checkChrom and "--assignments" in sys.argv:
  chromsFileName = getOptionValue("--assignments")
  chromsFile = open(chromsFileName, "rU")
  chromsLines = chromsFile.readlines()
  chromDict = {}
  for chromsLine in chromsLines:
    scaf,chrom = chromsLine.rstrip().split()
    chromDict[scaf] = chrom



if "--sep" in sys.argv:
  if getOptionValue("--sep") == "comma":
    sep = ","
  elif getOptionValue("--sep") == "white":
    sep = None
  else:
    print "\nThe only options for --sep are [comma] or [white] \n"
    sys.exit()
    
else:
  sep = None

# start output file
mainOut = open(outName, "w")
mainOut.write("scaffold,position,start,end,midpoint,sites,sitesOverMinExD")

#check analyses
analyses = []
poly = True
popPoly = False
pairWisePoly = False
if "-a" in sys.argv:
  analysesList = getOptionValue("-a").strip("\"").split(",")
  if "S" in analysesList:
    poly = True
    analyses.append("S")
    mainOut.write(",S")
  if "pi" in analysesList:
    popPoly = True
    analyses.append("pi")
    for popName in popNames:
      mainOut.write("," + popName + "_pi")
  if "popS" in analysesList:
    popPoly = True
    analyses.append("popS")
    for popName in popNames:
      mainOut.write("," + popName + "_S")
  if "dxy" in analysesList:
    pairWisePoly = True
    analyses.append("dxy")
    for X in range(len(popNames) - 1):
      for Y in range(X + 1,len(popNames)):
        mainOut.write("," + popNames[X] + "_" + popNames[Y] + "Dxy")
  if "ABBABABA" in analysesList:
    if "P1" in popNames and "P2" in popNames and "P3" in popNames and "O" in popNames:
      analyses.append("ABBABABA")
      mainOut.write(",ABBA,BABA,D,fG,fhom,fd")
    else:
      print "\nPopulation names P1, P2, P3 and O must be present to do ABBA BABA analyses.\n"
      sys.exit()
  mainOut.write("\n")
else:
  print "\nplease specify analysis to be conducted (-a)\n"
  sys.exit()

if analyses == []:
  print "\nplease check analysis options\n"
  sys.exit()
else:
  print >> sys.stderr, "\nAnalyses to be included:\n"
  for a in analyses:
    print >> sys.stderr, a , "\n"




if "--ignoreFrequency" in sys.argv:
  iF = int(getOptionValue("--ignoreFrequency"))
else:
  iF = 0

if "--minimumExploitableData" in sys.argv:
  minExD = float(getOptionValue("--minimumExploitableData"))
  print "minimumExploitableData =", minExD
else:
  minExD = 0




# counting stat that will let keep track of how far we are
windowsTested = 0
goodWindows = 0

#create temporary  variables for nucleotide data
for name in indNames: 
  vars()["sub" + name] = []

#For the tempoarary window we need to store the positions each time to keep track of the spread of the sites 
subPos = []


#read first line and store variables
line = file.readline().rstrip()
objects = line.split(sep)
if allScafs or (checkChrom and objects[0] in chromDict and chromDict[objects[0]] in chroms) or (include and objects[0] in scafsToInclude) or (exclude and objects[0] not in scafsToExclude):
  subSCF = objects[0]
  subPos.append(int(objects[1]))
  for name in indNames:
    vars()["sub" + name].append(objects[names.index(name)])
else:
  subSCF = None

#read second line as the first to be evaluated by the loop
line = file.readline()
objects = line.split(sep)

windStart = 1
lastWindNA = False

while True:
  #each time we do the loop we will be doing one window. 
  #if the line in hand is not yet too far away or on another scaffold, add the line and read another
  if allScafs or subSCF is not None:
    windowsTested += 1
  while len(objects) > 1 and objects[0] == subSCF and int(objects[1]) < windStart + windSize:
    subPos.append(int(objects[1]))
    
    for indName in indNames:
      vars()["sub" + indName].append(objects[names.index(indName)])
    
    line = file.readline()
    objects = line.split(sep)
    
  #now the line in hand is incompatible with the current window
  #if there are enough sites, we calculate stats and then slide the start along
  
  if len(subPos) >= minSites and subSCF is not None:
    
    if test or verbose:
      print "\nGood window found. Length =", len(subPos), len(vars()["sub" + indNames[0]])
    
    # add data to major outputs
    Sites = str(len(subPos))
    Scaf = (subSCF)
    Position = str(windStart + (windSize - 1)/2)
    Start = str(windStart)
    End = str(windStart + windSize)
    if mid(subPos):
      Midpoint = str(int(round(mid(subPos))))
    else:
      Midpoint = "NA"
    
    #if if diplois, split into haplos, if haploid, leave it
    for indName in indNames:
      if ploidy[indName] == 2:
        #its diploid, so split into two haplotypes
        vars()["haplo" + indName] = haplo(vars()["sub" + indName])
        vars()[indName + "A"] = vars()["haplo" + indName][::2]
        vars()[indName + "B"] = vars()["haplo" + indName][1::2]
        #if haploid, the haplotype is the same as the calls we've collected
      elif ploidy[indName] == 1:
        vars()[indName + "A"] = vars()["sub" + indName]
    # this section is for working with haplotypes separated by a | which means it must all be diploid
    
    if test or verbose:
      print "\nHaplotypes generated. Length = ", len(vars()[indNames[1] + "A"])
    
    #create sequence objects for egglib, for all data types necessary, taking poidy into account
    #first step is to create variables for all haps and each pop which will contain a tuple for each haplotype
    allHaps = []
    for popNumber in range(len(popNames)):
      vars()[popNames[popNumber] + "Haps"] = []
      for indName in vars()[popNames[popNumber]]:
        #first, if its haploid, add only one haplotype, else add 2
        if ploidy[indName] == 1:
          hapA = (indName + "A", "".join(vars()[indName + "A"]), popNumber)
          allHaps.append(hapA)
          vars()[popNames[popNumber] + "Haps"].append(hapA)
        else:
          hapA = (indName + "A", "".join(vars()[indName + "A"]), popNumber)
          hapB = (indName + "B", "".join(vars()[indName + "B"]), popNumber)
          allHaps.append(hapA)
          allHaps.append(hapB)
          vars()[popNames[popNumber] + "Haps"].append(hapA)
          vars()[popNames[popNumber] + "Haps"].append(hapB)
    
    #now create egglib align objects for all of these sets of tuples
    # for whole set, for each pop and for pairs of pops and single inds if necessary
    allAlign = egglib.Align.create(allHaps)
    for popName in popNames:
      vars()[popName + "Align"] = egglib.Align.create(vars()[popName + "Haps"])
        
    if pairWisePoly:
      for X in range(len(popNames) - 1):
        for Y in range(X + 1,len(popNames)):
          vars()[popNames[X] + popNames[Y] + "Haps"] = []
          for hap in vars()[popNames[X] + "Haps"]:
            vars()[popNames[X] + popNames[Y] + "Haps"].append(hap)
          for hap in vars()[popNames[Y] + "Haps"]:
            vars()[popNames[X] + popNames[Y] + "Haps"].append(hap)
          vars()[popNames[X] + popNames[Y] + "Align"] = egglib.Align.create(vars()[popNames[X] + popNames[Y] + "Haps"])
        
    if test or verbose:
      print "\negglib alignments generated:"
      print "alignment length:", allAlign.ls(), "number of sequences:", allAlign.ns()
    
    
    #depending on analyses requested, run analyses...
    if poly:
      if test or verbose:
        print "\nrunning polymorphism analyses" 
      allPoly = allAlign.polymorphism(minimumExploitableData=minExD,allowMultipleMutations=True,ignoreFrequency=iF)
    if popPoly:
      if test or verbose:
        print "\nrunning population-specific polymorphism analyses"
      for popName in popNames:
        vars()[popName + "Poly"] = vars()[popName + "Align"].polymorphism(minimumExploitableData=minExD,allowMultipleMutations=True,ignoreFrequency=iF)
    if pairWisePoly:
      if test or verbose:
        print "\nrunning pair-wise polymorphism analyses"
      for X in range(len(popNames) - 1):
        for Y in range(X + 1,len(popNames)):
          vars()[popNames[X] + popNames[Y] + "Poly"] = vars()[popNames[X] + popNames[Y] + "Align"].polymorphism(minimumExploitableData=minExD,allowMultipleMutations=True,ignoreFrequency=iF)
    
    
    #sites passing minExD threshold
    SitesOverMinExD = str(allPoly["lseff"])
    
    #write data to main output
    mainOut.write(Scaf + "," + Position + "," + Start + "," + End + "," + Midpoint + "," + Sites + "," + SitesOverMinExD)
    
    
    if "S" in analyses:
      mainOut.write("," + str(allPoly["S"]))
          
    if "pi" in analyses:
      for popName in popNames:
        if vars()[popName + "Poly"]["lseff"] >= minSites:
          try:
            mainOut.write("," +  str(round(px(vars()[popName + "Align"]),4)))
          except:
            mainOut.write(",NA")
        else:
          mainOut.write(",NA")
        
    if "popS" in analyses:
      for popName in popNames:
        if vars()[popName + "Poly"]["lseff"] >= minSites:
          mainOut.write("," + str(float(vars()[popName + "Poly"]["S"])))
        else:
          mainOut.write(",NA")
    
    if "dxy" in analyses:
      for X in range(len(popNames) - 1):
        for Y in range(X + 1,len(popNames)):
          if vars()[popNames[X] + popNames[Y] + "Poly"]["lseff"] >= minSites:
            try:
              mainOut.write("," +  str(round(dxy(vars()[popNames[X] + popNames[Y] + "Align"]),4)))
            except:
              mainOut.write(",NA")
          else:
            mainOut.write(",NA")
    
    if "ABBABABA" in analyses:
      try:
        if "P3a" in popNames and "P3b" in popNames:
          ABstats = ABBABABA(allAlign, popNames.index("P1"), popNames.index("P2"), popNames.index("P3"), popNames.index("O"), popNames.index("P3a"), popNames.index("P3b"))
        else:
          ABstats = ABBABABA(allAlign, popNames.index("P1"), popNames.index("P2"), popNames.index("P3"), popNames.index("O"))
      except:
        ABstats = {"ABBA":"NA", "BABA":"NA", "D":"NA", "fG":"NA", "fhom":"NA", "fd":"NA"}
      mainOut.write("," + str(ABstats["ABBA"]))
      mainOut.write("," + str(ABstats["BABA"]))
      mainOut.write("," + str(ABstats["D"]))
      mainOut.write("," + str(ABstats["fG"]))
      mainOut.write("," + str(ABstats["fhom"]))
      mainOut.write("," + str(ABstats["fd"]))
    
    
    mainOut.write("\n")
    
    
    goodWindows += 1
    
    if test:
      break
    
    
    if stopAt:
      if stopVal == goodWindows:
        break
    
    lastWindNA = False
    
    windStart += slide
    i = len(subPos)
    for x in subPos:
      if x >= windStart:
        i = subPos.index(x)
        break
    subPos = subPos[i:]
    
    for name in indNames:
      vars()["sub" + name] = vars()["sub" + name][i:]
  
  #otherwise, if the last window as not NA, we will make an NA window and then we'll slide along (or reset if we're onto a new scaf
  else:
    if subSCF is not None and lastWindNA == False:
      Sites = str(len(subPos))
      SitesOverMinExD = "NA"
      Scaf = (subSCF)
      Position = str(windStart + (windSize-1)/2)
      Start = str(windStart)
      End = str(windStart + windSize)
      if mid(subPos):
        Midpoint = str(int(round(mid(subPos))))
      else:
        Midpoint = "NA"
      
      mainOut.write(Scaf + "," + Position + "," + Start + "," + End + "," + Midpoint + "," + Sites + "," + SitesOverMinExD)
      
      #Fill in NAs for all requested data
      if "S" in analyses:
        mainOut.write(",NA")
      
      if "px" in analyses:
        for popName in popNames:
          mainOut.write(",NA")
      
      if "popS" in analyses:
        for popName in popNames:
          mainOut.write(",NA")
      
      if "dxy" in analyses:
        for X in range(len(popNames) - 1):
          for Y in range(X + 1,len(popNames)):
            mainOut.write(",NA")
      
      if "ABBABABA" in analyses:
        mainOut.write(",NA,NA,NA,NA,NA,NA")
            
      #and end the line
      mainOut.write("\n")
      
      
      #and record the winow as an NA
      lastWindNA = True
    
    #if the line in hand is on the same scaf, we simply slide the start along one slide
    if len(objects) > 1 and objects[0] == subSCF:
      i = len(subPos)
      windStart += slide
      for x in subPos:
        if x >= windStart:
          i = subPos.index(x)
          break
      subPos = subPos[i:]
      
      for name in indNames:
        vars()["sub" + name] = vars()["sub" + name][i:]
    #otherwise its a new scaf, so we reset the subwindow and subScaf and read the next line
    else:
      windStart = 1
      
      if len(objects) > 1:
        if allScafs or (checkChrom and objects[0] in chromDict and chromDict[objects[0]] in chroms) or (include and objects[0] in scafsToInclude) or (exclude and objects[0] not in scafsToExclude):
          subSCF = objects[0]
          subPos = [int(objects[1])]
      
          for name in indNames:
            vars()["sub" + name] = [objects[names.index(name)]]
        else:
          subSCF = None
      
        line = file.readline().rstrip()
        objects = line.split(sep)

      else:
        break
  if windowsTested == nextReport:
    print windowsTested, "windows done ..."
    nextReport += report


file.close()
mainOut.close()


print "\n" + str(windowsTested) + " windows were tested."
print "\n" + str(goodWindows) + " windows were good.\n"

print "\nDone."
