version=29
.PHONY=all clean
SIMPLE_TESTS=$(addprefix test, 001 002 003)

define simple 

out/$(1).ok : bin/cromwell-${version}.jar wdl/$(1)/workflow.wdl  wdl/$(1)/workflow.json
	mkdir -p $$(dir $$@)
	java -jar bin/cromwell-${version}.jar run  wdl/$(1)/workflow.wdl -i wdl/$(1)/workflow.json
	touch $$@
endef


all: $(addsuffix .ok,$(addprefix out/,${SIMPLE_TESTS}))

$(eval $(foreach T,${SIMPLE_TESTS},$(call simple,$T)))



bin/cromwell-${version}.jar:
	mkdir -p $(dir $@)
	wget -O "$@" "https://github.com/broadinstitute/cromwell/releases/download/${version}/cromwell-${version}.jar"
	
clean:
	rm -v -f bin/cromwell-${version}.jar cromwell-executions  cromwell-workflow-logs out

