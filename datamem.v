module datamem (
    input clk,
    input [31:0] address,
    input write_en,
	input  [7:0] data_in,
	output [7:0] data_out
    );
	
	reg [7:0] ram [0:4095]; //4KB Ram
	always @(posedge clk) begin
	    if (write_en && !address[31:12]) begin
		    ram[address[11:0]] <= data_in;
	    end
	end
	assign data_out = ram[address];

endmodule

