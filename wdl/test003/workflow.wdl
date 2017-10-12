task makebed {
Int nLines


command <<<
   seq 1 ${nLines} | awk  '{N=int(1+rand()*1000);L=int(1+rand()*100); printf("chr%d\t%d\t%d\n",int(1+rand()*10),N,N+L);}' 
>>>
 

 
output {
   File bedFile = stdout()
  }
}

task distinct_chroms {
File bedFile

command <<<
   grep -v -E '(browser|track)' ${bedFile} | cut -f 1 | uniq | sort | uniq
>>>

output {
	Array[String] chromosomes = read_lines(stdout())
	}
}

task run_on_chrom {
File bedFile
String chrom

command <<<
   grep -v -E '(browser|track)' ${bedFile} | awk -F '\t' '($1 == "${chrom}" )' | sort -t $'\t' -k1,1 -k2,2n > ${chrom}.bed
>>>

output {
	 File chrombedFile = chrom + ".bed"
	}
}

workflow wl {
Int nLines

call makebed { input: nLines=nLines}
call distinct_chroms { input: bedFile=makebed.bedFile}
scatter (chrom in distinct_chroms.chromosomes) {
    call run_on_chrom { input: bedFile=makebed.bedFile,chrom=chrom }
  }

 output {
    run_on_chrom.chrombedFile
}
}
