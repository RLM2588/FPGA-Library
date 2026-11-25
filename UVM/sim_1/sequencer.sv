`timescale 1ns / 1ps

class sequencer;
    packet pt;
    mailbox #(packet) mbx_seq2drv;
    virtual intBus.DRV bus;
    
    
    
    function new (input mailbox #(packet) mbx, input virtual intBus.DRV vif);
        mbx_seq2drv = mbx;
        bus         = vif;
    endfunction
    
    task run(
        input string TYPE_TEST = "DEF",
        input int    NUM_TESTS = 10
    );
        case (TYPE_TEST)
            "PLAN" : begin
                @(posedge bus.clk);
                pt = packet::new();
                pt.data1_i = 32'h3FC00000;
                pt.data2_i = 32'h00000000;
                disp("PLN", pt);
                mbx_seq2drv.put(pt);
                @(posedge bus.clk);
                pt = packet::new();
                pt.data1_i = 32'h3F880000;
                pt.data2_i = 32'h3F880000;
                disp("PLN", pt);
                mbx_seq2drv.put(pt);
                @(posedge bus.clk);
                pt = packet::new();
                pt.data1_i = 32'h40400000;
                pt.data2_i = 32'hC0000000;
                disp("PLN", pt);
                mbx_seq2drv.put(pt);
                @(posedge bus.clk);
                pt = packet::new();
                pt.data1_i = 32'h00080000;
                pt.data2_i = 32'h00080000;
                disp("PLN", pt);
                mbx_seq2drv.put(pt);
            end
            "NORMAL" : begin
                repeat (NUM_TESTS) begin
                    @(posedge bus.clk);
                    pt = packet::new();
                    pt.normal_exp.constraint_mode(1);
                    pt.randomize();
                    disp("NOR", pt);
                    mbx_seq2drv.put(pt);
                end 
            end
            "RANDOM" : begin
                repeat (NUM_TESTS) begin
                    @(posedge bus.clk);
                    pt = packet::new();
                    pt.normal_exp.constraint_mode(0);
                    pt.randomize();
                    disp("RND", pt);
                    mbx_seq2drv.put(pt);
                end 
            end
            default : begin
                repeat (NUM_TESTS) begin
                    @(posedge bus.clk);
                    pt = packet::new();
                    pt.randomize();
                    disp("DEF", pt);
                    mbx_seq2drv.put(pt);
                end 
            end
        endcase
    endtask
    
    task disp (
        input string TEXT = "DEF", 
        input packet pt
    );
        $display("[SEQ] generate packet type = %s: inbit1 = %b, inbit2 = %b", TEXT, pt.data1_i, pt.data2_i);
    endtask
endclass