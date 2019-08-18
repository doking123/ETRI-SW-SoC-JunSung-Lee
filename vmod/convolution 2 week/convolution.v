module convolution
		#(parameter BW1=16, BW2=19)
		 (input iCLK,iRSTn,iWren,iValid,
		  input signed [7:0] iW, iX, 
		  input		   [4:0] iADDR,
		  output			 oValid,
		  output signed[BW1-1:0] oY
		 );
//weight//
wire signed [7:0] oW1,oW2,oW3,oW4,oW5,oW6,oW7,oW8,oW9,oW10,oW11,oW12,oW13,oW14,oW15,oW16,oW17,oW18,oW19,oW20,oW21,oW22,oW23,oW24,oW25;

weight ut(.iCLK(iCLK), .iRSTn(iRSTn), .iWren(iWren), .iADDR(iADDR), .iW(iW), .oW1(oW1), .oW2(oW2), .oW3(oW3), .oW4(oW4), .oW5(oW5), .oW6(oW6), .oW7(oW7), .oW8(oW8), .oW9(oW9), .oW10(oW10), .oW11(oW11), .oW12(oW12), .oW13(oW13), .oW14(oW14), .oW15(oW15), .oW16(oW16), .oW17(oW17), .oW18(oW18), .oW19(oW19), .oW20(oW20), .oW21(oW21), .oW22(oW22), .oW23(oW23), .oW24(oW24), .oW25(oW25));
		 
//``````````````````````````````````````````````````````````````````````````````````````//
wire signed [16:0] a1;
wire signed [16:0] a2;
wire signed [17:0] a3;
wire signed [17:0] a4;
wire signed [18:0] a5;
pe #(16,17) uut(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW1), .iX(iX), .iPsum(16'd0), .oPsum(a1));
pe #(17,17) uut1(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW2), .iX(iX), .iPsum(a1), .oPsum(a2));
pe #(17,18) uut2(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW3), .iX(iX), .iPsum(a2), .oPsum(a3));
pe #(18,18) uut3(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW4), .iX(iX), .iPsum(a3), .oPsum(a4));
pe #(18,19) uut4(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW5), .iX(iX), .iPsum(a4), .oPsum(a5));

// sat
wire signed [15:0] satout;
satu u1 (.i19bit(a5), .o16bit(satout));

// 27delay1
wire signed [15:0] stage1;
dff_top u11(.iCLK(iCLK), .iRSTn(iRSTn), .idata(satout), .odata(stage1));
//`````````````````````````````````````````````````````````````````````````````````````//

//``````````````````````````````````````````````````````````````````````````````````````//
wire signed [16:0] a6;
wire signed [16:0] a7;
wire signed [17:0] a8;
wire signed [17:0] a9;
wire signed [18:0] a10;
pe #(16,17) uut5(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW6), .iX(iX), .iPsum(stage1), .oPsum(a6));
pe #(17,17) uut6(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW7), .iX(iX), .iPsum(a6), .oPsum(a7));
pe #(17,18) uut7(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW8), .iX(iX), .iPsum(a7), .oPsum(a8));
pe #(18,18) uut8(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW9), .iX(iX), .iPsum(a8), .oPsum(a9));
pe #(18,19) uut9(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW10), .iX(iX), .iPsum(a9), .oPsum(a10));

// sat
wire signed [15:0] satout1;
satu u2 (.i19bit(a10), .o16bit(satout1));

// 27delay2
wire signed [15:0] stage2;
dff_top u22(.iCLK(iCLK), .iRSTn(iRSTn), .idata(satout1), .odata(stage2));
//`````````````````````````````````````````````````````````````````````````````````````//

//``````````````````````````````````````````````````````````````````````````````````````//
wire signed [16:0] a11;
wire signed [16:0] a12;
wire signed [17:0] a13;
wire signed [17:0] a14;
wire signed [18:0] a15;
pe #(16,17) uut10(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW11), .iX(iX), .iPsum(stage2), .oPsum(a11));
pe #(17,17) uut11(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW12), .iX(iX), .iPsum(a11), .oPsum(a12));
pe #(17,18) uut12(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW13), .iX(iX), .iPsum(a12), .oPsum(a13));
pe #(18,18) uut13(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW14), .iX(iX), .iPsum(a13), .oPsum(a14));
pe #(18,19) uut14(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW15), .iX(iX), .iPsum(a14), .oPsum(a15));

// sat
wire signed [15:0] satout2;
satu u3 (.i19bit(a15), .o16bit(satout2));

// 27delay3
wire signed [15:0] stage3;
dff_top u23(.iCLK(iCLK), .iRSTn(iRSTn), .idata(satout2), .odata(stage3));
//`````````````````````````````````````````````````````````````````````````````````````//

//``````````````````````````````````````````````````````````````````````````````````````//
wire signed [16:0] a16;
wire signed [16:0] a17;
wire signed [17:0] a18;
wire signed [17:0] a19;
wire signed [18:0] a20;
pe #(16,17) uut15(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW16), .iX(iX), .iPsum(stage3), .oPsum(a16));
pe #(17,17) uut16(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW17), .iX(iX), .iPsum(a16), .oPsum(a17));
pe #(17,18) uut17(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW18), .iX(iX), .iPsum(a17), .oPsum(a18));
pe #(18,18) uut18(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW19), .iX(iX), .iPsum(a18), .oPsum(a19));
pe #(18,19) uut19(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW20), .iX(iX), .iPsum(a19), .oPsum(a20));

// sat
wire signed [15:0] satout3;
satu u4 (.i19bit(a20), .o16bit(satout3));

// 27delay1
wire signed [15:0] stage4;
dff_top u34(.iCLK(iCLK), .iRSTn(iRSTn), .idata(satout3), .odata(stage4));
//`````````````````````````````````````````````````````````````````````````````````````//

//``````````````````````````````````````````````````````````````````````````````````````//
wire signed [16:0] a21;
wire signed [16:0] a22;
wire signed [17:0] a23;
wire signed [17:0] a24;
wire signed [18:0] a25;
pe #(16,17) uut20(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW21), .iX(iX), .iPsum(stage4), .oPsum(a21));
pe #(17,17) uut21(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW22), .iX(iX), .iPsum(a21), .oPsum(a22));
pe #(17,18) uut22(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW23), .iX(iX), .iPsum(a22), .oPsum(a23));
pe #(18,18) uut23(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW24), .iX(iX), .iPsum(a23), .oPsum(a24));
pe #(18,19) uut24(.iCLK(iCLK), .iRSTn(iRSTn), .iW(oW25), .iX(iX), .iPsum(a24), .oPsum(a25));

// sat
wire signed [15:0] satout4;
satu u5 (.i19bit(a25), .o16bit(satout4));

assign oY = satout4;

//`````````````````````````````````````````````````````````````````````````````````````/
control u (.iCLK(iCLK), .iRSTn(iRSTn), .iValid(iValid), .oValid(oValid));
endmodule
		
