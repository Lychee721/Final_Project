module WB_Stage (
  input  wire         clk        ,
  input  wire         reset      ,
  input       [ 31:0] matrixp00  ,
  input       [ 31:0] matrixp01  ,
  input       [ 31:0] matrixp10  ,
  input       [ 31:0] matrixp11  ,
  input               single_done,
  output reg  [135:0] reg_file
);
  reg [7:0] cycle_cnt ;
  reg       write_done;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      reg_file <= 136'd0;
    end
    else begin
      reg_file   <= {cycle_cnt,matrixp00,matrixp01,matrixp10,matrixp11};
      write_done <= single_done;
    end
  end
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      cycle_cnt <= 8'd0;
    end
    else if(write_done == 1'd1)
      cycle_cnt <= 8'd0;
    else
      cycle_cnt <= cycle_cnt+1'd1;
  end

endmodule