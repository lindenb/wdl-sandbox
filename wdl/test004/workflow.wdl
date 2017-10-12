task makebed {
Int nLines


command <<<
   echo -e 'chrom\tstart\tend'
   seq 1 ${nLines} | awk  '{N=int(1+rand()*1000);L=int(1+rand()*100); printf("chr%d\t%d\t%d\n",int(1+rand()*10),N,N+L);}' 
>>>
 

 
output {
   File bedFile = stdout()
  }
}

task task_dict {
File bedFile

command <<<
   grep -v -E '^(browser|track)' ${bedFile} 
>>>

output {
	Array[Object] dict = read_objects(stdout())
	}
}

task chrom_json {
Object bedObject


command <<<
   echo ${bedObject.chrom}
   echo ${bedObject.start}
   echo ${bedObject.end}
   echo "=============="
>>>


}



workflow wl {
Int nLines

call makebed { input: nLines=nLines}
call task_dict { input: bedFile=makebed.bedFile}
scatter (dict in task_dict.dict) {
    call chrom_json { input:bedObject=dict }
  }

}
