module top(
    input  wire clk,        
    input  wire rst,        
    input  wire btn_up,
    input  wire btn_down,
    input  wire btn_remain,
    output wire [6:0] seg,
    output wire dp
);       
assign dp = 1;
wire up_stable, down_stable;

debounce db_up(
    .clk(clk), 
    .btn_in(btn_up), 
    .btn_stable(up_stable)
);

debounce db_down(
    .clk(clk), 
    .btn_in(btn_down), 
    .btn_stable(down_stable)
);

wire up_pulse, down_pulse;

edge_detect up(
    .clk(clk),
    .sig_in(up_stable),
    .pulse(up_pulse)
);

edge_detect down(
    .clk(clk),
    .sig_in(down_stable),
    .pulse(down_pulse)
);
wire up_direction, down_direction, unchanged;

fsm control(
    .clk(clk),
    .rst(rst),
    .up_pulse(up_pulse),
    .down_pulse(down_pulse),
    .remain(btn_remain),
    .up_direction(up_direction),
    .down_direction(down_direction),
    .unchanged(unchanged)
);

wire tick;
clock_divider #(50000000, 1) tick_gen(
    .clk(clk),
    .rst(rst),
    .up_en(up_direction),
    .down_en(down_direction),
    .unchanged(unchanged),
    .tick(tick)
);
    
wire [3:0] count;
counter cnt(
    .clk(clk),
    .rst(rst),
    .tick(tick),
    .up_direction(up_direction),
    .down_direction(down_direction),
    .count(count)
);
    
seven_segment_decoder dec(
    .digit(count),
    .seg(seg)
);

endmodule

