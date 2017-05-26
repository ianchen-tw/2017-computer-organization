//Subject:     CO project 4
//--------------------------------------------
//Student: 0411276 Chen Yi An
//Student: 0413335 Kuo Yi Lin
//--------------------------------------------

module Decoder(
input	    	[6-1:0] instr_op_i,
input       [6-1:0] instr_funct_i, 
output	reg 				RegWrite_o,
output	reg [4-1:0]	ALU_op_o,
output	reg					ALUSrc_o,
output	reg					RegDst_o,
output	reg					Branch_o,
output	reg [2-1:0]	MemToReg_o,
output	reg					MemRead_o,
output	reg					MemWrite_o
	);
	
//Internal signals

/**Not used
//indiacate the Branch_Type
parameter bType_BNEZ 	= 2'd3;
parameter bType_BLT 	= 2'd2;
parameter bType_BLE 	= 2'd1;
parameter bType_BEQ 	= 2'd0;
*/

//{RegWrite_o, RegDst_o }
parameter REG_NO_WRITE 		= 2'b0_x;
parameter REG_WRITE_SRC_RT 	= 2'b1_0;
parameter REG_WRITE_SRC_RD 	= 2'b1_1;
parameter REG_JAL           = 3'b1_10;//designed for Jal instruciton 

//{ MemRead_o, MemWrite_o }
parameter MEM_NO_ACCESS = 2'b00;
parameter MEM_READ 		= 2'b10;
parameter MEM_WRITE		= 2'b01;

/*-----------------------------------------------------------------------------
Specify the mux selection value which determined 
		whether the dataflow to Register file came from. 
This selective value is a must-be if writing back to RegisterFile is needed 
------------------------------------------------------------------------------*/
//MToR: MemtoReg_o 
parameter MToR_ALU 		= 2'd0;
parameter MToR_MEM 		= 2'd1; 

parameter ALU_SRC_REG 	= 1'b0;
parameter ALU_SRC_IMMDT = 1'b1;

parameter JUMP_NO 	= 2'd0;
parameter JUMP_YES	= 2'd1;

parameter DONTCARE1 = 1'bx;
parameter DONTCARE2 = 2'bxx; 
parameter DONTCARE4 = 4'bxxxx;

//Main function
	always@(*)begin
	  case (instr_op_i)
	  	6'd0:
			begin //Add	
            ALU_op_o                  <= 4'd0;
            ALUSrc_o                  <= ALU_SRC_REG;
            { RegWrite_o, RegDst_o }  <= REG_WRITE_SRC_RD;
            MemToReg_o                <= MToR_ALU ;
            { MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
            Branch_o <= 1'b0;
		    end
		6'd4:begin //BEQ
			ALU_op_o                  <= 4'd2;
			ALUSrc_o                  <= ALU_SRC_REG ;
			{ RegWrite_o, RegDst_o }  <= REG_NO_WRITE;
			MemToReg_o                <= DONTCARE2;
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			Branch_o <= 1'b1;
		  end

		6'd5:begin	//BNE
			ALU_op_o                  <= 4'd3;
			ALUSrc_o                  <= DONTCARE1 ;//The output of ALu is simply depend on "RS" field 
			{ RegWrite_o, RegDst_o }  <= REG_NO_WRITE;
			MemToReg_o                <= DONTCARE2;
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			Branch_o <= 1'b1;
		  end

		6'd8:begin //ADDI
			ALU_op_o                  <= 4'd6;
			ALUSrc_o                  <= ALU_SRC_IMMDT;
			{ RegWrite_o, RegDst_o }  <= REG_WRITE_SRC_RT;
			MemToReg_o                <= MToR_ALU ;
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			Branch_o <= 1'b0;
		  end

		6'd13:begin //ORI
			ALU_op_o                  <= 4'd7;
			ALUSrc_o                  <= ALU_SRC_IMMDT;
			{ RegWrite_o, RegDst_o }  <= REG_WRITE_SRC_RT;
			MemToReg_o                <= MToR_ALU ;
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			Branch_o <= 1'b0;
		  end

		6'd15:begin //LUI 
                    //�要修alu_op_o �alu_control �代�� 以�alu 中新�lui 專屬行為 
			ALU_op_o                  <= 4'd8; 
			ALUSrc_o                  <= ALU_SRC_IMMDT;
			{ RegWrite_o, RegDst_o }  <= REG_WRITE_SRC_RT;
			MemToReg_o                <= MToR_ALU; 
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS ;
			Branch_o <= 1'b0;
		  end

		6'd35:begin //LW: Load Word
					//I-type instruction 
			ALU_op_o                  <= 4'd9; 
			ALUSrc_o                  <= ALU_SRC_IMMDT;
			{ RegWrite_o, RegDst_o }  <= REG_WRITE_SRC_RT;
			MemToReg_o                <= MToR_MEM;
			{ MemRead_o, MemWrite_o } <= MEM_READ;
			Branch_o <= 1'b0;
		  end

		6'd43:begin //SW: Store Word 
			//The RT field of the instruciotn is the data need to write to the memory 
			ALU_op_o                  <= 4'd10; //ALU must directly ouput the immdt value( immdt address) 
			ALUSrc_o                  <= ALU_SRC_IMMDT;
			{ RegWrite_o, RegDst_o }  <= REG_NO_WRITE;
			MemToReg_o                <= DONTCARE2;
			{ MemRead_o, MemWrite_o } <= MEM_WRITE;
			Branch_o <= 1'b0;
		  end
		default: 
			{ALU_op_o,ALUSrc_o,RegWrite_o,RegDst_o,MemToReg_o,MemRead_o, MemWrite_o,Branch_o} <= 'bx ; 
			
	  endcase
	end
endmodule




