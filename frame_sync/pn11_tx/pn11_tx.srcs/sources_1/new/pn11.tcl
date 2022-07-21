add_force clk {0 0} {1 5ns} -repeat_every 10ns
add_force enable 0

run 95 ns

add_force enable 1

run 20000

add_force enable 0

run 1000

add_force enable 1

run 20000