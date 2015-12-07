onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Timing
add wave -noupdate -label Start /TestBench/CPU/PC/start
add wave -noupdate -label Reset /TestBench/CPU/PC/rst
add wave -noupdate -label Clock /TestBench/CPU/PC/clk
add wave -noupdate -expand -group IF -label {Current Address} -radix unsigned -radixshowbase 0 /TestBench/CPU/PC/addr_o
add wave -noupdate -expand -group IF -label {Write Enable} /TestBench/CPU/PC/we
add wave -noupdate -expand -group ID -expand -group {Parsed Instruction} -label Instruction /TestBench/CPU/instr
add wave -noupdate -expand -group ID -expand -group {Parsed Instruction} -label {Rs Address} -radix unsigned -radixshowbase 0 /TestBench/CPU/RegFiles/Rs_addr
add wave -noupdate -expand -group ID -expand -group {Parsed Instruction} -label {Rt Address} -radix unsigned -radixshowbase 0 /TestBench/CPU/RegFiles/Rt_addr
add wave -noupdate -expand -group ID -expand -group {Parsed Instruction} -label {I-type Immediate} -radix decimal /TestBench/CPU/SignExt/data_i
add wave -noupdate -expand -group ID -group Register -label {Write Enable} /TestBench/CPU/Reg_we_wire
add wave -noupdate -expand -group ID -label {R[Rs] == R[Rt]?} /TestBench/CPU/Rs_eq_Rt/is_equal
add wave -noupdate -expand -group ID -label {Branch Target Address} -radix decimal /TestBench/CPU/PC_Mux/data_4
add wave -noupdate -expand -group ID -label {Jump Target Address} -radix decimal -radixshowbase 0 /TestBench/CPU/PC_Mux/data_3
add wave -noupdate -expand -group EX -label {ALU control} -radix unsigned -radixshowbase 0 /TestBench/CPU/ALU/ALUop_i
add wave -noupdate -expand -group EX -label {Data 1} -radix decimal -radixshowbase 0 /TestBench/CPU/ALU/data_1
add wave -noupdate -expand -group EX -label {Data 2} -radix decimal /TestBench/CPU/ALU/data_2
add wave -noupdate -expand -group EX -label Output -radix decimal /TestBench/CPU/ALU/data_o
add wave -noupdate -expand -group MEM -label {Memory Address} -radix unsigned /TestBench/CPU/DataMem/addr_i
add wave -noupdate -expand -group MEM -label {Chip Select} /TestBench/CPU/DataMem/cs
add wave -noupdate -expand -group MEM -label {Read Data} -radix decimal /TestBench/CPU/DataMem/data_o
add wave -noupdate -expand -group MEM -label {Write Enable} /TestBench/CPU/DataMem/we
add wave -noupdate -expand -group MEM -label {Write Data} -radix decimal /TestBench/CPU/DataMem/data_i
add wave -noupdate -label {ALU mux1} -radix binary -radixshowbase 0 /TestBench/CPU/FwdUnit/ALU_data_1_sel
add wave -noupdate -label {ALU mux2} -radix binary -radixshowbase 0 /TestBench/CPU/FwdUnit/ALU_data_2_sel
add wave -noupdate -radix decimal /TestBench/CPU/Data_2_Mux/data_1
add wave -noupdate -radix decimal /TestBench/CPU/Data_2_Mux/data_2
add wave -noupdate -radix decimal /TestBench/CPU/Data_2_Mux/data_3
add wave -noupdate /TestBench/CPU/Data_2_Mux/sel
add wave -noupdate /TestBench/CPU/Data_2_Mux/data_o
add wave -noupdate /TestBench/CPU/PC_Mux/sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {386 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 243
configure wave -valuecolwidth 202
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {668 ps}
