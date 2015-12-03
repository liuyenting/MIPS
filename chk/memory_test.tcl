onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Timing
add wave -noupdate -label Clock /Memory_TestBench/Mem/clk_i
add wave -noupdate -divider Input
add wave -noupdate -label Address -radix hexadecimal /Memory_TestBench/Mem/addr_i
add wave -noupdate -label {Data In} -radix decimal /Memory_TestBench/Mem/data_i
add wave -noupdate -label CS /Memory_TestBench/Mem/cs
add wave -noupdate -label WE /Memory_TestBench/Mem/we
add wave -noupdate -divider Output
add wave -noupdate -label {Data Out} -radix decimal /Memory_TestBench/Mem/data_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 219
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {117 ps}