# compile the testbench file with the verilator
function vcomp() {
    # rm -rf objdir # is this necessary?
    local TESTBENCH_FILE="./testbench.sv"

    TEMP_FILE=$(mktemp)
    cat output/util.sv  >> $TEMP_FILE
    cat $TESTBENCH_FILE >> $TEMP_FILE

    # Run Verilator linting on the testbench file
    verilator \
        --binary \
        --timing \
        -trace-fst \
        -Ioutput \
        -sv \
        $TEMP_FILE

    rm -f $TEMP_FILE
}

# Run Verilator linting on the testbench file
function vlint() {
    local TESTBENCH_FILE="./testbench.sv"

    TEMP_FILE=$(mktemp)

    cat output/util.sv  >> $TEMP_FILE
    cat $TESTBENCH_FILE >> $TEMP_FILE

    # @options:
    # Wno-DECLFILENAME: Disable the warning about the mismatch 
    #                   between the file name and the module name
    # Wno-UNUSEDSIGNAL: Disable the warning about unused signals
    verilator \
        --lint-only \
        --timing \
        -Wall \
        -Wno-DECLFILENAME \
        -Wno-UNUSEDSIGNAL \
        -Ioutput \
        -sv \
        $TEMP_FILE

    rm -f $TEMP_FILE 
}