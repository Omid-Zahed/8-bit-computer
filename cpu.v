
`include "timer.v"
`include "cu.v"
`include "register.v"
`include "decoder_4to16.v"
`include "databus.v"
`include "ram_16x8.v"


module cpu (
 input clk,
 reg stop ,
 reg reset,
 reg [7:0] input_user,
 reg [7:0] ram_input,
 output wire [7:0] output_user,
 wire ram_write_enable,
 wire ram_read_enable,
 reg [3:0] ram_address,
 [7:0] ram_out

 );



wire  [7:0] timer_wire;
wire [15:0] IR_dicode ;



wire load_AR;
wire load_PC;
wire inc_PC;
wire [2:0] bus_select;
wire load_IR;
wire Load_A;
wire Load_B;
wire load_Temp;
wire Load_output;
wire finish_signal;
wire reset_timer;
wire [2:0] alu_select;

wire [7:0] databus_in0;
wire [7:0] databus_in2;
wire [7:0] databus_in3;
wire [7:0] databus_in4;
wire [7:0] databus_in5;
wire [7:0] databus_in6;
wire [7:0] databus_in7;

wire [7:0] data_alu;

wire [7:0] databus_out;


decoder_4to16 decoder(databus_in2[7:4],IR_dicode);
databus databus_(
    databus_in0,
    ram_input,
    databus_in2,
    databus_in3,
    databus_in4,
    databus_in5,
    databus_in6,
    databus_in7,
    bus_select,
    databus_out
);//databus
register PC_re(clk,0,databus_out,inc_PC,load_PC,databus_in0);//pc 0
always @(databus_in7 , databus_out ) begin
    ram_out =  databus_out;// SET RAM INPUT TO INPUT BUS  
    ram_address = databus_in7[3:0];// RAM ADDRESS  = AR (DATABUS_OUT[])
end
register IR_re(clk,0,databus_out,0,load_IR,databus_in2);//ir 2
register A_re(clk,0,databus_out[3:0],0,Load_A,databus_in3);//a 3
register B_re(clk,0,databus_out[3:0],0,Load_B,databus_in4);//b 4

alu Alu(databus_in3,databus_in4,alu_select,data_alu);//alu 
register temp_re(clk,0,data_alu,0,load_Temp,databus_in5); //temp alu 5


register input_re(clk,0,input_user,0,1,databus_in6); //input 6
register AR_re(clk,0,databus_out[3:0],0,load_AR,databus_in7);//address 7
timer timer_(clk,reset_timer,finish_signal,timer_wire);//counter

register out_re(clk,0,databus_out[3:0],0,Load_output,output_user); //output


 

cu cu_(
    clk,  
    timer_wire,IR_dicode,
    reset_timer,
    ram_write_enable,
    ram_read_enable,
    load_AR,
    inc_PC,
    load_PC,
    bus_select,
    load_IR,
    Load_A,
    Load_B,
    load_Temp,
    Load_output,
    finish_signal,
    alu_select
);//cu






endmodule

