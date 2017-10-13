task doecho {
Int x
Int y

command <<<
    echo "${x} + ${y}" | bc
>>>

}



workflow wl {
Array[Int] array1
Array[Int] array2

scatter(a in array1) {
	scatter(b in array2) {
		call doecho {input:x=a,y=b  }
		}	
	}
}
