`timescale 1ns / 1ps

class scoreboard;
    mailbox #(packet) mbx_mon2scb;
    packet pt;
    
    packet que[$];
    packet ptmp;
    
    bit [31:0] tmp1;
    bit [31:0] tmp2;
    
    
    function new (mailbox #(packet) mbx);
        mbx_mon2scb = mbx;
    endfunction
    
    task run();
        forever begin
            mbx_mon2scb.get(pt);
            que.push_back(pt.clone());
            
            if(que.size() > 2) begin
                ptmp = que.pop_front();
                tmp1 = ptmp.data1_i;
                tmp2 = ptmp.data2_i;
                $display("======\n[SCB] (?) data1_i=%b, data2_i=%b\n data1_i: s=%b | exp = %0d | m=%b\n data2_i: s=%b | exp = %0d | m=%b\n get: s=%b | exp = %0d | m=%b|\n======", tmp1, tmp2,
                    tmp1[31], int'(tmp1[30:23]) - 127, tmp1[22:0],
                    tmp2[31], int'(tmp2[30:23]) - 127, tmp2[22:0],
                    pt.data_o[31] , int'(pt.data_o[30:23])  - 127, pt.data_o[22:0]
                );
            end
        end
    endtask
endclass