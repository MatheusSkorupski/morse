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

wire [7:0]		bufferTX [0:4];
wire [7:0]		bufferRX [0:4];

	assign bufferTX[0] = "H";
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

always@(posedge iVGA_CLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oRed	<=	0;
		oGreen	<=	0;
		oBlue	<=	0;
	end
	else
	begin
	for (it = 0; it<5; it=it+1)
		begin
		if (bufferTX[it]=="1")
			if (
			((iVGA_X>=(20+it*50)+20 && iVGA_X<(20+it*50)+30)&&(iVGA_Y<120)) && bufferTX[it]
			)
			oRed <= 15;
		else if (bufferTX[it]=="H")
			if (
			((iVGA_X>=(20+it*50)+0 && iVGA_X<(20+it*50)+10)||(iVGA_X>=(20+it*50)+20 && iVGA_X<(20+it*50)+30))&&(iVGA_Y>=120 && iVGA_Y<240) || 
			(iVGA_X>=(20+it*50)+0 && iVGA_X<(20+it*50)+20)&&(iVGA_Y>=168 && iVGA_Y<192) 
			)
			oRed <= 15;
		else if (bufferTX[it]=="E")
			if (
			(iVGA_X>=(20+it*50)+0 && iVGA_X<(20+it*50)+30)&&(iVGA_Y>=120 && iVGA_Y<144) || 
			(iVGA_X>=(20+it*50)+0 && iVGA_X<(20+it*50)+10)&&(iVGA_Y>=144 && iVGA_Y<168) ||
			(iVGA_X>=(20+it*50)+0 && iVGA_X<(20+it*50)+20)&&(iVGA_Y>=168 && iVGA_Y<192) ||
			(iVGA_X>=(20+it*50)+0 && iVGA_X<(20+it*50)+10)&&(iVGA_Y>=192 && iVGA_Y<216) ||
			(iVGA_X>=(20+it*50)+0 && iVGA_X<(20+it*50)+20)&&(iVGA_Y>=216 && iVGA_Y<240) 
			)
			oRed <= 15;
		else if (bufferTX[it]=="L")
			if (
			(iVGA_X>=(20+it*50)+0 && iVGA_X<(20+it*50)+10)&&(iVGA_Y>=120 && iVGA_Y<240) || 
			(iVGA_X>=(20+it*50)+0 && iVGA_X<(20+it*50)+30)&&(iVGA_Y>=216 && iVGA_Y<240)
			)
			oRed <= 15;
		else if (bufferTX[it]=="O")
			if (
			(iVGA_X>=(20+it*50)+0 && iVGA_X<(20+it*50)+30)&&((iVGA_Y>=336 && iVGA_Y<360)||(iVGA_Y>=264 && iVGA_Y<288)) ||
			((iVGA_X>=(20+it*50)+0 && iVGA_X<(20+it*50)+10)||(iVGA_X>=(20+it*50)+20 && iVGA_X<(20+it*50)+30))&&(iVGA_Y>=264 && iVGA_Y<360)
			)
			oRed <= 15;
		end
	oGreen <= 0;
	oBlue <= 0;
	
//		if(iColor_SW == 1)
//		begin
//			if (iVGA_Y<120)
//			begin
//				oRed	<=	(iVGA_X<40)						?			0	:
//							(iVGA_X>=40 && iVGA_X<80)		?			1	:
//							(iVGA_X>=80 && iVGA_X<120)		?			2	:
//							(iVGA_X>=120 && iVGA_X<160)		?			3	:
//							(iVGA_X>=160 && iVGA_X<200)		?			4	:
//							(iVGA_X>=200 && iVGA_X<240)		?			5	:
//							(iVGA_X>=240 && iVGA_X<280)		?			6	:
//							(iVGA_X>=280 && iVGA_X<320)		?			7	:
//							(iVGA_X>=320 && iVGA_X<360)		?			8	:
//							(iVGA_X>=360 && iVGA_X<400)		?			9	:
//							(iVGA_X>=400 && iVGA_X<440)		?			10	:
//							(iVGA_X>=440 && iVGA_X<480 )	?			11	:
//							(iVGA_X>=480 && iVGA_X<520 )	?			12	:
//							(iVGA_X>=520 && iVGA_X<560 )	?			13	:
//							(iVGA_X>=560 && iVGA_X<600 )	?			14	:
//																		15	;
//				oGreen	<=	0;	
//				oBlue	<=	0;
//			end
//			else if (iVGA_Y>=120 && iVGA_Y<240)
//			begin
//				oRed	<=	0;
//				oGreen	<=	(iVGA_X<40)						?			15	:
//							(iVGA_X>=40 && iVGA_X<80)		?			14	:
//							(iVGA_X>=80 && iVGA_X<120)		?			13	:
//							(iVGA_X>=120 && iVGA_X<160)		?			12	:
//							(iVGA_X>=160 && iVGA_X<200)		?			11	:
//							(iVGA_X>=200 && iVGA_X<240)		?			10	:
//							(iVGA_X>=240 && iVGA_X<280)		?			9	:
//							(iVGA_X>=280 && iVGA_X<320)		?			8	:
//							(iVGA_X>=320 && iVGA_X<360)		?			7	:
//							(iVGA_X>=360 && iVGA_X<400)		?			6	:
//							(iVGA_X>=400 && iVGA_X<440)		?			5	:
//							(iVGA_X>=440 && iVGA_X<480 )	?			4	:
//							(iVGA_X>=480 && iVGA_X<520 )	?			3	:
//							(iVGA_X>=520 && iVGA_X<560 )	?			2	:
//							(iVGA_X>=560 && iVGA_X<600 )	?			1	:
//																		0	;
//				oBlue	<=	0;
//			end
//			else if (iVGA_Y>=240 && iVGA_Y<360)
//			begin
//				oRed	<=	0;
//				oGreen	<=	0;
//				oBlue	<=	(iVGA_X<40)						?			0	:
//							(iVGA_X>=40 && iVGA_X<80)		?			1	:
//							(iVGA_X>=80 && iVGA_X<120)		?			2	:
//							(iVGA_X>=120 && iVGA_X<160)		?			3	:
//							(iVGA_X>=160 && iVGA_X<200)		?			4	:
//							(iVGA_X>=200 && iVGA_X<240)		?			5	:
//							(iVGA_X>=240 && iVGA_X<280)		?			6	:
//							(iVGA_X>=280 && iVGA_X<320)		?			7	:
//							(iVGA_X>=320 && iVGA_X<360)		?			8	:
//							(iVGA_X>=360 && iVGA_X<400)		?			9	:
//							(iVGA_X>=400 && iVGA_X<440)		?			10	:
//							(iVGA_X>=440 && iVGA_X<480 )	?			11	:
//							(iVGA_X>=480 && iVGA_X<520 )	?			12	:
//							(iVGA_X>=520 && iVGA_X<560 )	?			13	:
//							(iVGA_X>=560 && iVGA_X<600 )	?			14	:
//																		15	;
//			end
//			else
//			begin
//				oRed	<=	(iVGA_X<40)						?			15	:
//							(iVGA_X>=40 && iVGA_X<80)		?			14	:
//							(iVGA_X>=80 && iVGA_X<120)		?			13	:
//							(iVGA_X>=120 && iVGA_X<160)		?			12	:
//							(iVGA_X>=160 && iVGA_X<200)		?			11	:
//							(iVGA_X>=200 && iVGA_X<240)		?			10	:
//							(iVGA_X>=240 && iVGA_X<280)		?			9	:
//							(iVGA_X>=280 && iVGA_X<320)		?			8	:
//							(iVGA_X>=320 && iVGA_X<360)		?			7	:
//							(iVGA_X>=360 && iVGA_X<400)		?			6	:
//							(iVGA_X>=400 && iVGA_X<440)		?			5	:
//							(iVGA_X>=440 && iVGA_X<480 )	?			4	:
//							(iVGA_X>=480 && iVGA_X<520 )	?			3	:
//							(iVGA_X>=520 && iVGA_X<560 )	?			2	:
//							(iVGA_X>=560 && iVGA_X<600 )	?			1	:
//																		0	;
//							
//				oGreen	<=	(iVGA_X<40)						?			15	:
//							(iVGA_X>=40 && iVGA_X<80)		?			14	:
//							(iVGA_X>=80 && iVGA_X<120)		?			13	:
//							(iVGA_X>=120 && iVGA_X<160)		?			12	:
//							(iVGA_X>=160 && iVGA_X<200)		?			11	:
//							(iVGA_X>=200 && iVGA_X<240)		?			10	:
//							(iVGA_X>=240 && iVGA_X<280)		?			9	:
//							(iVGA_X>=280 && iVGA_X<320)		?			8	:
//							(iVGA_X>=320 && iVGA_X<360)		?			7	:
//							(iVGA_X>=360 && iVGA_X<400)		?			6	:
//							(iVGA_X>=400 && iVGA_X<440)		?			5	:
//							(iVGA_X>=440 && iVGA_X<480 )	?			4	:
//							(iVGA_X>=480 && iVGA_X<520 )	?			3	:
//							(iVGA_X>=520 && iVGA_X<560 )	?			2	:
//							(iVGA_X>=560 && iVGA_X<600 )	?			1	:
//																		0	;
//		
//				oBlue	<=	(iVGA_X<40)						?			15	:
//							(iVGA_X>=40 && iVGA_X<80)		?			14	:
//							(iVGA_X>=80 && iVGA_X<120)		?			13	:
//							(iVGA_X>=120 && iVGA_X<160)		?			12	:
//							(iVGA_X>=160 && iVGA_X<200)		?			11	:
//							(iVGA_X>=200 && iVGA_X<240)		?			10	:
//							(iVGA_X>=240 && iVGA_X<280)		?			9	:
//							(iVGA_X>=280 && iVGA_X<320)		?			8	:
//							(iVGA_X>=320 && iVGA_X<360)		?			7	:
//							(iVGA_X>=360 && iVGA_X<400)		?			6	:
//							(iVGA_X>=400 && iVGA_X<440)		?			5	:
//							(iVGA_X>=440 && iVGA_X<480 )	?			4	:
//							(iVGA_X>=480 && iVGA_X<520 )	?			3	:
//							(iVGA_X>=520 && iVGA_X<560 )	?			2	:
//							(iVGA_X>=560 && iVGA_X<600 )	?			1	:
//																		0	;
//		
//			end
//		end
//		else
//		begin
//			oRed	<=	(iVGA_Y<120)					?			3	:
//						(iVGA_Y>=120 && iVGA_Y<240)		?			7	:
//						(iVGA_Y>=240 && iVGA_Y<360)		?			11	:
//																	15	;
//			oGreen	<=	(iVGA_X<80)						?			1	:
//						(iVGA_X>=80 && iVGA_X<160)		?			3	:
//						(iVGA_X>=160 && iVGA_X<240)		?			5	:
//						(iVGA_X>=240 && iVGA_X<320)		?			7	:
//						(iVGA_X>=320 && iVGA_X<400)		?			9	:
//						(iVGA_X>=400 && iVGA_X<480)		?			11	:
//						(iVGA_X>=480 && iVGA_X<560)		?			13	:
//																	15	;
//			oBlue	<=	(iVGA_Y<60)						?			15	:
//						(iVGA_Y>=60 && iVGA_Y<120)		?			13	:
//						(iVGA_Y>=120 && iVGA_Y<180)		?			11	:
//						(iVGA_Y>=180 && iVGA_Y<240)		?			9	:
//						(iVGA_Y>=240 && iVGA_Y<300)		?			7	:
//						(iVGA_Y>=300 && iVGA_Y<360)		?			5	:
//						(iVGA_Y>=360 && iVGA_Y<420)		?			3	:
//																	1	;
//		end
	end
end

endmodule