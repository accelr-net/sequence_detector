
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
// DESCRIPTION  :   Simple sequence detector example
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

module testbench;

//---------------------------------------------------------------------------------------------------------------------
// Global constant headers
//---------------------------------------------------------------------------------------------------------------------
    

//---------------------------------------------------------------------------------------------------------------------
// parameter definitions
//---------------------------------------------------------------------------------------------------------------------
   

//---------------------------------------------------------------------------------------------------------------------
// localparam definitions
//---------------------------------------------------------------------------------------------------------------------    


//---------------------------------------------------------------------------------------------------------------------
// type definitions
//---------------------------------------------------------------------------------------------------------------------
  

//---------------------------------------------------------------------------------------------------------------------
// I/O signals
//---------------------------------------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------------------------------------
// Internal signals
//---------------------------------------------------------------------------------------------------------------------
  reg     clock;
  reg     reset;
  reg     dut_data_in;
  wire    dut_data_out;

//---------------------------------------------------------------------------------------------------------------------
// Implementation
//---------------------------------------------------------------------------------------------------------------------

  // initial begin
  //   $dumpfile("dump.vcd");
  //   $dumpvars;
  //   #10000 $finish;
  // end
  
  //initial begin : VCD_DUMP
  //  $dumpfile("test.vcd");
  //  $dumpvars(0,testbench);
  //end

  seq_detector dut
  (
    .clk      (clock),
    .reset    (reset),
    .data_in  (dut_data_in),
    .date_out (dut_data_out)
  );

  task generate_simple_sequence;
  begin
    $display("Starting simple input sequence");
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b1; // date_out = 1
    @(posedge clock) dut_data_in <= 1'b0; 
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1; 
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b1; // date_out = 1

    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b1; // date_out = 1
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b0;

    @(posedge clock) dut_data_in <= 1'b0;
    $display("Simple input sequence done");
  end
  endtask

  task generate_complex_sequence;
  begin
    $display("Starting complex input sequence");
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b1; // date_out = 1
    @(posedge clock) dut_data_in <= 1'b0; 
    @(posedge clock) dut_data_in <= 1'b1; 
    @(posedge clock) dut_data_in <= 1'b1; // date_out = 1 (not detected by dut)
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b1; // date_out = 1 (not detected by dut)

    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b1; // date_out = 1 (not detected by dut)
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;
    @(posedge clock) dut_data_in <= 1'b0;
    @(posedge clock) dut_data_in <= 1'b1;

    @(posedge clock) dut_data_in <= 1'b0;
    $display("Complex input sequence done");
  end
  endtask


  always begin : CLK_BLOCK
    #10 clock = ~clock;
  end

  initial begin
    $display("Simulation start");
    clock = 1'b0;
    reset = 1'b1;
    dut_data_in = 1'b0;

    repeat(5) @(posedge clock);
    reset <= 1'b0;

    repeat(10) @(posedge clock);

    
    generate_simple_sequence();
    

    repeat(10) @(posedge clock);

    generate_complex_sequence();
    
    repeat(100) @(posedge clock);

    $display("Simulation end");
    $finish;
  end

endmodule