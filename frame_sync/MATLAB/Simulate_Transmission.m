% Simulate transmission by passing received data through impulse responses

data = readmatrix("9_Aug_Wired.csv"); % This is the best trial we have to date
IR_path = "../../itc_paper/matlab/impulse_responses/take_4/with_hc/";
IR_names = ["0a" "10a" "20a" "30a" "40a" "50a" "60a" "70a" "80a" "90a"];
IR_suffix = ".mat";

name_to_use = IR_names(1); % Change to use whatever angle you want
load(IR_path + name_to_use + IR_suffix);
new_data = conv(data, h1_pruned); % Can used h2_pruned instead