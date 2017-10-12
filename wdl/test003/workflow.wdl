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


workflow wl {
Int nLines

call makebed { input: nLines=nLines}
call distinct_chroms { input: bedFile=makebed.bedFile}

 output {
    distinct_chroms.chromosomes
}
}
