`timescale 1ns / 1ps

interface intBus (input logic clk);
    logic [31:0] data1_i;
    logic [31:0] data2_i;
    logic [31:0] data_o;
    
    modport DRV (
        output data1_i, data2_i,
        input clk, data_o
    );
    
    modport MON (
        input clk, data1_i, data2_i, data_o
    );
endinterface