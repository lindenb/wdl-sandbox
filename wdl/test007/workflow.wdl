task echo_sample_name {
	Object sample

	command {
	  	echo ${sample['name']}
		}
	}

workflow wl {
	File config
	Map[String,Object] samples = read_json(config)

	scatter(sample in samples) {
		call echo_sample_name {input:sample=sample  }
	 	}
	}
