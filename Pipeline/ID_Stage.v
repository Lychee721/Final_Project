module ID_Stage (
  input  wire        clk     ,
  input  wire        reset   ,
  input  reg  [31:0] IF_instr,
  input  reg   IF_valid,
  output reg  [31:0] ID_instr,
  output reg   ID_valid
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
        ID_instr<=32'd0;
        ID_valid<=0;
    end else  begin  
        ID_instr<={IF_instr[15:0],IF_instr[31:16]};
        ID_valid<=IF_valid;

    end
  end



endmodule