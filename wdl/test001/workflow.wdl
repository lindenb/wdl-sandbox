task hello {
String world
String who

command {
    echo -e "Hello ${who}.\nHello ${world}." 
  }
 

 
output {
    Array[String] lines = read_lines(stdout())
  }
}


workflow wl {
call hello { input: who="Pierre" }

 output {
    hello.lines
}
}
