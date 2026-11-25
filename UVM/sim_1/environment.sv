`timescale 1ns / 1ps

class environment;
    monitor    mon;
    driver     drv;
    sequencer  seq;
    scoreboard scb;
    
    virtual intBus.DRV dvif;
    virtual intBus.MON mvif;
    
    mailbox #(packet) mbx_mon2scb;
    mailbox #(packet) mbx_seq2drv;
    
    function new (
        input virtual intBus.DRV dvif, 
        input virtual intBus.MON mvif
        );
        this.dvif = dvif;
        this.mvif = mvif;
    endfunction
    
    function void build_phase();
        mbx_mon2scb = new();
        mbx_seq2drv = new();
        
        seq = new(mbx_seq2drv, dvif);
        drv = new(mbx_seq2drv, dvif);
        mon = new(mbx_mon2scb, mvif);
        scb = new(mbx_mon2scb);
    endfunction
    
    task start();
        fork
            drv.run();
            mon.run();
            scb.run();
        join_none
        $display("[ENV] Background components started.");
    endtask
    
    task run(
        input string TYPE_TEST = "DEF",
        input int    NUM_TESTS = 10
    );
        $display("[ENV] Starting sequence profile: %s, %d", TYPE_TEST, NUM_TESTS);
        seq.run(TYPE_TEST, NUM_TESTS);
        $display("[ENV] Sequence profile %s, %d finished.", TYPE_TEST, NUM_TESTS);
        repeat (2) @(posedge dvif.clk);
    endtask
endclass