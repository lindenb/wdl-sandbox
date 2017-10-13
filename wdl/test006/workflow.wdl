import "wdl/test006/echo.wdl" as share



workflow wl {
Array[String] messages


scatter (msg in messages) {
    call share.task_echo { input: message=msg }
  }

}
