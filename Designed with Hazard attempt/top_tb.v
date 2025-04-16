`timescale 1ns/1ns


module Pipeline_CPU_tb ();

  // Parameters

  //Ports
  reg          clk         = 0;
  reg          reset          ;
  reg  [ 31:0] cmd_address    ;
  reg          cmd_valid      ;
  wire [135:0] reg_file       ;
  wire         done           ;
  reg  [  2:0] flow_cnt       ;
  reg  flag;
  reg  stop;

  top top_inst (
    .clk        (clk        ),
    .reset      (reset      ),
    .cmd_address(cmd_address),
    .cmd_valid  (cmd_valid  ),
    .reg_file   (reg_file   ),
    .done       (done       )
  );

  always #5  clk = ! clk ;


  initial begin
    reset<=1;
    #200
      reset<=0;
  end

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      cmd_address<=32'd0;
      cmd_valid  <=1'd0;
      flow_cnt<=3'b0;
      flag<=1'd0;
      stop<=1'b0;
    end
    else
      case (flow_cnt)
        3'b000:begin
          cmd_address<=32'd0;
        if(flag==1'd0)begin
          cmd_valid  <=1'd1;
          flag<=1'd1;
        end
        if(cmd_valid==1'b1)
          cmd_valid  <=1'd0;
        if(done)begin
          flow_cnt<=flow_cnt+1'd1;
          flag<=1'd0;
          $display("Cycle Count=%d", reg_file[135:128]);
          $display(" matrix p00 = %x",reg_file[127:96]);
          $display(" matrix p01 = %x", reg_file[95:64]);
          $display(" matrix p10 = %x", reg_file[63:32]);
          $display(" matrix p11 = %x", reg_file[31:0]);
        end
      end
        3'b001:
        begin
          cmd_address<=32'd1;
        if(flag==1'd0)begin
          cmd_valid  <=1'd1;
          flag<=1'd1;
        end
        if(cmd_valid==1'b1)
          cmd_valid  <=1'd0;
        if(done)begin
          flow_cnt<=flow_cnt+1'd1;
          flag<=1'd0;
          $display("Cycle Count=%d", reg_file[135:128]);
          $display(" matrix p00 = %x",reg_file[127:96]);
          $display(" matrix p01 = %x", reg_file[95:64]);
          $display(" matrix p10 = %x", reg_file[63:32]);
          $display(" matrix p11 = %x", reg_file[31:0]);
        end
      end
        3'b010:
        begin
          cmd_address<=32'd2;
        if(flag==1'd0)begin
          cmd_valid  <=1'd1;
          flag<=1'd1;
        end
        if(cmd_valid==1'b1)
          cmd_valid  <=1'd0;
        if(done)begin
          flow_cnt<=flow_cnt+1'd1;
          flag<=1'd0;
          $display("Cycle Count=%d", reg_file[135:128]);
          $display(" matrix p00 = %x",reg_file[127:96]);
          $display(" matrix p01 = %x", reg_file[95:64]);
          $display(" matrix p10 = %x", reg_file[63:32]);
          $display(" matrix p11 = %x", reg_file[31:0]);
        end
      end
        3'b011:
        begin
          cmd_address<=32'd3;
        if(flag==1'd0)begin
          cmd_valid  <=1'd1;
          flag<=1'd1;
        end
        if(cmd_valid==1'b1)
          cmd_valid  <=1'd0;
        if(done)begin
          flow_cnt<=flow_cnt+1'd1;
          flag<=1'd0;
          $display("Cycle Count=%d", reg_file[135:128]);
          $display(" matrix p00 = %x",reg_file[127:96]);
          $display(" matrix p01 = %x", reg_file[95:64]);
          $display(" matrix p10 = %x", reg_file[63:32]);
          $display(" matrix p11 = %x", reg_file[31:0]);
        end
      end
        3'b100:
        begin
          cmd_address<=32'd4;
        if(flag==1'd0)begin
          cmd_valid  <=1'd1;
          flag<=1'd1;
        end
        if(cmd_valid==1'b1)
          cmd_valid  <=1'd0;
        if(done)begin
          flow_cnt<=flow_cnt+1'd1;
          flag<=1'd0;
          $display("Cycle Count=%d", reg_file[135:128]);
          $display(" matrix p00 = %x",reg_file[127:96]);
          $display(" matrix p01 = %x", reg_file[95:64]);
          $display(" matrix p10 = %x", reg_file[63:32]);
          $display(" matrix p11 = %x", reg_file[31:0]);
        end
      end
        3'b101:
        begin
          cmd_address<=32'd5;
        if(flag==1'd0)begin
          cmd_valid  <=1'd1;
          flag<=1'd1;
        end
        if(cmd_valid==1'b1)
          cmd_valid  <=1'd0;
        if(done)begin
          flow_cnt<=flow_cnt+1'd1;
          flag<=1'd0;
          $display("Cycle Count=%d", reg_file[135:128]);
          $display(" matrix p00 = %x",reg_file[127:96]);
          $display(" matrix p01 = %x", reg_file[95:64]);
          $display(" matrix p10 = %x", reg_file[63:32]);
          $display(" matrix p11 = %x", reg_file[31:0]);
        end
      end
        3'b110:
        begin
          cmd_address<=32'd6;
        if(flag==1'd0)begin
          cmd_valid  <=1'd1;
          flag<=1'd1;
        end
        if(cmd_valid==1'b1)
          cmd_valid  <=1'd0;
        if(done)begin
          flow_cnt<=flow_cnt+1'd1;
          flag<=1'd0;
          $display("Cycle Count=%d", reg_file[135:128]);
          $display(" matrix p00 = %x",reg_file[127:96]);
          $display(" matrix p01 = %x", reg_file[95:64]);
          $display(" matrix p10 = %x", reg_file[63:32]);
          $display(" matrix p11 = %x", reg_file[31:0]);
        end
      end
        3'b111:
        begin
          cmd_address<=32'd7;
        if(flag==1'd0 && stop==1'b0)begin
          cmd_valid  <=1'd1;
          flag<=1'd1;
        end
        if(cmd_valid==1'b1)
          cmd_valid  <=1'd0;
        if(done)begin
          flow_cnt<=flow_cnt;
          flag<=1'd0;
          stop<=1'b1;
          $display("Cycle Count=%d", reg_file[135:128]);
          $display(" matrix p00 = %x",reg_file[127:96]);
          $display(" matrix p01 = %x", reg_file[95:64]);
          $display(" matrix p10 = %x", reg_file[63:32]);
          $display(" matrix p11 = %x", reg_file[31:0]);
        end
      end
          default:;
          endcase

        end
        endmodule