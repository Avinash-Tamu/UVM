/*-----------------------------------------------------------------
File name     : yapp_tx_seqs.sv
Developers    : Kathleen Meade, Brian Dickinson
Created       : 01/04/11
Description   : YAPP UVC simple TX test sequence for labs 2 to 4
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

//------------------------------------------------------------------------------
//
// SEQUENCE: base yapp sequence - base sequence with objections from which 
// all sequences can be derived
//
//------------------------------------------------------------------------------
class yapp_base_seq extends uvm_sequence #(yapp_packet);
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_base_seq)

  // Constructor
  function new(string name="yapp_base_seq");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass : yapp_base_seq

//------------------------------------------------------------------------------
//
// SEQUENCE: yapp_5_packets
//
//  Configuration setting for this sequence
//    - update <path> to be hierarchial path to sequencer 
//
//  uvm_config_wrapper::set(this, "<path>.run_phase",
//                                 "default_sequence",
//                                 yapp_5_packets::get_type());
//
//------------------------------------------------------------------------------
class yapp_5_packets extends yapp_base_seq;
  
  // Required macro for sequences automation
  `uvm_object_utils(yapp_5_packets)

  // Constructor
  function new(string name="yapp_5_packets");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_5_packets sequence", UVM_LOW)
     repeat(5)
      `uvm_do(req)
      
  endtask
  
endclass : yapp_5_packets

class yapp_1_seq extends yapp_base_seq;

  // Required macro for sequences automation
  `uvm_object_utils(yapp_1_seq)

  // Constructor
  function new(string name="yapp_1_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_1_seq sequence", UVM_LOW)

    `uvm_do_with(req, { req.addr == 1; }) // Apply constraint addr == 1

  endtask

endclass : yapp_1_seq

class yapp_012_seq extends yapp_base_seq;

  // Required macro for sequences automation
  `uvm_object_utils(yapp_012_seq)

  // Constructor
  function new(string name="yapp_012_seq");
    super.new(name);
  endfunction

  // Sequence body definition
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_012_seq sequence", UVM_LOW)

    
    for (int i =0;i<3;i++) begin
      `uvm_do_with(req, { addr == i; }) // Apply address constraint
    end
  endtask

endclass : yapp_012_seq

class yapp_111_seq extends yapp_base_seq;

  `uvm_object_utils(yapp_111_seq)

  function new(string name="yapp_111_seq");
    super.new(name);
  endfunction

  yapp_1_seq seq1;
  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_111_seq sequence", UVM_LOW)

    repeat (5) begin
      
      `uvm_do(seq1)
    end
  endtask

endclass : yapp_111_seq

class yapp_incr_payload_seq extends yapp_base_seq;

  `uvm_object_utils(yapp_incr_payload_seq)

  function new(string name="yapp_incr_payload_seq");
    super.new(name);
  endfunction


  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_incr_payload_seq sequence", UVM_LOW)
    for (int i =1 ;i < 10;i++) begin
        `uvm_do_with(req,{payload.size()==i ;})
    end
  endtask

endclass : yapp_incr_payload_seq



class yapp_exhaustive_seq extends yapp_base_seq;
  `uvm_object_utils(yapp_exhaustive_seq)

  function new(string name="yapp_exhaustive_seq");
    super.new(name);
  endfunction
  yapp_5_packets seq_5;
  yapp_1_seq seq_1;
  yapp_012_seq seq_012;
  yapp_111_seq seq_111;
  yapp_incr_payload_seq seq_incr_payload;

  virtual task body();
    `uvm_info(get_type_name(), "Executing yapp_exhaustive_seq sequence", UVM_LOW)
    `uvm_do(seq_5)
    `uvm_do(seq_1)
    `uvm_do(seq_012)
    `uvm_do(seq_111)
    `uvm_do(seq_incr_payload)

    endtask

  endclass: yapp_exhaustive_seq










