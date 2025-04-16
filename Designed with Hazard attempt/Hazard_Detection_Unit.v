module Hazard_Detection_Unit (
  input      [31:0] address   ,
  input             data_valid,
  input      [31:0] ID_instr  ,
  input             ID_valid  ,
  output wire       Stall
);

  assign Stall = ((address==ID_instr)&&(ID_valid==data_valid)) ? 1'b1 : 1'b0;
endmodule