filename = '\\wsl.localhost\ubuntu-20.04\home\pwpre\AMT_lab\AMT_SQUAD\results\june_11\MHz_test3.csv';
fp = fopen(filename);

foo = fscanf(fp,'%c',1);
while(~strcmp(foo,'('))
    foo = fscanf(fp,'%c',1);
end
foo = fscanf(fp,'%f %fj),(');

M = foo(1:2:end) + foo(2:2:end)*1i;

fclose(fp);