module cu (
    input clk, [7:0] timer,  [15:0] IR_dicode,
    output reg reset_timer,reg ram_enable_write ,reg ram_enable_read,reg load_AR,reg inc_PC,reg load_PC,reg [2:0] bus_select ,reg load_IR,
    reg Load_A, reg Load_B,reg load_Temp,reg Load_output,
    reg finish_signal, reg [2:0] alu_select
   
);
 


always @( posedge clk) begin
    if (timer[0] == 1) begin //lets go
        //if timer == 1 => { load AR = 1 , bus = pc }
        ram_enable_read = 0;
        ram_enable_write = 0;
        inc_PC= 0;
        load_PC = 0;
        load_IR = 0;
        Load_A = 0;
        Load_B = 0;
        Load_output = 0;
        bus_select = 0;
        load_Temp= 0;
        load_AR = 1;
        bus_select = 4'b000;
        reset_timer = 0; 
    end

     if (timer[1] == 1) begin
        //if timer == 2 =>  pc = pc + 1 , bus = ram  , IR <- ram[address]
        load_AR = 0;
        ram_enable_read = 1;
        bus_select = 3'b001;
        load_IR = 1;
     end 

      if (timer[2] == 1) begin 
          inc_PC = 1;
          load_IR = 0;
    end
    if (timer[3] == 1 ) begin
      
         inc_PC = 0;
    end
 

    //region finish loop
    if (timer[3] == 1 && IR_dicode[15] == 1) begin
        reset_timer = 1;
        finish_signal = 1;
    end
    //region jump 
    if ( IR_dicode[14] == 1) begin
        
         if (timer[3] == 1) begin
              bus_select = 4'b0010;
              load_PC = 1;
         end
         
          if (timer[4] == 1) begin
            load_PC = 0;
         end

          if (timer[5] == 1) begin
              reset_timer = 1; 
         end
       
    end
   //endregion------------------------------------------
    //region load Data from Ram to ( A , B , OUTPUT ) 
      if (timer[3] == 1 && ((IR_dicode[0] == 1)||(IR_dicode[1] == 1)||(IR_dicode[2] == 1))) begin
         load_AR = 1;
               if (IR_dicode[0] == 1 ) begin
                 Load_A = 1;
              end
              if (IR_dicode[1] == 1) begin
                 Load_B = 1;
              end
              if (IR_dicode[2] == 1) begin
                 Load_output = 1;
              end
     end
     if (timer[4] == 1 && ((IR_dicode[0] == 1)||(IR_dicode[1] == 1)||(IR_dicode[2] == 1))) begin 
            load_AR = 0;
            bus_select = 4'b0001;
            ram_enable_read = 1 ;
            Load_A = 0;
            Load_B = 0;
            Load_output = 0;
              
      end
      if (timer[5] == 1 && ((IR_dicode[0] == 1)||(IR_dicode[1] == 1)||(IR_dicode[2] == 1))) begin
         reset_timer = 1; 
      end 
   //endregion-----------------------------------------
    //region store Data to Ram to ( A , B , input ) 
   if (((IR_dicode[3] == 1)||(IR_dicode[4] == 1)||(IR_dicode[5] == 1))) begin

        if(timer[3] == 1) begin
          load_AR = 1;
          bus_select = 3'b010;   
         end
        if (timer[4] == 1 ) begin
             load_AR = 0;
             
               if (IR_dicode[3] == 1) begin
                  bus_select = 3'b011;//store a
               end
               if (IR_dicode[4] == 1) begin
                  bus_select = 3'b100;//store b
               end
               if (IR_dicode[5] == 1) begin
                  bus_select = 3'b110;//store input
               end

        end
        if(timer[5]==1) begin
         ram_enable_write = 1;
        end
        if(timer[6]==1) begin
         ram_enable_write = 0;
        end
        if(timer[7]==1) begin
           reset_timer = 1; 
        end
   end
  //endregion
    //region ALu (+,-,-1,+1,and,or,not,xor) 
   if (((IR_dicode[6] == 1) ||(IR_dicode[7] == 1) ||(IR_dicode[8] == 1) ||(IR_dicode[9] == 1) ||(IR_dicode[10] == 1) ||(IR_dicode[11] == 1)||(IR_dicode[12] == 1)||(IR_dicode[13] == 1) ))begin
     
      if (timer[3] == 1 ) begin

         if(IR_dicode[6] == 1)begin
            alu_select = 3'b010;//+
         end
         
         if(IR_dicode[7] == 1)begin
            alu_select = 3'b011;//-
         end
         
         if(IR_dicode[8] == 1)begin
            alu_select = 3'b111;//+1
         end
         
         if(IR_dicode[9] == 1)begin
            alu_select = 3'b110;//-1
         end
         
         if(IR_dicode[10] == 1)begin
            alu_select = 3'b000;// and 
         end
         
         if(IR_dicode[11] == 1)begin
            alu_select = 3'b001;// or
         end
         
         if(IR_dicode[12] == 1)begin
            alu_select = 3'b101;// xor
         end
         
         if(IR_dicode[13] == 1)begin
            alu_select = 3'b100;//not 
         end
        
         load_Temp = 1;
      end

       if (timer[4] == 1 ) begin
         load_Temp = 0;
         bus_select = 3'b101; // temp 
         Load_A = 1;
      end
       if (timer[5] == 1 ) begin
         reset_timer = 1; 
      end

   end

   //endregion

 

end
  

 


endmodule;




