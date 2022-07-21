add_force clk {0 0} {1 5ns} -repeat_every 10ns

run 95 ns

add_force start 1

run 10 ns

add_force start 0

run 20000 ns

add_force start 1

run 10 ns

add_force start 0

run 20000 ns