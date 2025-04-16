module MEM_Stage (
  input  wire        clk       ,
  input  wire        reset     ,
  input       [31:0] address   ,
  input              data_valid,
  output reg signed [31:0] matrixA_11,
  output reg signed [31:0] matrixA_12,
  output reg signed [31:0] matrixA_21,
  output reg signed [31:0] matrixA_22,
  output reg signed [31:0] matrixB_11,
  output reg signed [31:0] matrixB_12,
  output reg signed [31:0] matrixB_21,
  output reg signed [31:0] matrixB_22
);

  reg  signed [31:0] source_data[63:0];

// data
  initial
    begin
      $readmemh("C:/Users/86182/Desktop/lab/lab12/cnn_weights.hex",source_data);
    end


  always @(posedge clk or posedge reset) begin
    if (reset) begin
      matrixA_11<=32'd0;
      matrixA_12<=32'd0;
      matrixA_21<=32'd0;
      matrixA_22<=32'd0;
      matrixB_11<=32'd0;
      matrixB_12<=32'd0;
      matrixB_21<=32'd0;
      matrixB_22<=32'd0;
    end
    else if(data_valid)
      case (address[2:0])
        3'b000 : begin
          matrixA_11 <= source_data[0];
          matrixA_12 <= source_data[1];
          matrixA_21 <= source_data[2];
          matrixA_22 <= source_data[3];

          matrixB_11 <= source_data[4];
          matrixB_12 <= source_data[5];
          matrixB_21 <= source_data[6];
          matrixB_22 <= source_data[7];
        end
        3'b001 : begin
          matrixA_11 <= source_data[8];
          matrixA_12 <= source_data[9];
          matrixA_21 <= source_data[10];
          matrixA_22 <= source_data[11];

          matrixB_11 <= source_data[12];
          matrixB_12 <= source_data[13];
          matrixB_21 <= source_data[14];
          matrixB_22 <= source_data[15];
        end
        3'b010 : begin
          matrixA_11 <= source_data[16];
          matrixA_12 <= source_data[17];
          matrixA_21 <= source_data[18];
          matrixA_22 <= source_data[19];

          matrixB_11 <= source_data[20];
          matrixB_12 <= source_data[21];
          matrixB_21 <= source_data[22];
          matrixB_22 <= source_data[23];
        end
        3'b011 : begin
          matrixA_11 <= source_data[24];
          matrixA_12 <= source_data[25];
          matrixA_21 <= source_data[26];
          matrixA_22 <= source_data[27];

          matrixB_11 <= source_data[28];
          matrixB_12 <= source_data[29];
          matrixB_21 <= source_data[30];
          matrixB_22 <= source_data[31];
        end
        3'b100 : begin
          matrixA_11 <= source_data[32];
          matrixA_12 <= source_data[33];
          matrixA_21 <= source_data[34];
          matrixA_22 <= source_data[35];

          matrixB_11 <= source_data[36];
          matrixB_12 <= source_data[37];
          matrixB_21 <= source_data[38];
          matrixB_22 <= source_data[39];
        end
        3'b101 : begin
          matrixA_11 <= source_data[40];
          matrixA_12 <= source_data[41];
          matrixA_21 <= source_data[42];
          matrixA_22 <= source_data[43];

          matrixB_11 <= source_data[44];
          matrixB_12 <= source_data[45];
          matrixB_21 <= source_data[46];
          matrixB_22 <= source_data[47];
        end
        3'b110 : begin
          matrixA_11 <= source_data[48];
          matrixA_12 <= source_data[49];
          matrixA_21 <= source_data[50];
          matrixA_22 <= source_data[51];

          matrixB_11 <= source_data[52];
          matrixB_12 <= source_data[53];
          matrixB_21 <= source_data[54];
          matrixB_22 <= source_data[55];
        end
        3'b111 : begin
          matrixA_11 <= source_data[56];
          matrixA_12 <= source_data[57];
          matrixA_21 <= source_data[58];
          matrixA_22 <= source_data[59];

          matrixB_11 <= source_data[60];
          matrixB_12 <= source_data[61];
          matrixB_21 <= source_data[62];
          matrixB_22 <= source_data[63];
        end

        default : ;
      endcase


  end


endmodule