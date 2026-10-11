module clock_divider #(parameter CLK_FREQ = 50000000, parameter TICK_HZ = 1) (
    input wire clk,
    input wire rst,
    input wire up_en, 
    input wire down_en,
    input wire unchanged,
    output reg tick
);
localparam DIV = CLK_FREQ / TICK_HZ;
wire en, dir;
reg [31:0] cnt = 0;
reg last_dir;
wire dir_changed;

assign en = up_en | down_en;
assign dir = (up_en) ? 1'b1 : 1'b0;

always @(posedge clk) begin
	if(rst)
	    	last_dir <= 1'b0;
 	else
	    	last_dir <= dir;
end
    
assign dir_changed = (dir != last_dir);
    
always @(posedge clk) begin
 	if(rst | unchanged) begin
        cnt <= 0;
        tick <= 0;   
	end else if (dir_changed) begin
		cnt <= 0;
		tick <= 0;
	end else if (en) begin    
        if (cnt >= DIV-1) begin
            cnt <= 0;
            tick <= 1;
        end else begin
            cnt <= cnt + 1;
            tick <= 0;
        end
	end else begin
        cnt <= cnt;
        tick <= tick;
	end
end

endmodule
