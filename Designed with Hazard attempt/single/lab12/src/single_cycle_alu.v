module single_cycle_alu (
  input                    clk        ,
  input                    rst_n      ,
  input             [15:0] ID_instr   ,
  //矩阵A
  input      signed [31:0] matrixA_11 ,
  input      signed [31:0] matrixA_12 ,
  input      signed [31:0] matrixA_21 ,
  input      signed [31:0] matrixA_22 ,
  //矩阵B
  input      signed [31:0] matrixB_11 ,
  input      signed [31:0] matrixB_12 ,
  input      signed [31:0] matrixB_21 ,
  input      signed [31:0] matrixB_22 ,
  output reg signed [31:0] matrixp00  ,
  output reg signed [31:0] matrixp01  ,
  output reg signed [31:0] matrixp10  ,
  output reg signed [31:0] matrixp11  ,
  output reg signed [31:0] cycle_count
);
reg signed [31:0] maxpooling;
  parameter ALU_MATMUL = 16'd1,
    ALU_ADD    = 16'd2,
    ALU_MPOOL  = 16'd3,
    ALU_SUB  = 16'd4;


  always @(posedge clk) begin
    if(rst_n==1'b0)begin
      cycle_count <= 32'd0;
      matrixp00   <= 32'd0;
      matrixp01   <= 32'd0;
      matrixp10   <= 32'd0;
      matrixp11   <= 32'd0;
    end
    else
      case (ID_instr[15:0])

        ALU_MATMUL :
          begin
            matrixp00   <= matrixA_11*matrixB_11+matrixA_12*matrixB_21;
            matrixp01   <= matrixA_11*matrixB_12+matrixA_12*matrixB_22;
            matrixp10   <= matrixA_21*matrixB_11+matrixA_22*matrixB_21;
            matrixp11   <= matrixA_21*matrixB_12+matrixA_22*matrixB_22;
            cycle_count <= cycle_count+1'd1;
          end
        ALU_ADD :
          begin
            matrixp00 <= matrixA_11+matrixB_11;
            matrixp01 <= matrixA_12+matrixB_12;
            matrixp10 <= matrixA_21+matrixB_21;
            matrixp11 <= matrixA_22+matrixB_12;
          end
        ALU_MPOOL :
          begin
            if(((matrixA_11*matrixB_11+matrixA_12*matrixB_21)>=(matrixA_11*matrixB_12+matrixA_12*matrixB_22))&&
              ((matrixA_11*matrixB_11+matrixA_12*matrixB_21)>=(matrixA_21*matrixB_11+matrixA_22*matrixB_21))&&
              ((matrixA_11*matrixB_11+matrixA_12*matrixB_21)>=(matrixA_21*matrixB_12+matrixA_22*matrixB_22)))
            maxpooling <= matrixA_11*matrixB_11+matrixA_12*matrixB_21;
            else if(((matrixA_11*matrixB_12+matrixA_12*matrixB_22)>=(matrixA_11*matrixB_11+matrixA_12*matrixB_21))&&
              ((matrixA_11*matrixB_12+matrixA_12*matrixB_22)>=(matrixA_21*matrixB_11+matrixA_22*matrixB_21))&&
              ((matrixA_11*matrixB_12+matrixA_12*matrixB_22)>=(matrixA_21*matrixB_12+matrixA_22*matrixB_22)))
            maxpooling <= matrixA_11*matrixB_12+matrixA_12*matrixB_22;
            else if(((matrixA_21*matrixB_11+matrixA_22*matrixB_21)>=(matrixA_11*matrixB_11+matrixA_12*matrixB_21))&&
              ((matrixA_21*matrixB_11+matrixA_22*matrixB_21)>=(matrixA_11*matrixB_12+matrixA_12*matrixB_22))&&
              ((matrixA_21*matrixB_11+matrixA_22*matrixB_21)>=(matrixA_21*matrixB_12+matrixA_22*matrixB_22)))
            maxpooling <= matrixA_21*matrixB_11+matrixA_22*matrixB_21;
            else if(((matrixA_21*matrixB_12+matrixA_22*matrixB_22)>=(matrixA_11*matrixB_11+matrixA_12*matrixB_21))&&
              ((matrixA_21*matrixB_12+matrixA_22*matrixB_22)>=(matrixA_11*matrixB_12+matrixA_12*matrixB_22))&&
              ((matrixA_21*matrixB_12+matrixA_22*matrixB_22)>=(matrixA_21*matrixB_11+matrixA_22*matrixB_21)))
            maxpooling <= matrixA_21*matrixB_12+matrixA_22*matrixB_22;
            else
              maxpooling <= maxpooling;
          end
        ALU_SUB :
          begin
            matrixp00 <= matrixA_11-matrixB_11;
            matrixp01 <= matrixA_12-matrixB_12;
            matrixp10 <= matrixA_21-matrixB_21;
            matrixp11 <= matrixA_22-matrixB_22;
          end


        default : ;
      endcase

  end


endmodule