module test_bench;
    reg clk, rst;
    reg btn_up;
    reg btn_down;
    reg btn_remain;
    wire [6:0] seg;
    wire dp;
    
top dut (
    .clk(clk),
    .rst(rst),
    .btn_up(btn_up),
    .btn_down(btn_down),
    .btn_remain(btn_remain),
    .seg(seg),
    .dp(dp)
);

initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin
    rst = 1;
    btn_up = 0;
    btn_down = 0;
    btn_remain = 0;
    #10 rst = 0;
    repeat(5) #10 btn_up = ~btn_up;
    repeat(8) @(posedge clk);
    repeat(5) #10 btn_up = ~btn_up;
    repeat(40) @(posedge clk);
    repeat(5) #10 btn_down = ~btn_down;
    repeat(8) @(posedge clk);
    repeat(5) #10 btn_down = ~btn_down;
    repeat(40) @(posedge clk);
    btn_remain = 1;
    repeat(25) @(posedge clk);
    #10 $stop;
end

endmodule