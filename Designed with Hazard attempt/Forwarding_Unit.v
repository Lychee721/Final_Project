module Forwarding_Unit (
  input      [31:0] address   ,
  input             data_valid,
  input      [31:0] ID_instr  ,
  input             ID_valid  ,
  output reg [ 1:0] ForwardA  ,
  output reg [ 1:0] ForwardB
);

  always @(*) begin
    if ((data_valid) && (address != 0) )
      ForwardA = 2'b10;
    else
      ForwardA = 2'b00;
  end


  always @(*) begin
    if ((ID_valid) && (ID_instr != 0) )
      ForwardB = 2'b10;
    else
      ForwardB = 2'b00;
  end
endmodule