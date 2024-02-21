module controller(inst, ALUControl, regsel, dmemwe, 
                     regwe, rs2sel, clk, reset);

    // Input & Outputs
    input wire [31:0]   inst;
    input wire          clk, reset;

    output reg [3:0]    ALUControl; 
    output reg          dmemwe, regwe, regsel, rs2sel;

    // Internal
    wire [6:0]          opcode, funct7;
    wire [2:0]          funct3;

    assign opcode = inst[6:0];
    assign funct3 = inst[14:12];
    assign funct7 = inst[31:25];

    initial begin
        dmemwe      <= 1'b0;
        regwe       <= 1'b0;
        rs2sel      <= 1'b0;
        regsel      <= 1'b0;
        ALUControl  <= 4'b0000;
    end

    always @(*) begin
        case (opcode)
            
            7'b0110011: //////   R-Type instructions
                case (funct3)
                    3'b000:
                        case (funct7)
                            7'b0000000:     // ADD
                                begin
                                    dmemwe      <= 1'b0;
                                    regwe       <= 1'b1;
                                    rs2sel      <= 1'b0;
                                    regsel      <= 1'b0;
                                    ALUControl  <= 4'b0000;
                                end
                            7'b0100000:     // SUB
                                begin
                                    dmemwe      <= 1'b0;
                                    regwe       <= 1'b1;
                                    rs2sel      <= 1'b0;
                                    regsel      <= 1'b0;
                                    ALUControl  <= 4'b0001;
                                end
                        endcase
                    3'b001:
                        case (funct7)
                            7'b0000000:     // SLL
                                begin
                                    dmemwe      <= 1'b0;
                                    regwe       <= 1'b1;
                                    rs2sel      <= 1'b0;
                                    regsel      <= 1'b0
                                    ALUControl  <= 4'b0101;
                                end
                        endcase
                    3'b010:
                        case (funct7)
                            7'b0000000:     // SLT
                                begin
                                    dmemwe      <= 1'b0;
                                    regwe       <= 1'b1;
                                    rs2sel      <= 1'b0;
                                    regsel      <= 1'b0;
                                    ALUControl  <= 4'b1010;
                                end
                        endcase
                    3'b011:
                        case (funct7)
                            7'b0000000:     // SLTU
                                begin
                                    dmemwe      <= 1'b0;
                                    regwe       <= 1'b1;
                                    rs2sel      <= 1'b0;
                                    regsel      <= 1'b0;
                                    ALUControl  <= 4'b1001;
                                end
                        endcase
                    3'b100:
                        case (funct7)
                            7'b0000000:     // XOR
                                begin
                                    dmemwe      <= 1'b0;
                                    regwe       <= 1'b1;
                                    rs2sel      <= 1'b0;
                                    regsel      <= 1'b0;
                                    ALUControl  <= 4'b0100;
                                end
                        endcase
                    3'b101:
                        case (funct7)
                            7'b0000000:     // SRL
                                begin
                                    dmemwe      <= 1'b0;
                                    regwe       <= 1'b1;
                                    rs2sel      <= 1'b0;
                                    regsel      <= 1'b0;
                                    ALUControl  <= 4'b0110;
                                end
                            7'b0100000:     // SRA
                                begin
                                    dmemwe      <= 1'b0;
                                    regwe       <= 1'b1;
                                    rs2sel      <= 1'b0;
                                    regsel      <= 1'b0;
                                    ALUControl  <= 4'b0111;
                                end
                        endcase
                    3'b110:
                        case (funct7)
                            7'b0000000:     // OR
                                begin
                                    dmemwe      <= 1'b0;
                                    regwe       <= 1'b1;
                                    rs2sel      <= 1'b0;
                                    regsel      <= 1'b0;
                                    ALUControl  <= 4'b0011;
                                end
                        endcase
                    3'b111:
                        case (funct7)
                            7'b0000000:     // AND
                                begin
                                    dmemwe      <= 1'b0;
                                    regwe       <= 1'b1;
                                    rs2sel      <= 1'b0;
                                    regsel      <= 1'b0;
                                    ALUControl  <= 4'b0010;
                                end
                        endcase
                endcase
            7'b0010011:  /// I-type instructions
                begin
                    case (funct3)
                        3'b000:     // ADDI
                            begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b0;
                                ALUControl  <= 4'b0000;
                            end
                        3'b010:     // SLTI
                            begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b0;
                                ALUControl  <= 4'b1010;
                            end
                        3'b011:     // SLTIU
                            begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b0;
                                ALUControl  <= 4'b1001;
                            end
                        3'b100:     // XORI
                            begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b0;
                                ALUControl  <= 4'b0100;
                            end
                        3'b110:     // ORI
                            begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b0;
                                ALUControl  <= 4'b0011;
                            end
                        3'b111:     // ANDI
                            begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b0;
                                ALUControl  <= 4'b0010;
                            end
                        3'b001:
                            case (funct7)
                                7'b0000000:     // SLLI
                                    begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b0;
                                ALUControl  <= 4'b0101;
                                    end
                            endcase
                        3'b101:     
                            case (funct7)
                                7'b0000000:     // SRLI
                                    begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b0;
                                ALUControl  <= 4'b0110;
                                    end
                                7'b0100000:     // SRAI
                                    begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b0;
                                ALUControl  <= 4'b0111;
                                    end
                            endcase
                    endcase
                end
            
           7'b0000011:
                begin
                    case (funct3)
                        3'b000:     // LB
                            begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b1;
                                ALUControl  <= 4'b0000;
                            end
                        3'b001:     // LH
                            begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b1;
                                ALUControl  <= 4'b0000;
                            end
                        3'b010:     // LW
                            begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b1;
                                ALUControl  <= 4'b0000;
                            end
                        3'b100:     // LBU
                            begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b1;
                                ALUControl  <= 4'b0000;
                            end
                        3'b101:     // LHU
                            begin
                                dmemwe      <= 1'b0;
                                regwe       <= 1'b1;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b1;
                                ALUControl  <= 4'b0000;
                            end
                    endcase
                end
            7'b0100011:
                begin
                    case (funct3)
                        3'b000:     // SB
                            begin
                                dmemwe      <= 1'b1;
                                regwe       <= 1'b0;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b1;
                                ALUControl  <= 4'b0000;
                            end
                        3'b001:     // SH
                            begin
                                dmemwe      <= 1'b1;
                                regwe       <= 1'b0;
                                rs2sel      <= 1'b1;
                                regSEL      <= 1'b1;
                                ALUControl  <= 4'b0000;
                            end
                        3'b010:     // SW
                            begin
                                dmemwe      <= 1'b1;
                                regwe       <= 1'b0;
                                rs2sel      <= 1'b1;
                                regsel      <= 1'b1;
                                ALUControl  <= 4'b0000;
                            end
                    endcase
                end
            default:
                begin
                    dmemwe      <= 1'b0;
                    regwe       <= 1'b0;
                    rs2sel      <= 1'b0;
                    regsel      <= 1'b0;
                    ALUControl  <= 4'b0000;
                end
        endcase
    end
endmodule
