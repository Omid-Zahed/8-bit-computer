module THR_SUN(
    input clk,
    reg [7:0] input_user,
    output [7:0] output_user
);



// create wire for connecting components
wire [3:0] ram_address;
wire [7:0] ram_data_in;
wire ram_read_enable;
wire ram_write_enable;
wire [7:0] ram_data_out;









// create ram for store data
ram_16x8 ram(

    .address(ram_address),
    .data_in(ram_data_in),
    .read_enable(ram_read_enable),
    .write_enable(ram_write_enable),
    .data_out(ram_data_out)
);




// create cpu
cpu core(
    clk,active_cpu,0,
    input_user,
    ram_data_out,
    output_user,
    
    ram_write_enable,
    ram_read_enable,
    ram_address,
    ram_data_in
    );









endmodule