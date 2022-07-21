add_force clk {0 0} {1 5ns} -repeat_every 10ns
add_force start 0 
add_force clr 1

run 95 ns

add_force clr 0
add_force start 1

run 50000 ns