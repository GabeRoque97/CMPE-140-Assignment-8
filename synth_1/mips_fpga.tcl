# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache C:/Users/Work/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-14868-Emil-GamingPc/incrSyn
set_param xicom.use_bs_reader 1
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35ticpg236-1L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/CmpE_140_Projects/project_8/pipelined_processor.cache/wt [current_project]
set_property parent.project_path D:/CmpE_140_Projects/project_8/pipelined_processor.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo d:/CmpE_140_Projects/project_8/pipelined_processor.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_mem {
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/pipelined_code.mem}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/fact_accel.mem}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/data_forwarding.mem}
}
read_verilog -library xil_defaultlib {
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/Factorial_Accelerator/Acccelerator_Blocks.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/AddrDec.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/Address_Decoder/Address_Decoder.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/DQReg.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/datapath/ENdreg.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/new/EXE_stage.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/Factorial_Accelerator/Factorial.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/Factorial_Accelerator/Factorial_Accelerator.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/Factorial_Accelerator/Factorial_Blocks.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/Factorial_Accelerator/Factorial_CU.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/Factorial_Accelerator/Factorial_DP.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/GPIO.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/new/ID_stage.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/new/IF_stage.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/new/MEM_stage.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/datapath/adder.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/datapath/alu.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/control_unit/auxdec.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/button_debouncer.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/clk_gen.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/control_unit/controlunit.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/PIPELINED MIPS/datapath.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/dmem.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/datapath/dreg.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/hex_to_7seg.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/imem.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/led_mux.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/control_unit/maindec.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/PIPELINED MIPS/mips.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/mux2.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/datapath/mux4.v}
  D:/CmpE_140_Projects/project_8/pipelined_processor.srcs/sources_1/new/reg_a_comp.v
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/datapath/regfile.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/datapath/shifter.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/datapath/signext.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/system.v}
  {C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/mips_fpga.v}
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/mips_fpga.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Work/Documents/SJSU/Fall 2019/CMPE 140/CMPE-140-Assignment-8/mips_fpga.xdc}}]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top mips_fpga -part xc7a35ticpg236-1L


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef mips_fpga.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file mips_fpga_utilization_synth.rpt -pb mips_fpga_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
