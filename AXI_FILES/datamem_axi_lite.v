module datamem_axi_lite #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32
)(
    input  wire                  aclk,
    input  wire                  aresetn,

    // ---------------- WRITE ADDRESS CHANNEL ----------------
    input  wire [ADDR_WIDTH-1:0] S_AXI_AWADDR,
    input  wire                  S_AXI_AWVALID,
    output reg                   S_AXI_AWREADY,

    // ---------------- WRITE DATA CHANNEL ----------------
    input  wire [DATA_WIDTH-1:0] S_AXI_WDATA,
    input  wire [3:0]            S_AXI_WSTRB,
    input  wire                  S_AXI_WVALID,
    output reg                   S_AXI_WREADY,

    // ---------------- WRITE RESPONSE CHANNEL ----------------
    output reg  [1:0]            S_AXI_BRESP,
    output reg                   S_AXI_BVALID,
    input  wire                  S_AXI_BREADY,

    // ---------------- READ ADDRESS CHANNEL ----------------
    input  wire [ADDR_WIDTH-1:0] S_AXI_ARADDR,
    input  wire                  S_AXI_ARVALID,
    output reg                   S_AXI_ARREADY,

    // ---------------- READ DATA CHANNEL ----------------
    output reg  [DATA_WIDTH-1:0] S_AXI_RDATA,
    output reg  [1:0]            S_AXI_RRESP,
    output reg                   S_AXI_RVALID,
    input  wire                  S_AXI_RREADY
);

    // ------------------------------------------------------
    // Internal signals to your datamem
    // ------------------------------------------------------
    reg  [31:0] mem_addr;
    reg  [31:0] mem_wdata;
    reg         mem_write_en;
    reg  [2:0]  mem_func3;
    wire [31:0] mem_rdata;

    // ------------------------------------------------------
    // Instantiate YOUR datamem (UNCHANGED)
    // ------------------------------------------------------
    datamem u_datamem (
        .clk      (aclk),
        .address  (mem_addr),
        .write_en (mem_write_en),
        .func3    (mem_func3),
        .data_in  (mem_wdata),
        .data_out (mem_rdata)
    );

    // ------------------------------------------------------
    // AXI WRITE LOGIC
    // ------------------------------------------------------
    always @(posedge aclk) begin
        if (!aresetn) begin
            S_AXI_AWREADY <= 0;
            S_AXI_WREADY  <= 0;
            S_AXI_BVALID  <= 0;
            S_AXI_BRESP   <= 2'b00;
            mem_write_en  <= 0;
        end else begin
            // Ready to accept address and data
            S_AXI_AWREADY <= 1;
            S_AXI_WREADY  <= 1;

            if (S_AXI_AWVALID && S_AXI_WVALID) begin
                // Accept write
                mem_addr     <= S_AXI_AWADDR;
                mem_wdata    <= S_AXI_WDATA;
                mem_func3    <= 3'b010;   // SW (word write)
                mem_write_en <= 1;

                // Send write response
                S_AXI_BVALID <= 1;
                S_AXI_BRESP  <= 2'b00;    // OKAY
            end else begin
                mem_write_en <= 0;
            end

            // Complete response
            if (S_AXI_BVALID && S_AXI_BREADY) begin
                S_AXI_BVALID <= 0;
            end
        end
    end

    // ------------------------------------------------------
    // AXI READ LOGIC
    // ------------------------------------------------------
    always @(posedge aclk) begin
        if (!aresetn) begin
            S_AXI_ARREADY <= 0;
            S_AXI_RVALID  <= 0;
            S_AXI_RDATA   <= 0;
            S_AXI_RRESP   <= 2'b00;
        end else begin
            S_AXI_ARREADY <= 1;

            if (S_AXI_ARVALID) begin
                mem_addr   <= S_AXI_ARADDR;
                mem_func3  <= 3'b010;     // LW (word read)

                S_AXI_RDATA  <= mem_rdata;
                S_AXI_RVALID <= 1;
                S_AXI_RRESP  <= 2'b00;    // OKAY
            end

            if (S_AXI_RVALID && S_AXI_RREADY) begin
                S_AXI_RVALID <= 0;
            end
        end
    end

endmodule
