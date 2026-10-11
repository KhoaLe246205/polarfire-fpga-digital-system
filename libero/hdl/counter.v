module counter(
    input  wire clk,
    input  wire rst,
    input  wire tick,
    input  wire up_direction, 
    input  wire down_direction,
    output reg [3:0] count
);
always @(posedge clk) begin
    if (rst)
        count <= 0;
    else if (tick) begin
        if (up_direction)
            count <= (count == 9) ? 0 : count + 1;
        else if (down_direction) 
            count <= (count == 0) ? 9 : count - 1;
    end
end
endmodule
