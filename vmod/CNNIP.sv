/*
 *  cnnip_ctrlr.sv -- CNN IP controller
 *  ETRI <SW-SoC AI Deep Learning HW Accelerator RTL Design> course material
 *
 *  second draft by Jun Sung Lee
 */

module cnnip_ctrlr
(
  // clock and reset signals from domain a
  input wire clk_a,
  input wire arstz_aq,

  // internal memories
  cnnip_mem_if.master to_input_mem,
  cnnip_mem_if.master to_weight_mem,
  cnnip_mem_if.master to_feature_mem,

  // configuration registers
  input wire         CMD_START,
  input wire   [7:0] MODE_KERNEL_SIZE,
  input wire   [7:0] MODE_KERNEL_NUMS,
  input wire   [1:0] MODE_STRIDE,
  input wire         MODE_PADDING,
  // my own signal for conclusion of inputX and W
  input wire        W_write,
  input wire        X_write,
  input wire        X_read,
  input wire        W_read,
  input wire        CONV_end,

  output wire        CMD_DONE,
  output wire        CMD_DONE_VALID

);

  // sample FSM
  enum { IDLE, START, INX, INW, CONV, DONE } state_aq, state_next;

  // internal registers
  reg [7:0] cnt_inx;
  reg [4:0] cnt_inw;
  reg [16:0] cnt_aq; // for done state

// input x register
  always @(posedge clk_a, negedge arstz_aq)
    if (!arstz_aq) cnt_inx <= 8'b0;
    else if (state_aq == INX) cnt_inx <= cnt_inx + 8'b1;
    else cnt_inx <= 8'b0;
    
// input w register
  always @(posedge clk_a, negedge arstz_aq)
    if (!arstz_aq) cnt_inw <= 5'b0;
    else if (state_aq == INW) cnt_inw <= cnt_inw + 5'b1;
    else cnt_inw <= 5'b0;
   
  // use wires as shortcuts
  wire inx_done = (cnt_inx == 8'd255);
  wire inw_done = (cnt_inw == 5'd25);
  
  // state transition
  always @(posedge clk_a, negedge arstz_aq)
    if (!arstz_aq) state_aq <= IDLE;
    else state_aq <= state_next;

  // state transition condition
 always @(*)
  begin
    state_next = state_aq;
    case (state_aq)
      IDLE:
        if (CMD_START) state_next = START;

      START:
        if(X_read) state_next = INX;
       
      START:
        if(W_read) state_next = INW;
       
       INX & INW:
        if (W_write && X_write==1) state_next = CONV;

      CONV:
        if(CONV_end) state_next = DONE;
      
      DONE:
        state_next = IDLE;
    endcase
  end 

  // output signals
  assign CMD_DONE = (state_aq == DONE);
  assign CMD_DONE_VALID = (state_aq == DONE);


endmodule // cnnip_ctrlr