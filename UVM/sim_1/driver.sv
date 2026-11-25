`timescale 1ns / 1ps

class driver;
    packet pt;
    mailbox #(packet) mbx_seq2drv;
    virtual intBus.DRV vif;
    
    function new (mailbox #(packet) mbx, input virtual intBus.DRV vif);
        mbx_seq2drv = mbx;
        this.vif    = vif;
    endfunction
    
    task run();
        vif.data1_i <= '0;
        vif.data2_i <= '0;
        @(posedge vif.clk);
        
        forever begin
            mbx_seq2drv.get(pt);
            
            @(posedge vif.clk);
            vif.data1_i <= pt.data1_i;
            vif.data2_i <= pt.data2_i;
            $display("[DRV] Data to bus: inbit1 = %b, inbit2 = %b", pt.data1_i, pt.data2_i);
        end
    endtask
endclass