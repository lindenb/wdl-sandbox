task echo_sample_name {
	String sample

	command {
	  	echo ${sample}
		}
	}

workflow wl {
	Array[Object] samples
	scatter(sample in samples) {
   	 	String name = sample["name"]
   	 	Array[Array[String]] fastqs = sample["fastqs"]

		call echo_sample_name {input:sample=name  }
	 	}
	}
