
// ************************************************************************************************
//
// Copyright(C) 2022 ACCELR
// All rights reserved.
//
// THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF
// ACCELER LOGIC (PVT) LTD, SRI LANKA.
//
// This copy of the Source Code is intended for ACCELR's internal use only and is
// intended for view by persons duly authorized by the management of ACCELR. No
// part of this file may be reproduced or distributed in any form or by any
// means without the written approval of the Management of ACCELR.
//
// ACCELR, Sri Lanka            https://accelr.lk
// No 175/95, John Rodrigo Mw,  info@accelr.net
// Katubedda, Sri Lanka         +94 77 3166850
//
// ************************************************************************************************
//
// PROJECT      :   Simple Sequence Detector
// PRODUCT      :   N/A
// FILE         :   seq_detector.sv
// AUTHOR       :   Nuwan Gajaweera
// DESCRIPTION  :   Simple sequence detector testbench code
//
// ************************************************************************************************
//
// REVISIONS:
//
//  Date            Developer     Description
//  -----------     ---------     -----------
//  08-JUL-2022      nuwang       creation
//
//
//**************************************************************************************************

`timescale 1ns / 1ps

module seq_detector
(
  clk,
  reset,
  data_in,
  date_out
);

//---------------------------------------------------------------------------------------------------------------------
// Global constant headers
//---------------------------------------------------------------------------------------------------------------------
    

//---------------------------------------------------------------------------------------------------------------------
// parameter definitions
//---------------------------------------------------------------------------------------------------------------------
   

//---------------------------------------------------------------------------------------------------------------------
// localparam definitions
//---------------------------------------------------------------------------------------------------------------------    
  localparam              IDLE            = 0;
  localparam              S1              = 1;
  localparam              S10             = 2;
  localparam              S101            = 3;
  localparam              S1011           = 4;

//---------------------------------------------------------------------------------------------------------------------
// type definitions
//---------------------------------------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------------------------------------
// I/O signals
//---------------------------------------------------------------------------------------------------------------------
  input                                     clk;
  input                                     reset;        
  input                                     data_in;
  output reg                                date_out;

//---------------------------------------------------------------------------------------------------------------------
// Internal signals
//---------------------------------------------------------------------------------------------------------------------
  reg         [3:0]                         state;

//---------------------------------------------------------------------------------------------------------------------
// Implementation
//---------------------------------------------------------------------------------------------------------------------

  always @(posedge clk or posedge reset) begin : FSM_BLOCK
    if(reset) begin
      state         <= IDLE;
    end
    else begin
      case(state)
        IDLE: begin
          if (data_in)
            state   <= S1;
        end
        S1: begin
          if(~data_in)
            state   <= S10;
         // else
           // state   <= IDLE;
        end
        S10: begin
          if(data_in)
            state   <= S101;
          else
            state   <= IDLE;
        end
        S101: begin
          if(data_in)
            state <= S1011;
          else
            state <= S10;
        end
        S1011: begin
         if(data_in)
            state <= S1; 
          else
            state <= S10; 
          
          
         // state <= IDLE;
        end
      endcase
    end
  end

  always @(*) begin : ASYNC_BLOCK
    case(state)
      S1011: begin
        date_out = 1'b1;
      end
      default: begin
        date_out = 1'b0;
      end
    endcase
  end


endmodule