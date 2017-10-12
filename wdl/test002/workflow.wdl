task makebed {
Int nLines


command {
   seq 1 ${nLines} | wc -l
  }
 

 
output {
   Int lines = read_int(stdout())
  }
}


workflow wl {
Int nLines

call makebed { input: nLines=nLines}

 output {
    makebed.lines
}
}
