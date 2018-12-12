module	VGA_Pattern	(	//	Read Out Side
						oRed,
						oGreen,
						oBlue,
						iVGA_X,
						iVGA_Y,
						iVGA_CLK,
						//	Control Signals
						iRST_n,
						iColor_SW,
						someChar,
						);
//	Read Out Side
output	reg	[9:0]	oRed;
output	reg	[9:0]	oGreen;
output	reg	[9:0]	oBlue;
input	[9:0]		iVGA_X;
input	[9:0]		iVGA_Y;
input				iVGA_CLK;
//	Control Signals
input				iRST_n;
input				iColor_SW;

input [7:0]		someChar;

wire [7:0]		bufferTX [0:4];
wire [7:0]		bufferRX [0:4];

	assign bufferTX[0] = someChar;
	assign bufferTX[1] = "E";
	assign bufferTX[2] = "L";
	assign bufferTX[3] = "L";
	assign bufferTX[4] = "O";

	assign bufferRX[0] = "W";
	assign bufferRX[1] = "O";
	assign bufferRX[2] = "R";
	assign bufferRX[3] = "L";
	assign bufferRX[4] = "D";

integer			it = 0;
integer 			offset;

always@(posedge iVGA_CLK or negedge iRST_n)
begin
offset <= 20+it*50;
	if(!iRST_n)
	begin
		oRed	<=	0;
		oGreen	<=	0;
		oBlue	<=	0;
	end
	else
	begin
		if (bufferTX[it]=="0")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&((iVGA_Y<24)||(iVGA_Y>=96 && iVGA_Y<120)) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=24 && iVGA_Y<96)
			? 15 : 0;
		else 
		if (bufferTX[it]=="1")
			oRed <=
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y<120)
			? 15 : 0;
		else
		if (bufferTX[it]=="2")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y<24) ||
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+20)&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=96 && iVGA_Y<120)
			? 15 : 0;
		else
		if (bufferTX[it]=="3")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y<24) || 
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=96 && iVGA_Y<120) 
			? 15 : 0;
		else
		if (bufferTX[it]=="4")
			oRed <=
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y<48) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=72 && iVGA_Y<120)
			? 15 : 0;
		else
		if (bufferTX[it]=="5")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y<24) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+10)&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=96 && iVGA_Y<120) 
			? 15 : 0;
		else
		if (bufferTX[it]=="6")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y<24) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+20)&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=290 && iVGA_X<300))&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=96 && iVGA_Y<120)
			? 15 : 0;
		else
		if (bufferTX[it]=="7")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y<24) ||
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=24 && iVGA_Y<120)
			? 15 : 0;
		else
		if (bufferTX[it]=="8")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y<24) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+20)||(iVGA_X>=390 && iVGA_X<400))&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=96 && iVGA_Y<120)
			? 15 : 0;
		else
		if (bufferTX[it]=="9")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y<24) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=96 && iVGA_Y<120) 
			? 15 : 0;
		else		
		if (bufferTX[it]=="A" || bufferTX[it]=="a")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&((iVGA_Y<24)||(iVGA_Y>=48 && iVGA_Y<72)) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y<120)
			? 15 : 0;
		else		
		if (bufferTX[it]=="B" || bufferTX[it]=="b")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+20)&&(iVGA_Y<120) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&((iVGA_Y>=48 && iVGA_Y<72)||(iVGA_Y>=96 && iVGA_Y<120)) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=72 && iVGA_Y<96)
			? 15 : 0;
		else		
		if (bufferTX[it]=="C" || bufferTX[it]=="c")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<50)&&((iVGA_Y>=0 && iVGA_Y<132)||(iVGA_Y>=96 && iVGA_Y<120)) ||
			(iVGA_X>=offset+0 && iVGA_X<30)&&(iVGA_Y>=0 && iVGA_Y<120)
			? 15 : 0;
		else		
		if (bufferTX[it]=="D" || bufferTX[it]=="d")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<50)&&((iVGA_Y>=0 && iVGA_Y<132)||(iVGA_Y>=96 && iVGA_Y<120)) ||
			(iVGA_X>=offset+0 && iVGA_X<30)&&(iVGA_Y>=0 && iVGA_Y<120)
			? 15 : 0;
		else		
		if (bufferTX[it]=="E" || bufferTX[it]=="e")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=0 && iVGA_Y<24) || 
			(iVGA_X>=offset+0 && iVGA_X<offset+10)&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+20)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+10)&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+20)&&(iVGA_Y>=96 && iVGA_Y<120) 
			? 15 : 0;
		else
		if (bufferTX[it]=="F" || bufferTX[it]=="f")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=0 && iVGA_Y<24) || 
			(iVGA_X>=offset+0 && iVGA_X<offset+10)&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+10)&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+10)&&(iVGA_Y>=96 && iVGA_Y<120) 
			? 15 : 0;
		else
		if (bufferTX[it]=="G" || bufferTX[it]=="g")
			oRed <=
			(iVGA_X>=offset+10 && iVGA_X<offset+30)&&(iVGA_Y>=0 && iVGA_Y<24) || 
			(iVGA_X>=offset+0 && iVGA_X<offset+10)&&(iVGA_Y>=24 && iVGA_Y<48) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+15 && iVGA_X<offset+30))&&(iVGA_Y>=48 && iVGA_Y<72) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=96 && iVGA_Y<120) 
			? 15 : 0;
		else
		if (bufferTX[it]=="H" || bufferTX[it]=="h")
			oRed <=
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=0 && iVGA_Y<120) || 
			(iVGA_X>=offset+0 && iVGA_X<offset+20)&&(iVGA_Y>=48 && iVGA_Y<72) 
			? 15 : 0;
		else
		if (bufferTX[it]=="I" || bufferTX[it]=="i")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&((iVGA_Y>=0 && iVGA_Y<24)||(iVGA_Y>=96 && iVGA_Y<120)) ||
			(iVGA_X>=offset+10 && iVGA_X<offset+20)&&(iVGA_Y>=0 && iVGA_Y<120) 
			? 15 : 0;
		else
		if (bufferTX[it]=="J" || bufferTX[it]=="j")
			oRed <=
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=0 && iVGA_Y<120) || 
			(iVGA_X>=offset+0 && iVGA_X<offset+20)&&(iVGA_Y>=48 && iVGA_Y<120) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=96 && iVGA_Y<120)
			? 15 : 0;
		else
		if (bufferTX[it]=="K" || bufferTX[it]=="k")
			oRed <=
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&((iVGA_Y>=0 && iVGA_Y<48)||(iVGA_Y>=72 && iVGA_Y<120)) || 
			(iVGA_X>=offset+0 && iVGA_X<offset+20)&&(iVGA_Y>=48 && iVGA_Y<72) 
			? 15 : 0;
		else
		if (bufferTX[it]=="L" || bufferTX[it]=="l")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+10)&&(iVGA_Y>=0 && iVGA_Y<120) || 
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=96 && iVGA_Y<120)
			? 15 : 0;
		else		
		if (bufferTX[it]=="M" || bufferTX[it]=="m")
			oRed <=
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=0 && iVGA_Y<120) || 
			((iVGA_X>=offset+0 && iVGA_X<offset+13)||(iVGA_X>=offset+17 && iVGA_X<offset+30))&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+10 && iVGA_X<offset+20)&&(iVGA_Y>=48 && iVGA_Y<72)
			? 15 : 0;
		else		
		if (bufferTX[it]=="N" || bufferTX[it]=="n")
			oRed <=
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=0 && iVGA_Y<120) || 
			(iVGA_X>=offset+10 && iVGA_X<offset+13)&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+13 && iVGA_X<offset+17)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			(iVGA_X>=offset+17 && iVGA_X<offset+20)&&(iVGA_Y>=0 && iVGA_Y<96)
			? 15 : 0;
		else		
		if (bufferTX[it]=="O" || bufferTX[it]=="o")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&((iVGA_Y>=96 && iVGA_Y<120)||(iVGA_Y>=24 && iVGA_Y<48)) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=24 && iVGA_Y<120)
			? 15 : 0;
		else		
		if (bufferTX[it]=="P" || bufferTX[it]=="p")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+10)&&(iVGA_Y>=0 && iVGA_Y<120) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&((iVGA_Y>=0 && iVGA_Y<24)||(iVGA_Y>=48 && iVGA_Y<72))
			? 15 : 0;
		else		
		if (bufferTX[it]=="Q" || bufferTX[it]=="q")
			oRed <=
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=0 && iVGA_Y<120) ||
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&((iVGA_Y>=0 && iVGA_Y<24)||(iVGA_Y>=48 && iVGA_Y<72))
			? 15 : 0;
		else		
		if (bufferTX[it]=="R" || bufferTX[it]=="r")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+10)&&(iVGA_Y>=24 && iVGA_Y<120) ||
			(iVGA_X>=offset+10 && iVGA_X<offset+20)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=24 && iVGA_Y<48)
			? 15 : 0;
		else		
		if (bufferTX[it]=="S" || bufferTX[it]=="s")
			oRed <=
			(iVGA_X>=offset+10 && iVGA_X<offset+30)&&(iVGA_Y>=0 && iVGA_Y<24) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+10)&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+10 && iVGA_X<offset+20)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			(iVGA_X>=offset+20 && iVGA_X<offset+30)&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+20)&&(iVGA_Y>=96 && iVGA_Y<120)
			? 15 : 0;
		else		
		if (bufferTX[it]=="T" || bufferTX[it]=="t")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=0 && iVGA_Y<24) ||
			(iVGA_X>=offset+10 && iVGA_X<offset+20)&&(iVGA_Y>=0 && iVGA_Y<120)
			? 15 : 0;
		else		
		if (bufferTX[it]=="U" || bufferTX[it]=="u")
			oRed <=
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=0 && iVGA_Y<120) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=96 && iVGA_Y<120)
			? 15 : 0;
		else		
		if (bufferTX[it]=="V" || bufferTX[it]=="v")
			oRed <=
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=0 && iVGA_Y<72) ||
			((iVGA_X>=offset+5 && iVGA_X<offset+15)||(iVGA_X>=offset+15 && iVGA_X<offset+25))&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+10 && iVGA_X<offset+20)&&(iVGA_Y>=96 && iVGA_Y<120)
			? 15 : 0;
		else		
		if (bufferTX[it]=="W" || bufferTX[it]=="w")
			oRed <=
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&(iVGA_Y>=0 && iVGA_Y<120) ||
			((iVGA_X>=offset+10 && iVGA_X<offset+13)||(iVGA_X>=offset+17 && iVGA_X<offset+20))&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+13 && iVGA_X<offset+17)&&(iVGA_Y>=48 && iVGA_Y<72)
			? 15 : 0;
		else		
		if (bufferTX[it]=="X" || bufferTX[it]=="x")
			oRed <=
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&((iVGA_Y>=0 && iVGA_Y<24)||(iVGA_Y>=96 && iVGA_Y<120)) ||
			((iVGA_X>=offset+3 && iVGA_X<offset+13)||(iVGA_X>=offset+17 && iVGA_X<offset+27))&&((iVGA_Y>=24 && iVGA_Y<48)||(iVGA_Y>=72 && iVGA_Y<96)) ||
			(iVGA_X>=offset+10 && iVGA_X<offset+20)&&(iVGA_Y>=48 && iVGA_Y<72)
			? 15 : 0;
		else		
		if (bufferTX[it]=="Y" || bufferTX[it]=="y")
			oRed <=
			((iVGA_X>=offset+0 && iVGA_X<offset+10)||(iVGA_X>=offset+20 && iVGA_X<offset+30))&&((iVGA_Y>=0 && iVGA_Y<24)) ||
			((iVGA_X>=offset+3 && iVGA_X<offset+13)||(iVGA_X>=offset+17 && iVGA_X<offset+27))&&((iVGA_Y>=24 && iVGA_Y<48)) ||
			(iVGA_X>=offset+10 && iVGA_X<offset+20)&&(iVGA_Y>=48 && iVGA_Y<120)
			? 15 : 0;
		else
		if (bufferTX[it]=="Z" || bufferTX[it]=="z")
			oRed <=
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=0 && iVGA_Y<24) ||
			(iVGA_X>=offset+15 && iVGA_X<offset+25)&&(iVGA_Y>=24 && iVGA_Y<48) ||
			(iVGA_X>=offset+10 && iVGA_X<offset+20)&&(iVGA_Y>=48 && iVGA_Y<72) ||
			(iVGA_X>=offset+5 && iVGA_X<offset+15)&&(iVGA_Y>=72 && iVGA_Y<96) ||
			(iVGA_X>=offset+0 && iVGA_X<offset+30)&&(iVGA_Y>=96 && iVGA_Y<120)
			? 15 : 0;		
		else
			oRed<=7;
		
		oBlue<=oRed;
	end
end

endmodule