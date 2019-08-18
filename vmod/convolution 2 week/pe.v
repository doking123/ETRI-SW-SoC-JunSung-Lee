module pe
#(parameter BW1=16, BW2_1=16)
		 (input iCLK,
		  input iRSTn,
		  input signed [7:0] iW,
		  input signed [7:0] iX,
		  input signed [BW1-1:0] iPsum,
		  output reg signed[BW2_1-1:0] oPsum
		 );



always @(posedge iCLK, negedge iRSTn)
begin
	if(!iRSTn)
		oPsum <= 0;

	else
		oPsum <= (iX*iW)+iPsum;
end
endmodule
		
