module control
#(parameter XS=32, WS=5, STRIDE=1)
( input iValid,
  input iCLK,
  input iRSTn,
  output  oValid
				);
reg [5:0] col_next;
reg [5:0] row_next;
reg [4:0] i;
reg [4:0] j;
reg Valid;
//reg out;

 always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			Valid<=1'd0;
		end
		else begin
			Valid<=iValid;
		end
	end
 
 always@(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			j<=4'd0;
		end
		else if(j==XS-1)begin
			j<=4'd0;
		end
		else if(Valid==1'd1)
			j<=j+4'd1;
		end

 always@(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			i<=4'd0;
		end
		else if(j==XS-1&&i==XS-1)
			i<=4'd0;
		else if(j==5'd31)
			i<=i+4'd1;
		end

 always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			col_next <=WS-1;
		end
		else if(i==row_next&&j==col_next&&j==XS-1)begin
					col_next<=WS-1;
		end
		else if(i==row_next&&j==col_next)begin
					col_next<=col_next+STRIDE;
		end
	end

 always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)begin
			row_next <=WS-1;
		end
		else if (i==row_next && j==col_next&&j==XS-1)
				if(i==XS-1)
					row_next<=WS-1;
		else 
			row_next<=row_next+STRIDE;
		end
	
 assign oValid = (i==row_next&&j==col_next&&Valid)?1:0;
 /*
 always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)
		oValid <= 1'd0;
		else if(i==row_next&&j==col_next&&Valid)
		oValid <= 1'd1;
		else
		oValid <= 1'd0;
	end
*/ 
/*
 always @(posedge iCLK, negedge iRSTn)
	begin
		if(!iRSTn)
		oValid <= 1'd0;
		else 
		oValid <= out;
	end
*/

 endmodule
