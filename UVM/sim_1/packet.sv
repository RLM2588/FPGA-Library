`timescale 1ns / 1ps

class packet;
    bit [31:0] data1_i;
    bit [31:0] data2_i;
    bit      [31:0] data_o;
    
    rand bit sgn1;
    rand bit sgn2;
    
    rand bit [7:0] exp1;
    rand bit [7:0] exp2;
    
    rand bit [22:0] mantissa1;
    rand bit [22:0] mantissa2;
    
    constraint normal_exp {
        exp1 inside {0, 255,[114:130]};
        exp2 inside {0, 255,[114:130]};
    }
    
    function void post_randomize();
        data1_i = {sgn1, exp1, mantissa1};
        data2_i = {sgn2, exp2, mantissa2};
    endfunction
    
    function packet clone();
        packet p  = new();
        p.data1_i = this.data1_i;
        p.data2_i = this.data2_i;
        p.data_o  = this.data_o;
        return p;
    endfunction
endclass



//class packet;
//    rand bit [31:0] data1_i;
//    rand bit [31:0] data2_i;
//    bit      [31:0] data_o;
    
//    function packet clone();
//        packet p  = new();
//        p.data1_i = this.data1_i;
//        p.data2_i = this.data2_i;
//        p.data_o  = this.data_o;
//        return p;
//    endfunction
//endclass