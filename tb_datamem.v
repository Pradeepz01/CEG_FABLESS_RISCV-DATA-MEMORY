module tb_datamem();
	
	// Testbench variables
  reg clk = 0;
	reg [7:0] data_in;  // 8bit intput word
	reg [31:0] address;  //32bit address but only a small part is  used for memory(0-4095)
	reg write_en;       
	wire [7:0] data_out;// 8bit output word
	reg [7:0] wr_data;
	integer success_count;
	
	// Instantiate the DUT
	datamem RAM0(
      .clk     (clk     ),
	    .data_in (data_in ),  // 8bit intput word
    .address (address ),  // for 4096 locations
	    .write_en(write_en),  // active high
	    .data_out(data_out)   // 8bit output word
    );
  //CLOCK GENERATION
	always begin
        #0.5 clk = ~clk;
  end
	
	initial begin
		write_en=0;
		address  = 0;
		wr_data    = 0;
		success_count = 0;
		
		wr_data=$random;
		@(posedge clk)
		write_en=1;
		address=32'b1111111111;
		data_in=wr_data;
		
		@(posedge clk);
        write_en = 0;
        #0.1;
		if (wr_data==data_out) begin
			success_count=success_count+1;
		end
		#1;
		wr_data=$random;
		@(posedge clk)
		write_en=1;
		address=32'b1111110111;
		data_in=wr_data;
		
		@(posedge clk);
        write_en = 0;
		#0.1;
		if (wr_data==data_out) begin
			success_count=success_count+1;
		
		end
		
		#1;
		wr_data=$random;
		@(posedge clk)
		write_en=1;
		address=32'b1011111111;
		data_in=wr_data;
		
		@(posedge clk);
        write_en = 0;
		#0.1;
		if (wr_data==data_out) begin
			success_count=success_count+1;
		end
		
		#1 $stop;
	end
endmodule										
`timescale 1us/1ns
