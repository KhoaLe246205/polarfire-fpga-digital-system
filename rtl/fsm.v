module fsm(
    input  wire clk,
    input  wire rst,
    input  wire up_pulse,
    input  wire down_pulse,
    input  wire remain,
    output reg up_direction,
    output reg down_direction,
    output reg unchanged   
);

reg [1:0] current_state, next_state;
localparam IDLE = 2'b11;
localparam UP = 2'b10;
localparam DOWN = 2'b01;

always @(posedge clk) begin
	if (rst)
		current_state <= IDLE;
    else 
        current_state <= next_state;
end

always @(*) begin
	case(current_state)
		IDLE:
			if(remain)
				next_state = IDLE;
			else if(up_pulse)
				next_state = UP;
			else if(down_pulse)
				next_state = DOWN;
			else 
				next_state = IDLE;
		UP:
			if(remain)
				next_state = IDLE;
			else if(down_pulse) 
				next_state = DOWN;
			else 
				next_state = UP;
		DOWN:
			if(remain)
				next_state = IDLE;
			else if(up_pulse) 
				next_state = UP;
			else 
				next_state = DOWN;
		default: next_state = IDLE;
	endcase
end

assign up_direction = (current_state == UP) ? 1'b1 : 1'b0;
assign down_direction = (current_state == DOWN) ? 1'b1 : 1'b0;
assign unchanged = (current_state == IDLE) ? 1'b1 : 1'b0;

endmodule



