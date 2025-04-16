module EX_Stage (
  input  wire               clk        ,
  input  wire               reset      ,
  input  reg         [31:0] ID_instr   ,
  input  reg                ID_valid   ,
  output reg         [31:0] address    ,
  output reg                data_valid ,
  output reg                single_done,
  input       signed [31:0] matrixA_11 ,
  input       signed [31:0] matrixA_12 ,
  input       signed [31:0] matrixA_21 ,
  input       signed [31:0] matrixA_22 ,
  input       signed [31:0] matrixB_11 ,
  input       signed [31:0] matrixB_12 ,
  input       signed [31:0] matrixB_21 ,
  input       signed [31:0] matrixB_22 ,
  output reg  signed [31:0] matrixp00  ,
  output reg  signed [31:0] matrixp01  ,
  output reg  signed [31:0] matrixp10  ,
  output reg  signed [31:0] matrixp11
);

  reg        [ 1:0] flow_cnt  ;
  reg signed [31:0] maxpooling;
  parameter ALU_MATMUL = 16'd1,
    ALU_ADD    = 16'd2,
    ALU_MPOOL  = 16'd3,
    ALU_SUB  = 16'd4;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      address     <= 32'd0;
      data_valid  <= 1'b0;
      single_done <= 1'd0;
      flow_cnt    <= 2'd0;
      single_done <= 1'd0;
      matrixp00   <= 32'd0;
      matrixp01   <= 32'd0;
      matrixp10   <= 32'd0;
      matrixp11   <= 32'd0;
    end else begin
      single_done <= 1'd0;
      case (flow_cnt)
        2'd0 : begin
          if(ID_valid==1'b1)begin
            data_valid <= ID_valid;
            address    <= ID_instr;
            flow_cnt   <= flow_cnt+1'd1;
          end
        end
        2'd1 : begin
          data_valid <= 1'd0;
          flow_cnt   <= flow_cnt+1'd1;
        end
        2'd2 : begin
          case (ID_instr[31:16])

            ALU_MATMUL :
              begin
                flow_cnt    <= 2'd0;
                single_done <= 1'd1;
                matrixp00   <= matrixA_11*matrixB_11+matrixA_12*matrixB_21;
                matrixp01   <= matrixA_11*matrixB_12+matrixA_12*matrixB_22;
                matrixp10   <= matrixA_21*matrixB_11+matrixA_22*matrixB_21;
                matrixp11   <= matrixA_21*matrixB_12+matrixA_22*matrixB_22;
              end
            ALU_ADD :
              begin
                flow_cnt    <= 2'd0;
                single_done <= 1'd1;
                matrixp00   <= matrixA_11+matrixB_11;
                matrixp01   <= matrixA_12+matrixB_12;
                matrixp10   <= matrixA_21+matrixB_21;
                matrixp11   <= matrixA_22+matrixB_12;
              end
            ALU_MPOOL :
              begin
                flow_cnt    <= 2'd0;
                single_done <= 1'd1;
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
                flow_cnt    <= 2'd0;
                single_done <= 1'd1;
                matrixp00   <= matrixA_11-matrixB_11;
                matrixp01   <= matrixA_12-matrixB_12;
                matrixp10   <= matrixA_21-matrixB_21;
                matrixp11   <= matrixA_22-matrixB_22;
              end


            default : ;
          endcase
        end
        default : ;
      endcase
    end
  end



endmodule