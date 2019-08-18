module dff #(parameter N=16)

		 (input iCLK,
		  input iRSTn,
		  input [N-1:0] idata,
		  output reg [N-1:0] odata
		 );



always @(posedge iCLK, negedge iRSTn)
begin
	if(!iRSTn)
		odata <= 0;

	else
		odata<= idata;
end
endmodule
		
