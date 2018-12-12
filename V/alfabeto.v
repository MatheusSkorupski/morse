module	VGA_Pattern	(	//	Read Out Side
						oRed,
						oGreen,
						oBlue,
						iVGA_X,
						iVGA_Y,
						iVGA_CLK,
						//	Control Signals
						iRST_n,
						iColor_SW	);
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

	oRed <= 	//1
				(iVGA_X>=40 && iVGA_X<50)&&(iVGA_Y<120) 
				|| //2
				(iVGA_X>=70 && iVGA_X<100)&&(iVGA_Y<24) ||
				(iVGA_X>=90 && iVGA_X<100)&&(iVGA_Y>=24 && iVGA_Y<48) ||
				(iVGA_X>=70 && iVGA_X<100)&&(iVGA_Y>=48 && iVGA_Y<72) ||
				(iVGA_X>=70 && iVGA_X<80)&&(iVGA_Y>=72 && iVGA_Y<96) ||
				(iVGA_X>=70 && iVGA_X<100)&&(iVGA_Y>=96 && iVGA_Y<120)
				||//7
				(iVGA_X>=320 && iVGA_X<350)&&(iVGA_Y<24) ||
				(iVGA_X>=340 && iVGA_X<350)&&(iVGA_Y>=24 && iVGA_Y<120)
				||//8
				(iVGA_X>=370 && iVGA_X<400)&&(iVGA_Y<24) ||
				((iVGA_X>=370 && iVGA_X<380)||(iVGA_X>=390 && iVGA_X<400))&&(iVGA_Y>=24 && iVGA_Y<48) ||
				(iVGA_X>=370 && iVGA_X<400)&&(iVGA_Y>=48 && iVGA_Y<72) ||
				((iVGA_X>=370 && iVGA_X<380)||(iVGA_X>=390 && iVGA_X<400))&&(iVGA_Y>=72 && iVGA_Y<96) ||
				(iVGA_X>=370 && iVGA_X<400)&&(iVGA_Y>=96 && iVGA_Y<120)
				||//C
				(iVGA_X>=20 && iVGA_X<50)&&((iVGA_Y>=120 && iVGA_Y<132)||(iVGA_Y>=216 && iVGA_Y<240)) ||
				(iVGA_X>=20 && iVGA_X<30)&&(iVGA_Y>=120 && iVGA_Y<240)
				||//d
				(iVGA_X>=90 && iVGA_X<100)&&(iVGA_Y>=120 && iVGA_Y<144) ||
				(iVGA_X>=90 && iVGA_X<100)&&(iVGA_Y>=144 && iVGA_Y<168) ||
				(iVGA_X>=70 && iVGA_X<100)&&(iVGA_Y>=168 && iVGA_Y<192) ||
				((iVGA_X>=70 && iVGA_X<80)||(iVGA_X>=90 && iVGA_X<100))&&(iVGA_Y>=192 && iVGA_Y<216) ||
				(iVGA_X>=70 && iVGA_X<100)&&(iVGA_Y>=216 && iVGA_Y<240)
				||//E
				(iVGA_X>=120 && iVGA_X<150)&&(iVGA_Y>=120 && iVGA_Y<144) || 
				(iVGA_X>=120 && iVGA_X<130)&&(iVGA_Y>=144 && iVGA_Y<168) ||
				(iVGA_X>=120 && iVGA_X<150)&&(iVGA_Y>=168 && iVGA_Y<192) ||
				(iVGA_X>=120 && iVGA_X<130)&&(iVGA_Y>=192 && iVGA_Y<216) ||
				(iVGA_X>=120 && iVGA_X<150)&&(iVGA_Y>=216 && iVGA_Y<240) 
				||//F
				(iVGA_X>=170 && iVGA_X<200)&&(iVGA_Y>=120 && iVGA_Y<144) || 
				(iVGA_X>=170 && iVGA_X<180)&&(iVGA_Y>=144 && iVGA_Y<168) ||
				(iVGA_X>=170 && iVGA_X<200)&&(iVGA_Y>=168 && iVGA_Y<192) ||
				(iVGA_X>=170 && iVGA_X<180)&&(iVGA_Y>=192 && iVGA_Y<216) ||
				(iVGA_X>=170 && iVGA_X<180)&&(iVGA_Y>=216 && iVGA_Y<240) 
				||//G
				(iVGA_X>=230 && iVGA_X<250)&&(iVGA_Y>=120 && iVGA_Y<144) || 
				(iVGA_X>=220 && iVGA_X<230)&&(iVGA_Y>=144 && iVGA_Y<168) ||
				((iVGA_X>=220 && iVGA_X<230)||(iVGA_X>=235 && iVGA_X<250))&&(iVGA_Y>=168 && iVGA_Y<192) ||
				((iVGA_X>=220 && iVGA_X<230)||(iVGA_X>=240 && iVGA_X<250))&&(iVGA_Y>=192 && iVGA_Y<216) ||
				(iVGA_X>=220 && iVGA_X<250)&&(iVGA_Y>=216 && iVGA_Y<240) 
				||//H
				((iVGA_X>=270 && iVGA_X<280)||(iVGA_X>=290 && iVGA_X<300))&&(iVGA_Y>=120 && iVGA_Y<240) || 
				(iVGA_X>=270 && iVGA_X<300)&&(iVGA_Y>=168 && iVGA_Y<192) 
				||//I
				(iVGA_X>=320 && iVGA_X<350)&&((iVGA_Y>=120 && iVGA_Y<144)||(iVGA_Y>=216 && iVGA_Y<240)) ||
				(iVGA_X>=330 && iVGA_X<340)&&(iVGA_Y>=120 && iVGA_Y<240) 
				||//J
				(iVGA_X>=390 && iVGA_X<400)&&(iVGA_Y>=120 && iVGA_Y<240) || 
				(iVGA_X>=370 && iVGA_X<380)&&(iVGA_Y>=168 && iVGA_Y<240) ||
				(iVGA_X>=370 && iVGA_X<400)&&(iVGA_Y>=216 && iVGA_Y<240)
				||//K
				((iVGA_X>=420 && iVGA_X<430)||(iVGA_X>=440 && iVGA_X<450))&&((iVGA_Y>=120 && iVGA_Y<168)||(iVGA_Y>=192 && iVGA_Y<240)) || 
				(iVGA_X>=420 && iVGA_X<440)&&(iVGA_Y>=168 && iVGA_Y<192) 
				||//L
				(iVGA_X>=470 && iVGA_X<480)&&(iVGA_Y>=120 && iVGA_Y<240) || 
				(iVGA_X>=470 && iVGA_X<500)&&(iVGA_Y>=216 && iVGA_Y<240)
				||//M
				((iVGA_X>=520 && iVGA_X<530)||(iVGA_X>=540 && iVGA_X<550))&&(iVGA_Y>=120 && iVGA_Y<240) || 
				((iVGA_X>=520 && iVGA_X<533)||(iVGA_X>=537 && iVGA_X<550))&&(iVGA_Y>=144 && iVGA_Y<168) ||
				(iVGA_X>=530 && iVGA_X<540)&&(iVGA_Y>=168 && iVGA_Y<192)
				||//N
				((iVGA_X>=570 && iVGA_X<580)||(iVGA_X>=590 && iVGA_X<600))&&(iVGA_Y>=120 && iVGA_Y<240) || 
				(iVGA_X>=580 && iVGA_X<583)&&(iVGA_Y>=144 && iVGA_Y<168) ||
				(iVGA_X>=583 && iVGA_X<587)&&(iVGA_Y>=168 && iVGA_Y<192) ||
				(iVGA_X>=587 && iVGA_X<590)&&(iVGA_Y>=120 && iVGA_Y<216)
				? 15 : 0;
	oGreen <= //3
				(iVGA_X>=120 && iVGA_X<150)&&(iVGA_Y<24) || 
				(iVGA_X>=140 && iVGA_X<150)&&(iVGA_Y>=24 && iVGA_Y<48) ||
				(iVGA_X>=120 && iVGA_X<150)&&(iVGA_Y>=48 && iVGA_Y<72) ||
				(iVGA_X>=140 && iVGA_X<150)&&(iVGA_Y>=72 && iVGA_Y<96) ||
				(iVGA_X>=120 && iVGA_X<150)&&(iVGA_Y>=96 && iVGA_Y<120) 
				||//4
				((iVGA_X>=170 && iVGA_X<180)||(iVGA_X>=190 && iVGA_X<200))&&(iVGA_Y<48) ||
				(iVGA_X>=170 && iVGA_X<200)&&(iVGA_Y>=48 && iVGA_Y<72) ||
				(iVGA_X>=190 && iVGA_X<200)&&(iVGA_Y>=72 && iVGA_Y<120)
				||//9
				(iVGA_X>=420 && iVGA_X<450)&&(iVGA_Y<24) ||
				((iVGA_X>=420 && iVGA_X<430)||(iVGA_X>=440 && iVGA_X<450))&&(iVGA_Y>=24 && iVGA_Y<48) ||
				(iVGA_X>=420 && iVGA_X<450)&&(iVGA_Y>=48 && iVGA_Y<72) ||
				(iVGA_X>=440 && iVGA_X<450)&&(iVGA_Y>=72 && iVGA_Y<96) ||
				(iVGA_X>=440 && iVGA_X<450)&&(iVGA_Y>=96 && iVGA_Y<120) 
				||//0
				(iVGA_X>=470 && iVGA_X<500)&&((iVGA_Y<24)||(iVGA_Y>=96 && iVGA_Y<120)) ||
				((iVGA_X>=470 && iVGA_X<480)||(iVGA_X>=490 && iVGA_X<500))&&(iVGA_Y>=24 && iVGA_Y<96)
				||//o
				(iVGA_X>=20 && iVGA_X<50)&&((iVGA_Y>=336 && iVGA_Y<360)||(iVGA_Y>=264 && iVGA_Y<288)) ||
				((iVGA_X>=20 && iVGA_X<30)||(iVGA_X>=40 && iVGA_X<50))&&(iVGA_Y>=264 && iVGA_Y<360)
				||//P
				(iVGA_X>=70 && iVGA_X<80)&&(iVGA_Y>=240 && iVGA_Y<360) ||
				((iVGA_X>=70 && iVGA_X<80)||(iVGA_X>=90 && iVGA_X<100))&&(iVGA_Y>=264 && iVGA_Y<288) ||
				(iVGA_X>=70 && iVGA_X<100)&&((iVGA_Y>=240 && iVGA_Y<264)||(iVGA_Y>=288 && iVGA_Y<312))
				||//q
				(iVGA_X>=140 && iVGA_X<150)&&(iVGA_Y>=240 && iVGA_Y<360) ||
				((iVGA_X>=120 && iVGA_X<130)||(iVGA_X>=140 && iVGA_X<150))&&(iVGA_Y>=264 && iVGA_Y<288) ||
				(iVGA_X>=120 && iVGA_X<150)&&((iVGA_Y>=240 && iVGA_Y<264)||(iVGA_Y>=288 && iVGA_Y<312))
				||//r
				(iVGA_X>=170 && iVGA_X<180)&&(iVGA_Y>=264 && iVGA_Y<360) ||
				(iVGA_X>=180 && iVGA_X<190)&&(iVGA_Y>=288 && iVGA_Y<312) ||
				(iVGA_X>=190 && iVGA_X<200)&&(iVGA_Y>=264 && iVGA_Y<288)
				||//S
				(iVGA_X>=230 && iVGA_X<250)&&(iVGA_Y>=240 && iVGA_Y<264) ||
				(iVGA_X>=220 && iVGA_X<230)&&(iVGA_Y>=264 && iVGA_Y<288) ||
				(iVGA_X>=230 && iVGA_X<240)&&(iVGA_Y>=288 && iVGA_Y<312) ||
				(iVGA_X>=240 && iVGA_X<250)&&(iVGA_Y>=312 && iVGA_Y<336) ||
				(iVGA_X>=220 && iVGA_X<240)&&(iVGA_Y>=336 && iVGA_Y<360)
				||//T
				(iVGA_X>=270 && iVGA_X<300)&&(iVGA_Y>=240 && iVGA_Y<264) ||
				(iVGA_X>=280 && iVGA_X<290)&&(iVGA_Y>=240 && iVGA_Y<360)
				||//U
				((iVGA_X>=320 && iVGA_X<330)||(iVGA_X>=340 && iVGA_X<350))&&(iVGA_Y>=240 && iVGA_Y<360) ||
				(iVGA_X>=320 && iVGA_X<350)&&(iVGA_Y>=336 && iVGA_Y<360)
				||//V
				((iVGA_X>=370 && iVGA_X<380)||(iVGA_X>=390 && iVGA_X<400))&&(iVGA_Y>=240 && iVGA_Y<312) ||
				((iVGA_X>=375 && iVGA_X<385)||(iVGA_X>=385 && iVGA_X<395))&&(iVGA_Y>=312 && iVGA_Y<336) ||
				(iVGA_X>=380 && iVGA_X<390)&&(iVGA_Y>=336 && iVGA_Y<360)
				||//W
				((iVGA_X>=420 && iVGA_X<430)||(iVGA_X>=440 && iVGA_X<450))&&(iVGA_Y>=240 && iVGA_Y<360) ||
				((iVGA_X>=430 && iVGA_X<433)||(iVGA_X>=437 && iVGA_X<440))&&(iVGA_Y>=312 && iVGA_Y<336) ||
				(iVGA_X>=433 && iVGA_X<437)&&(iVGA_Y>=288 && iVGA_Y<312)
				||//X
				((iVGA_X>=470 && iVGA_X<480)||(iVGA_X>=490 && iVGA_X<500))&&((iVGA_Y>=240 && iVGA_Y<264)||(iVGA_Y>=336 && iVGA_Y<360)) ||
				((iVGA_X>=473 && iVGA_X<483)||(iVGA_X>=487 && iVGA_X<497))&&((iVGA_Y>=264 && iVGA_Y<288)||(iVGA_Y>=312 && iVGA_Y<336)) ||
				(iVGA_X>=480 && iVGA_X<490)&&(iVGA_Y>=288 && iVGA_Y<312)
				||//Y
				((iVGA_X>=520 && iVGA_X<530)||(iVGA_X>=540 && iVGA_X<550))&&((iVGA_Y>=240 && iVGA_Y<264)) ||
				((iVGA_X>=523 && iVGA_X<533)||(iVGA_X>=537 && iVGA_X<547))&&((iVGA_Y>=264 && iVGA_Y<288)) ||
				(iVGA_X>=530 && iVGA_X<540)&&(iVGA_Y>=288 && iVGA_Y<360)
				||//Z
				(iVGA_X>=570 && iVGA_X<600)&&(iVGA_Y>=240 && iVGA_Y<264) ||
				(iVGA_X>=585 && iVGA_X<595)&&(iVGA_Y>=264 && iVGA_Y<288) ||
				(iVGA_X>=580 && iVGA_X<590)&&(iVGA_Y>=288 && iVGA_Y<312) ||
				(iVGA_X>=575 && iVGA_X<585)&&(iVGA_Y>=312 && iVGA_Y<336) ||
				(iVGA_X>=570 && iVGA_X<600)&&(iVGA_Y>=336 && iVGA_Y<360)
				? 15 : 0;
	oBlue <= //5
				(iVGA_X>=220 && iVGA_X<250)&&(iVGA_Y<24) ||
				(iVGA_X>=220 && iVGA_X<230)&&(iVGA_Y>=24 && iVGA_Y<48) ||
				(iVGA_X>=220 && iVGA_X<250)&&(iVGA_Y>=48 && iVGA_Y<72) ||
				(iVGA_X>=240 && iVGA_X<250)&&(iVGA_Y>=72 && iVGA_Y<96) ||
				(iVGA_X>=220 && iVGA_X<250)&&(iVGA_Y>=96 && iVGA_Y<120) 
				||//6
				(iVGA_X>=270 && iVGA_X<300)&&(iVGA_Y<24) ||
				(iVGA_X>=270 && iVGA_X<280)&&(iVGA_Y>=24 && iVGA_Y<48) ||
				(iVGA_X>=270 && iVGA_X<300)&&(iVGA_Y>=48 && iVGA_Y<72) ||
				((iVGA_X>=270 && iVGA_X<280)||(iVGA_X>=290 && iVGA_X<300))&&(iVGA_Y>=72 && iVGA_Y<96) ||
				(iVGA_X>=270 && iVGA_X<300)&&(iVGA_Y>=96 && iVGA_Y<120)
				||
				//A
				(iVGA_X>=520 && iVGA_X<550)&&((iVGA_Y<24)||(iVGA_Y>=48 && iVGA_Y<72)) ||
				((iVGA_X>=520 && iVGA_X<530)||(iVGA_X>=540 && iVGA_X<550))&&(iVGA_Y<120)
				||//b
				(iVGA_X>=570 && iVGA_X<580)&&(iVGA_Y<120) ||
				(iVGA_X>=570 && iVGA_X<600)&&((iVGA_Y>=48 && iVGA_Y<72)||(iVGA_Y>=96 && iVGA_Y<120)) ||
				((iVGA_X>=570 && iVGA_X<580)||(iVGA_X>=590 && iVGA_X<600))&&(iVGA_Y>=72 && iVGA_Y<96)
				? 7 :
					0;
	
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