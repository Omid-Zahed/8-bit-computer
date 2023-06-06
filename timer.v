module timer(clk, reset, stop, out);
  input clk, reset, stop;
  output reg [7:0] out;
  
  always @(posedge clk or reset , stop) begin
    if (reset) begin
      out <= 8'd1;
    end else if (stop) begin
      out <= 8'd0;
    end else begin
        case(out)
        8'd1: out <= 8'd2;
        8'd2: out <= 8'd4;
        8'd4: out <= 8'd8;
        8'd8: out <= 8'd16;
        8'd16: out <= 8'd32;
        8'd32: out <= 8'd64;
        8'd64: out <= 8'd128;
        8'd128: out <= 8'd1;
        default:out <= 8'd1;
      endcase
      if (!out && !reset && !stop) begin
        out <= 8'd1;
      end
    end
    
    
  end
endmodule