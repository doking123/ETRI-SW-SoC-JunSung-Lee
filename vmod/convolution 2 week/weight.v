module weight(
		input iCLK,
		input iRSTn,
		input iWren,
		input [4:0] iADDR,
		input [7:0] iW,
		output reg [7:0] oW1, oW2, oW3, oW4, oW5, oW6, oW7, oW8, oW9, oW10, oW11, oW12, oW13, oW14, oW15, oW16, oW17, oW18, oW19, oW20, oW21, oW22, oW23, oW24, oW25
		);

		
	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW1 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd0))begin
			oW1 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW2 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd1))begin
			oW2 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW3 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd2))begin
			oW3 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW4 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd3))begin
			oW4 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW5 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd4))begin
			oW5 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW6 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd5))begin
			oW6 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW7 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd6))begin
			oW7 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW8 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd7))begin
			oW8 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW9 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd8))begin
			oW9 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW10 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd9))begin
			oW10 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW11 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd10))begin
			oW11 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW12 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd11))begin
			oW12 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW13 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd12))begin
			oW13 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW14 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd13))begin
			oW14 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW15 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd14))begin
			oW15 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW16 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd15))begin
			oW16 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW17 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd16))begin
			oW17 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW18 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd17))begin
			oW18 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW19 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd18))begin
			oW19 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW20 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd19))begin
			oW20 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW21 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd20))begin
			oW21 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW22 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd21))begin
			oW22 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW23 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd22))begin
			oW23 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW24 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd23))begin
			oW24 <= iW;
		end
	end

	always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			oW25 <= 8'd0;
		end
		else if((iWren==1)&&(iADDR==5'd24))begin
			oW25 <= iW;
		end
	end

endmodule
