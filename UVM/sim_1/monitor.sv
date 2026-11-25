`timescale 1ns / 1ps

class monitor;
    virtual intBus.MON vif;
    mailbox #(packet) mbx_mon2scb;
    packet pt;
    
    function new (mailbox #(packet) mbx, input virtual intBus.MON vif);
        mbx_mon2scb = mbx;
        this.vif    = vif;
    endfunction
    
    task run();
        forever begin
            @(posedge vif.clk);
            pt = packet::new();
            pt.data1_i = vif.data1_i;
            pt.data2_i = vif.data2_i;
            pt.data_o = vif.data_o;
            $display("[MON] take data from bus: inbit1 = %b, inbit2 = %b, out=%b", pt.data1_i[31:0], pt.data2_i[31:0], pt.data_o[31:0]);
            mbx_mon2scb.put(pt);
        end
    endtask
endclass