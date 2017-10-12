task hello {
Map[String, String] env

command <<<
  echo "Reference is '${env["reference"]}'"
>>>
 

}

workflow wl {
File config
Map[String, String] env = read_map(config)

call hello {input: env = env}
}
