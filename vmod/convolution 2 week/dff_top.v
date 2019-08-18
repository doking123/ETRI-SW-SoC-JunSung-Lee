module dff_top #(parameter N=16, D=27)

		 (input iCLK,
		  input iRSTn,
		  input [N-1:0] idata,
		  output[N-1:0] odata
		 );
wire [N-1:0] data_arr[0:D];

assign data_arr[0]= idata;
genvar i;
generate for(i=0;i<D;i=i+1)begin:gen_dff

	dff #(N) uut(
				  .iCLK(iCLK),
				  .iRSTn(iRSTn),
				  .idata(data_arr[i]),
				  .odata(data_arr[i+1])
			);
	end
	endgenerate

	assign odata=data_arr[D];

endmodule

