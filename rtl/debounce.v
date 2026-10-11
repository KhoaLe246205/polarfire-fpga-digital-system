
module debounce #(parameter WIDTH = 16) (
    input  wire clk,
    input  wire btn_in,
    output wire btn_stable
);
    reg [WIDTH-1:0] shift = 0;
    always @(posedge clk) begin
        shift <= {shift[WIDTH-2:0], btn_in};
    end

    assign btn_stable = &shift[WIDTH-1:WIDTH-8];  
endmodule
