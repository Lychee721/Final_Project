`timescale 1ns/1ns

module single_cycle_alu_tb ();

  // Parameters

  //Ports
  reg         clk         = 0;
  reg         rst_n       = 0;
  reg        [15:0] ID_instr           ;
  reg  [31:0] matrixA_11     ;
  reg  [31:0] matrixA_12     ;
  reg  [31:0] matrixA_21     ;
  reg  [31:0] matrixA_22     ;
  reg  [31:0] matrixB_11     ;
  reg  [31:0] matrixB_12     ;
  reg  [31:0] matrixB_21     ;
  reg  [31:0] matrixB_22     ;
  wire [31:0] cycle_count    ;
  wire [31:0] matrixp00      ;
  wire [31:0] matrixp01      ;
  wire [31:0] matrixp10      ;
  wire [31:0] matrixp11      ;

  single_cycle_alu single_cycle_alu_inst (
    .clk        (clk        ),
    .rst_n      (rst_n      ),
    .ID_instr       (ID_instr       ),
    .matrixA_11 (matrixA_11 ),
    .matrixA_12 (matrixA_12 ),
    .matrixA_21 (matrixA_21 ),
    .matrixA_22 (matrixA_22 ),
    .matrixB_11 (matrixB_11 ),
    .matrixB_12 (matrixB_12 ),
    .matrixB_21 (matrixB_21 ),
    .matrixB_22 (matrixB_22 ),
    .matrixp00  (matrixp00  ),
    .matrixp01  (matrixp01  ),
    .matrixp10  (matrixp10  ),
    .matrixp11  (matrixp11  ),
    .cycle_count(cycle_count)
  );
  reg [31:0] source_data[63:0];
  always #5  clk = ! clk ;
  initial begin
    $readmemh("C:/Users/86182/Desktop/lab12/src/cnn_weights.hex", source_data);
  end
  initial begin
    rst_n     <=1'd0;
    ID_instr      <=16'd0;
    matrixA_11<=0;
    matrixA_12<=0;
    matrixA_21<=0;
    matrixA_22<=0;
    matrixB_11<=0;
    matrixB_12<=0;
    matrixB_21<=0;
    matrixB_22<=0;
    #200
      rst_n     <=1'd1;
    #200
    ID_instr      <=16'd1;
    matrixA_11<=source_data[0];
    matrixA_12<=source_data[1];
    matrixA_21<=source_data[2];
    matrixA_22<=source_data[3];
    matrixB_11<=source_data[4];
    matrixB_12<=source_data[5];
    matrixB_21<=source_data[6];
    matrixB_22<=source_data[7];
    #10
    ID_instr      <=16'd0;
    $display("Cycle Count=%d", cycle_count);
    $display(" matrix p00 = %h", matrixp00);
    $display(" matrix p01 = %h", matrixp01);
    $display(" matrix p10 = %h", matrixp10);
    $display(" matrix p11 = %h", matrixp11);
    #200
    ID_instr      <=16'd1;
    matrixA_11<=source_data[8] ;
    matrixA_12<=source_data[9] ;
    matrixA_21<=source_data[10];
    matrixA_22<=source_data[11];
    matrixB_11<=source_data[12];
    matrixB_12<=source_data[13];
    matrixB_21<=source_data[14];
    matrixB_22<=source_data[15];

    #10
    ID_instr      <=16'd0;
    $display("Cycle Count=%d", cycle_count);
    $display(" matrix p00 = %h", matrixp00);
    $display(" matrix p01 = %h", matrixp01);
    $display(" matrix p10 = %h", matrixp10);
    $display(" matrix p11 = %h", matrixp11);
    #200
    ID_instr      <=16'd1;
    matrixA_11<=source_data[16];
    matrixA_12<=source_data[17];
    matrixA_21<=source_data[18];
    matrixA_22<=source_data[19];
    matrixB_11<=source_data[20];
    matrixB_12<=source_data[21];
    matrixB_21<=source_data[22];
    matrixB_22<=source_data[23];

    #10
    ID_instr      <=16'd0;
    $display("Cycle Count=%d", cycle_count);
    $display(" matrix p00 = %h", matrixp00);
    $display(" matrix p01 = %h", matrixp01);
    $display(" matrix p10 = %h", matrixp10);
    $display(" matrix p11 = %h", matrixp11);
    #200
    ID_instr      <=16'd1;
    matrixA_11<=source_data[24];
    matrixA_12<=source_data[25];
    matrixA_21<=source_data[26];
    matrixA_22<=source_data[27];
    matrixB_11<=source_data[28];
    matrixB_12<=source_data[29];
    matrixB_21<=source_data[30];
    matrixB_22<=source_data[31];

    #10
    ID_instr      <=16'd0;
    $display("Cycle Count=%d", cycle_count);
    $display(" matrix p00 = %h", matrixp00);
    $display(" matrix p01 = %h", matrixp01);
    $display(" matrix p10 = %h", matrixp10);
    $display(" matrix p11 = %h", matrixp11);
    #200
    ID_instr      <=16'd1;
    matrixA_11<=source_data[32];
    matrixA_12<=source_data[33];
    matrixA_21<=source_data[34];
    matrixA_22<=source_data[35];
    matrixB_11<=source_data[36];
    matrixB_12<=source_data[37];
    matrixB_21<=source_data[38];
    matrixB_22<=source_data[39];

    #10
    ID_instr      <=16'd0;
    $display("Cycle Count=%d", cycle_count);
    $display(" matrix p00 = %h", matrixp00);
    $display(" matrix p01 = %h", matrixp01);
    $display(" matrix p10 = %h", matrixp10);
    $display(" matrix p11 = %h", matrixp11);
    #200
    ID_instr      <=16'd1;
    matrixA_11<=source_data[40];
    matrixA_12<=source_data[41];
    matrixA_21<=source_data[42];
    matrixA_22<=source_data[43];
    matrixB_11<=source_data[44];
    matrixB_12<=source_data[45];
    matrixB_21<=source_data[46];
    matrixB_22<=source_data[47];

    #10
    ID_instr      <=16'd0;
    $display(" Cycle Count= %d", cycle_count);
    $display(" matrix p00 = %h", matrixp00);
    $display(" matrix p01 = %h", matrixp01);
    $display(" matrix p10 = %h", matrixp10);
    $display(" matrix p11 = %h", matrixp11);
    #200
    ID_instr      <=16'd1;
    matrixA_11<=source_data[48];
    matrixA_12<=source_data[49];
    matrixA_21<=source_data[50];
    matrixA_22<=source_data[51];
    matrixB_11<=source_data[52];
    matrixB_12<=source_data[53];
    matrixB_21<=source_data[54];
    matrixB_22<=source_data[55];

    #10
    ID_instr      <=16'd0;
    $display("Cycle Count=%d", cycle_count);
    $display(" matrix p00 = %h", matrixp00);
    $display(" matrix p01 = %h", matrixp01);
    $display(" matrix p10 = %h", matrixp10);
    $display(" matrix p11 = %h", matrixp11);

    #200
    ID_instr      <=16'd1;
    matrixA_11<=source_data[56];
    matrixA_12<=source_data[57];
    matrixA_21<=source_data[58];
    matrixA_22<=source_data[59];
    matrixB_11<=source_data[60];
    matrixB_12<=source_data[61];
    matrixB_21<=source_data[62];
    matrixB_22<=source_data[63];

    #10
    ID_instr      <=16'd0;
    $display("Cycle Count=%d", cycle_count);
    $display(" matrix p00 = %h", matrixp00);
    $display(" matrix p01 = %h", matrixp01);
    $display(" matrix p10 = %h", matrixp10);
    $display(" matrix p11 = %h", matrixp11);
  end


endmodule