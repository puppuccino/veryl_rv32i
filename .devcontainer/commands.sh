function vcomp() {
    # stands for Verilator Compile
    # rm -rf objdir # is this necessary?
    local TESTBENCH_FILE="./testbench.sv"
    cat output/util.sv > run_sim.sv
    cat $TESTBENCH_FILE >> run_sim.sv
    # Run Verilator linting on the testbench file
    verilator \
        --binary \
        --timing \
        -trace-fst \
        -Ioutput \
        -sv \
        run_sim.sv
    rm -f run_sim.sv
}

function vlint() {
    local TESTBENCH_FILE="./testbench.sv"
    cat output/util.sv > vlint
    cat $TESTBENCH_FILE >> vlint
    # Run Verilator linting on the testbench file

    # @options:
    # Wno-DECLFILENAME: disable warning about the mismatch 
    #                   between the file name and the module name
    # Wno-UNUSEDSIGNAL: disable warning about unused signals

    verilator \
        --lint-only \
        --timing \
        -Wall \
        -Wno-DECLFILENAME \
        -Wno-UNUSEDSIGNAL \
        -Ioutput \
        -sv \
        vlint
    rm -f vlint
}