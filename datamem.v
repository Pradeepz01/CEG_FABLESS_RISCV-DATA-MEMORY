module datamem (
    input clk,
    input [31:0] address,
    input write_en,
    input  [7:0] wdata,
    output [7:0] rdata
    );
    reg [7:0] ram [0:4294967295];
    always @(posedge clk) begin
        if (write_en)
            ram[address] <= wdata;
    end
	assign rdata = ram[address];
endmodule