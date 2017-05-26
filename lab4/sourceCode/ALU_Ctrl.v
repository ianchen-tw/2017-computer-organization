//Subject:     CO project 4
//--------------------------------------------
//Student: 0411276 Chen Yi An
//Student: 0413335 Kuo Yi Lin
//--------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [4-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter
parameter ALU_AND  = 4'd0;
parameter ALU_OR   = 4'd1;
parameter ALU_ADD  = 4'd2;
parameter ALU_SUB  = 4'd3;
parameter ALU_SLT  = 4'd4;
parameter ALU_SLTU = 4'd5;
parameter ALU_BNE  = 4'd6;
parameter ALU_SLL  = 4'd7;
parameter ALU_SLLV = 4'd8;
parameter ALU_LUI  = 4'd9;
parameter ALU_ORI  = 4'd10;
parameter ALU_MULT = 4'd11;
//parameter ALU_PC_ADD4  = 4'd12;
parameter ALU_DONTCARE = 4'bxxxx;


/*------------------------------------------------------------------
    The OP_Fields not listed here would make ALU_control simply
     send an 4bit dontcare control value to the alu,
     since These type of instrucitons don't rely on the use of alu.  
--------------------------------------------------------------------*/ 
parameter OP_FIELD_0  = 4'd0;
//parameter OP_FIELD_3  = 4'd1;
parameter OP_FIELD_4  = 4'd2; 
parameter OP_FIELD_5  = 4'd3;
//parameter OP_FIELD_6  = 4'd4;
//parameter OP_FIELD_7  = 4'd5;
parameter OP_FIELD_8  = 4'd6; 
parameter OP_FIELD_13 = 4'd7; 
parameter OP_FIELD_15 = 4'd8;
parameter OP_FIELD_35 = 4'd9;
parameter OP_FIELD_43 = 4'd10;


//Select the "exact" operation that alu would do
always @(*)begin
    //I-type instrucitons
         //I-type instrucitons have higher priority than R-type ones in 
         //incstruciton decoding 
    if( ALUOp_i != OP_FIELD_0 )begin
        case( ALUOp_i)
            OP_FIELD_4:  ALUCtrl_o = ALU_SUB ;
            OP_FIELD_5:  ALUCtrl_o = ALU_BNE;
            OP_FIELD_8:  ALUCtrl_o = ALU_ADD ;
            OP_FIELD_13: ALUCtrl_o = ALU_ORI ;
            OP_FIELD_15: ALUCtrl_o = ALU_LUI ;
            OP_FIELD_35: ALUCtrl_o = ALU_ADD ; //LW
            OP_FIELD_43: ALUCtrl_o = ALU_ADD ; //Sw
            default: 
                ALUCtrl_o = ALU_DONTCARE;
        endcase
    end

    //R-type instrucitons 
    //OP_field == 0
	else begin
    case( { ALUOp_i, funct_i } )
        { OP_FIELD_0,  6'h00 }: ALUCtrl_o = ALU_SLL  ;
        { OP_FIELD_0,  6'h04 }: ALUCtrl_o = ALU_SLLV ;
        { OP_FIELD_0,  6'h18 }: ALUCtrl_o = ALU_MULT ;
        { OP_FIELD_0,  6'h20 }: ALUCtrl_o = ALU_ADD  ;
        { OP_FIELD_0,  6'h22 }: ALUCtrl_o = ALU_SUB  ;
        { OP_FIELD_0,  6'h24 }: ALUCtrl_o = ALU_AND  ;
        { OP_FIELD_0,  6'h25 }: ALUCtrl_o = ALU_OR   ;
        { OP_FIELD_0,  6'h2a }: ALUCtrl_o = ALU_SLT  ;
        { OP_FIELD_0,  6'h2b }: ALUCtrl_o = ALU_SLTU ;
        default: 
            ALUCtrl_o = ALU_DONTCARE;
    endcase 
	 end
end

endmodule     