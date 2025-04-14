module top (
  input  wire         clk        ,
  input  wire         reset      ,
  input  wire [ 31:0] cmd_address,
  input  wire         cmd_valid  ,
  output      [135:0] reg_file   ,
  output  reg            done
);
  wire [31:0] matrixA_11;
  wire [31:0] matrixA_12;
  wire [31:0] matrixA_21;
  wire [31:0] matrixA_22;
  wire [31:0] matrixB_11;
  wire [31:0] matrixB_12;
  wire [31:0] matrixB_21;
  wire [31:0] matrixB_22;
  wire [31:0] matrixp00 ;
  wire [31:0] matrixp01 ;
  wire [31:0] matrixp10 ;
  wire [31:0] matrixp11 ;


  wire [31:0] IF_address;
  wire [31:0] IF_instr  ;
  wire  IF_valid  ;

  wire [31:0] ID_instr   ;
  wire        ID_valid   ;
  wire        single_done;
  wire [31:0] address    ;
  wire data_valid;
  IF_Stage IF (
    .clk        (clk        ),
    .reset      (reset      ),
    .cmd_address(cmd_address),
    .cmd_valid  (cmd_valid  ),
    .IF_address (IF_address ),
    .IF_instr   (IF_instr   ),
    .IF_valid   (IF_valid   )
  );

  ID_Stage ID_Stage_inst (
    .clk     (clk     ),
    .reset   (reset   ),
    .IF_instr(IF_instr),
    .IF_valid(IF_valid),
    .ID_instr(ID_instr),
    .ID_valid(ID_valid)
  );

  EX_Stage EX_Stage_inst (
    .clk        (clk        ),
    .reset      (reset      ),
    .ID_instr   (ID_instr   ),
    .ID_valid   (ID_valid   ),
    .address    (address    ),
    .data_valid (data_valid ),
    .single_done(single_done),
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
    .matrixp11  (matrixp11  )
  );

  MEM_Stage MEM_Stage_inst (
    .clk       (clk       ),
    .reset     (reset     ),
    .address   (address   ),
    .data_valid(data_valid),
    .matrixA_11(matrixA_11),
    .matrixA_12(matrixA_12),
    .matrixA_21(matrixA_21),
    .matrixA_22(matrixA_22),
    .matrixB_11(matrixB_11),
    .matrixB_12(matrixB_12),
    .matrixB_21(matrixB_21),
    .matrixB_22(matrixB_22)
  );



  WB_Stage WB_Stage_inst (
    .clk       (clk       ),
    .reset     (reset     ),
    .matrixp00  (matrixp00  ),
    .matrixp01  (matrixp01  ),
    .matrixp10  (matrixp10  ),
    .matrixp11  (matrixp11  ),
    .single_done(single_done),
    .reg_file   (reg_file   )
  );


  always @(posedge clk or posedge reset) begin
    if (reset) begin
      done <= 1'd0;
    end else
      begin
        done <= single_done;
    end 
    end

endmodule
