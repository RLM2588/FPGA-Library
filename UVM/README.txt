Самописный UVM с mailbox для изменений


Пример тб
`timescale 1ns / 1ps

module tb_lab();
    localparam CLK_PER   = 10;
    localparam NUM_TESTS = 5;
    environment env;
    
    logic clk = 1'b0;
    always #(CLK_PER/2) clk = ~clk;
    
    intBus bus(clk);
    
    lab10_2 u_lab10_2(
        .clk (clk        ),
        .din1(bus.data1_i),
        .din2(bus.data2_i),
        .dout(bus.data_o )
    );
    
    initial begin
        env = new(bus.DRV, bus.MON);
        
        env.build_phase();
        env.start();
        $display("\n========== Run Test ==========\n");
        env.run("PLAN"  , NUM_TESTS);
        
        env.run("NORMAL", NUM_TESTS);
        
        env.run("RANDOM", NUM_TESTS);
        
        repeat (2) @(posedge clk);
        
        $display("\n========== End Test ==========\n");
        $stop;
    end
endmodule