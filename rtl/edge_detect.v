module edge_detect(
    input wire clk,
    input wire sig_in,
    output wire pulse
);
    reg d = 0;
    always @(posedge clk) begin
        d <= sig_in;
    end

    assign pulse = sig_in & ~d;
endmodule

