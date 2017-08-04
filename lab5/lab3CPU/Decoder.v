//Subject:     CO project 3 
//--------------------------------------------
//Student: 0411276 Chen Yi An
//Student: 0413335 Kuo Yi Lin
//--------------------------------------------

module Decoder(
input	[6-1:0]instr_op_i,
input [6-1:0]instr_funct_i, 
output	reg 				RegWrite_o,
output	reg [4-1:0]	ALU_op_o,
output	reg					ALUSrc_o,
output	reg	[2-1:0]	RegDst_o,
output	reg					Branch_o,
output	reg [2-1:0]	Jump_o,
output	reg [2-1:0]	MemToReg_o,
output	reg [2-1:0]	BranchType_o,
output	reg					MemRead_o,
output	reg					MemWrite_o
	);
	
//Internal signals

//indiacate the Branch_Type
parameter bType_BNEZ 	= 2'd3;
parameter bType_BLT 	= 2'd2;
parameter bType_BLE 	= 2'd1;
parameter bType_BEQ 	= 2'd0;

//{RegWrite_o, RegDst_o }
parameter REG_NO_WRITE 		= 3'b0_xx;
parameter REG_WRITE_SRC_RT 	= 3'b1_00;
parameter REG_WRITE_SRC_RD 	= 3'b1_01;
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
parameter MToR_IMMDT 	= 2'd2;  


parameter ALU_SRC_REG 	= 1'b0;
parameter ALU_SRC_IMMDT = 1'b1;

parameter JUMP_NO 	= 2'd0;
parameter JUMP_YES	= 2'd1;
parameter JUMP_JR		= 2'd2;

parameter DONTCARE1 = 1'bx;
parameter DONTCARE2 = 2'bxx; 
parameter DONTCARE4 = 4'bxxxx;

