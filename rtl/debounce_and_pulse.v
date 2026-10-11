module debounce_and_pulse #(
    parameter WIDTH = 1
)(
    input  wire clk, rst,
    input  wire btn_in,
    output reg  btn_level,   
    output reg  btn_pulse    );

    reg [WIDTH-1:0] cnt = 0;
    reg btn_sync0 = 0, btn_sync1 = 0;
    reg btn_last = 0;

    
    always @(posedge clk) begin
        if(rst) begin
	    btn_sync0 <= 0;
            btn_sync1 <= 0;
	end else begin
	    btn_sync0 <= btn_in;
            btn_sync1 <= btn_sync0;
        end
    end

    always @(posedge clk) begin
        if(rst) begin
	    cnt <= 0;
	    btn_level <= 0;
	end else if (btn_sync1 != btn_last) begin
            cnt <= 0;
        end else begin
            if (cnt < (1<<WIDTH)-1)
                cnt <= cnt + 1;
            else
                btn_level <= btn_sync1;
        end
        btn_last <= btn_sync1;
    end

    reg level_last = 0;
    always @(posedge clk) begin
        if(rst) begin 
	    btn_pulse <= 0;
	    level_last <= 0;
	end else begin
	    btn_pulse <= (btn_level & ~level_last);
            level_last <= btn_level;
        end
    end

endmodule

