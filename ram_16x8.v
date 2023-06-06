module ram_16x8(
    input wire [3:0] address,
    input [7:0] data_in,
    input read_enable,
    input write_enable,
    output reg [7:0] data_out
);

reg [7:0] mem [0:15];

always @(address, data_in, read_enable, write_enable) begin
    if (read_enable) begin
        if (address) begin
             data_out = mem[address];
        end else begin
            data_out = mem[4'b0000];
        end

    end 
    if (write_enable) begin
        mem[address] = data_in;
    end
    
end

initial begin



    /*
    -------------------------------
             op         |   code
    -------------------------------
       0000+address    |   load A
    ------------------------------
       0001+address    |   load B
    ------------------------------
       0010+address    |   load output


    -------------------------------
       0011+address    |   store A
    ------------------------------
       0100+address    |   store B
    ------------------------------
       0101+address    |   store input


    -----------------------------
       0110+xxxx       |   A = A + B
    -----------------------------
       0111+xxxx       |   A = A - B
    -----------------------------
       1000+xxxx       |   A = A + 1
    -----------------------------
       1001+xxxx       |   A = A - 1
    -----------------------------


       1010+xxxx       |   A = A && B
    -----------------------------
       1011+xxxx       |   A = A || B
    -----------------------------
       1100+xxxx       |   A = A xor B
    -----------------------------
       1101+xxxx       |   A = !A
    -----------------------------


     -----------------------------
       1110+address     |   jump address
    ----------------------------- 
       1111+xxxx       |   stop
    -----------------------------
           */

 
    //region program load data from ram to register and ---------------------------------
    /*
    //------------------- data section [11-15]
    mem[4'b1011] = 8'b00000000; 
    //  #1 
    mem[4'b1100] = 8'b00001010; 
    // #1;
    mem[4'b1101] = 8'b00001100; 
    // #1
    mem[4'b1110] = 8'b00000011; 
    // #1;
    mem[4'b1111] = 8'b00001110; 
    #1
    //------------------- program section from (0-10) 

    mem[4'b0000] = 8'b00001111;//load 1111 in R A || assert a=1110
    #1;
    mem[4'b0001] = 8'b00011110;// load 1110 in R B || assert b = 0011
    // #1
    mem[4'b0010] = 8'b00101110;// load 1110 in output || assert output = 0011

    // #1;
    mem[4'b0011] = 8'b00101011;// load 1011 in output || assert output = 000
    // #1;
    mem[4'b0100] = 8'b00011100;// load 1100 in B || assert b = 1010
    // #1;
    mem[4'b0101] = 8'b00001011;// load 1011 in A || assert a=0000

    #1;
    mem[4'b0110] = 8'b11111111;// stop
    #1;
    */
    //endregion
    //region program store data register to ram ---------------------------------------
    //------------------- data section [11-15]
    /*
    mem[4'b1011] = 8'b00000000; 
     #1 
    mem[4'b1111] = 8'b00001110; 
    #1
    //------------------- program section from (0-10) 

    mem[4'b0000] = 8'b00001111;//load 1111 in R A || assert a=1110
    #1;
    mem[4'b0001] = 8'b01001011;// store register A in ram[1011] || assert ram[1011]=1110
    #1
    mem[4'b0010] = 8'b01001100;
    // #1
    #1;
    mem[4'b0011] = 8'b11111111;// stop
    #1;
    */
    //endregion
   //region program load a , b and store a + b  in address ram[11] ---------------------
   /*
    mem[4'b1111] = 8'b00000011; 
    mem[4'b1110] = 8'b00000001; 
    mem[4'b1010] = 8'b00000000; //set 10 = 00000000
    //------------------- program section from (0-10) 
    mem[4'b0000] = 8'b00001111; //load 1111 in R A || assert a=0011 
    mem[4'b0001] = 8'b00011110; // load 1110 in R B || assert b = 0001
    mem[4'b0010] = 8'b01101111;  // A = A + B  // assert a = 0100
    mem[4'b0011] = 8'b00111011;    // store A in ram[11]
    mem[4'b0100] = 8'b11111111;// stop
    #1;
    */
   //endregion
   //region program load a , b and store a xor b  in address ram[11] -------------------
   /*
    mem[4'b1111] = 8'b00000011; 
    mem[4'b1110] = 8'b00000001; 
    mem[4'b1010] = 8'b00000000; //set 10 = 00000000
    //------------------- program section from (0-10) 
    mem[4'b0000] = 8'b00001111; //load 1111 in R A || assert a=0011 
    mem[4'b0001] = 8'b00011110; // load 1110 in R B || assert b = 0001
    mem[4'b0010] = 8'b11011000;  // A = ~A  // assert a = 1100
    mem[4'b0011] = 8'b00111011;    // store A in ram[11] 
    mem[4'b0100] = 8'b11111111;// stop
    #1;
      */
   //endregion
    //region get number form user and add --------------------------------------
    mem[4'b0000] = 8'b01011111;      // store input in ram[15]
    mem[4'b0001] = 8'b00001111;      // load input in A
    mem[4'b0010] = 8'b10001111;      // A+=1 :label 1
    mem[4'b0011] = 8'b00111111;      // store in ram[15]
    mem[4'b0100] = 8'b00101111;      // return output [15]
    mem[4'b0101] = 8'b11100010;      // jump to :label 1
    mem[4'b0110] = 8'b11111111;      // stop
   //endregion
end
endmodule