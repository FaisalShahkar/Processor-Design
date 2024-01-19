module decoder(input wire [32-1:0] instruction,
               output wire [6-1:0] operation,	
               output wire [7-1:0] opcode,
               output wire [3-1:0] funct3,
               // 00000 - ADD 
               // 00001 - Sub
               // 00010 - AND
               output wire use_imm,
               reg [6-1:0] op,				// if 1 use imm source
               output wire [5-1:0] rd, 		//address for source values 
               output wire [5-1:0] rs1,
               output wire [5-1:0] rs2,
               output wire [7-1:0] funct7,
               output wire [12-1:0] imm);
               assign operation = op;
  
  assign opcode	= instruction [6:0];
  assign rd		= instruction [11:7];
  assign funct3	= instruction [14:12];
  assign rs1	= instruction [19:15];
  assign rs2	= instruction [24:20];
  assign funct7	= instruction [25:31];
  assign imm	= instruction [31:20];
  assign use_imm = (opcode == 7'b0010011);
  always(*)
    begin
      if(opcode == 7'b0110011) //// R-Type instruction
        begin
        if(funct3 == 3'b0 && funct7 == 7'b0)
          begin 
            op = 6'b0; //add
          end
          else if(funct3 == 3'b0 && funct7 == 7'b0100000)
            begin
              op = 6'b000001; //sub
            end 
          else if(funct3 == 3'b111 && funct7 == 7'b0)
            begin 
              op = 6'b000010;//and 
            end 
          else 
            begin
              op = 6'b111111; //nop
            end 
        end
    end 
  else if(opcode==7'b0010011) //// I-Type instruction
        begin
          if(funct3 == 3'b000)
            begin
              opcode = 6'b0;            
            end
          else if(funct3 == 3'b001)
            begin
              opcode = 6'b0; //ADDI
            end 
          else if(funct3 == 3'b111)
            begin
              opcode = 6'b000010;//ANDI
            end 
        end
        
  end 
          else
            begin
              op = 6'b111111;//nop
            end
          else
            begin
              op = 6'b111111;//nop
            end 
          end                  
    end
endmodule 
