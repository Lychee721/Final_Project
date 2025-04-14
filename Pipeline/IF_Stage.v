module IF_Stage (
  input  wire        clk        ,
  input  wire        reset      ,
  input  wire [31:0] cmd_address,
  input  wire        cmd_valid  ,
  output reg  [31:0] IF_address ,
  output reg  [31:0] IF_instr   ,
  output reg   IF_valid
);


  reg [31:0] source_instr[15:0];



  initial begin
    $readmemh("C:/Users/86182/Desktop/lab/lab12/instr.hex",source_instr);
  end


  always @(posedge clk or posedge reset) begin
    if (reset) begin
      IF_instr <= 32'd0;
    end else
      begin
      IF_instr   <= source_instr[cmd_address];
      IF_valid   <= cmd_valid;
      IF_address <= cmd_address;
    end 

    end

endmodule