//Main function
	always@(*)begin
	  case (instr_op_i)
	  	6'd0:begin 
				if( instr_funct_i == 6'h08)begin //Jump Regsiter --Representative instruction of this datapath 
					ALU_op_o                  <= DONTCARE4;
					ALUSrc_o                  <= DONTCARE1;
					{ RegWrite_o, RegDst_o }  <= REG_NO_WRITE;
					MemToReg_o                <= DONTCARE2;
					{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
					{ Branch_o, BranchType_o, Jump_o } <= { 1'b0, DONTCARE2, JUMP_JR};
				end
				else begin //Add	
					ALU_op_o                  <= 4'd0;
					ALUSrc_o                  <= ALU_SRC_REG;
					{ RegWrite_o, RegDst_o }  <= REG_WRITE_SRC_RD;
					MemToReg_o                <= MToR_ALU ;
					{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
					{ Branch_o, BranchType_o, Jump_o } <= { 1'b0, DONTCARE2, JUMP_NO};
		    end
			end

		6'd2:begin // Jump
			ALU_op_o                  <= DONTCARE4 ;
			ALUSrc_o                  <= DONTCARE1 ;
			{ RegWrite_o, RegDst_o }  <= REG_NO_WRITE ;
			MemToReg_o                <= DONTCARE2 ;
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			{ Branch_o, BranchType_o, Jump_o } 	<= { 1'b0, DONTCARE2, JUMP_YES};
		  end


		6'd3:begin // JAL: Jump And Link
			ALU_op_o                  <= 4'd1;
			ALUSrc_o                  <= DONTCARE1 ;
			{ RegWrite_o, RegDst_o }  <= REG_JAL; //Special Case
			MemToReg_o                <= MToR_ALU; //The ALU would directly ouptut PC+4 
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			{ Branch_o, BranchType_o, Jump_o } 	<= { 1'b0, DONTCARE2, JUMP_YES};
		  end

		6'd4:begin //BEQ
			ALU_op_o                  <= 4'd2;
			ALUSrc_o                  <= ALU_SRC_REG ;
			{ RegWrite_o, RegDst_o }  <= REG_NO_WRITE;
			MemToReg_o                <= DONTCARE2;
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			{ Branch_o, BranchType_o, Jump_o } 	<= { 1'b1, bType_BEQ, JUMP_NO};
		  end

		6'd5:begin	//BNEZ
			ALU_op_o                  <= 4'd3;
			ALUSrc_o                  <= DONTCARE1 ;//The output of ALu is simply depend on "RS" field 
			{ RegWrite_o, RegDst_o }  <= REG_NO_WRITE;
			MemToReg_o                <= DONTCARE2;
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			{ Branch_o, BranchType_o, Jump_o } 	<= { 1'b1, bType_BNEZ, JUMP_NO};
		  end

		6'd6:begin //BLT : Branch Less Than
			ALU_op_o                  <= 4'd4;
			ALUSrc_o                  <= ALU_SRC_REG ;
			{ RegWrite_o, RegDst_o }  <= REG_NO_WRITE;
			MemToReg_o                <= DONTCARE2;
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			{ Branch_o, BranchType_o, Jump_o } 	<= { 1'b1, bType_BLT, JUMP_NO};
		  end

		6'd7:begin //BLE : Branch Less Equal
			ALU_op_o                  <= 4'd5;
			ALUSrc_o                  <= ALU_SRC_REG ;
			{ RegWrite_o, RegDst_o }  <= REG_NO_WRITE;
			MemToReg_o                <= DONTCARE2;
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			{ Branch_o, BranchType_o, Jump_o } 	<= { 1'b1, bType_BLE, JUMP_NO};
		  end

		6'd8:begin //ADDI
			ALU_op_o                  <= 4'd6;
			ALUSrc_o                  <= ALU_SRC_IMMDT;
			{ RegWrite_o, RegDst_o }  <= REG_WRITE_SRC_RT;
			MemToReg_o                <= MToR_ALU ;
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			{ Branch_o, BranchType_o, Jump_o } 	<= { 1'b0, DONTCARE2, JUMP_NO};
		  end

		6'd13:begin //ORI
			ALU_op_o                  <= 4'd7;
			ALUSrc_o                  <= ALU_SRC_IMMDT;
			{ RegWrite_o, RegDst_o }  <= REG_WRITE_SRC_RT;
			MemToReg_o                <= MToR_ALU ;
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS;
			{ Branch_o, BranchType_o, Jump_o } 	<= { 1'b0, DONTCARE2, JUMP_NO};
		  end

		6'd15:begin //LI: Load immediate, make the register RD directly to the immdt value, no memory needed 
			ALU_op_o                  <= DONTCARE4; //ALU must directly ouput the immdt value( immdt address) 
			ALUSrc_o                  <= DONTCARE2;
			{ RegWrite_o, RegDst_o }  <= REG_WRITE_SRC_RT;
			MemToReg_o                <= MToR_IMMDT; //This directly send the Sign Extended immdt value 
																							  // Back to Register File
			{ MemRead_o, MemWrite_o } <= MEM_NO_ACCESS ;
			{ Branch_o, BranchType_o, Jump_o } 	<= { 1'b0, DONTCARE2, JUMP_NO};
		  end

		6'd35:begin //LW: Load Word
					//I-type instruction 
			ALU_op_o                  <= 4'd8; 
			ALUSrc_o                  <= ALU_SRC_IMMDT;
			{ RegWrite_o, RegDst_o }  <= REG_WRITE_SRC_RT;
			MemToReg_o                <= MToR_MEM;
			{ MemRead_o, MemWrite_o } <= MEM_READ;
			{ Branch_o, BranchType_o, Jump_o } 	<= { 1'b0, DONTCARE2, JUMP_NO};
		  end

		6'd43:begin //SW: Store Word 
			//The RT field of the instruciotn is the data need to write to the memory 
			ALU_op_o                  <= 4'd9; //ALU must directly ouput the immdt value( immdt address) 
			ALUSrc_o                  <= ALU_SRC_IMMDT;
			{ RegWrite_o, RegDst_o }  <= REG_NO_WRITE;
			MemToReg_o                <= DONTCARE2;
			{ MemRead_o, MemWrite_o } <= MEM_WRITE;
			{ Branch_o, BranchType_o, Jump_o } 	<= { 1'b0, DONTCARE2, JUMP_NO};
		  end
		default: 
			{ALU_op_o,ALUSrc_o,RegWrite_o,RegDst_o,MemToReg_o,MemRead_o, MemWrite_o,Branch_o, BranchType_o, Jump_o} <= 15'bx ; 
			
	  endcase
	end
endmodule





                    
                    