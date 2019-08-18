module satu(input signed [18:0] i19bit,
			output signed [15:0] o16bit);
	/*always @(*) begin
		if(i19bit>=32767)begin
			o16bit = 32767;
		end
		else if(i19bit<=-32768)begin
			o16bit = -32768;
		end
		else begin
			o16bit = i19bit;
		end
	end*/


	assign o16bit = (i19bit>=32767)?32767:i19bit;
	assign o16bit = (i19bit<=-32768)?-32768:i19bit;
endmodule
	
