function pn = GeneratePN11

% Generates the maximal-length shift register
% sequence based on X^11 + X^9 + 1
% See "Linear Feedback Shift Register" in Wikipedia

pn = zeros(2047,1);
STATE = zeros(11,1);
STATE(1) = 1;

for idx = 1:2047
    %%% generate output
    pn(idx) = STATE(1);
    
    %%% update states
    STATE(1) = STATE(2);
    STATE(2) = STATE(3);
    STATE(3) = STATE(4);
    STATE(4) = STATE(5);
    STATE(5) = STATE(6);
    STATE(6) = STATE(7);
    STATE(7) = STATE(8);
    STATE(8) = STATE(9);
    STATE(9) = mod(STATE(10)+pn(idx),2);
    STATE(10) = STATE(11);
    STATE(11) = pn(idx);
end

return

a = 2*pn-1;
b = [a(end); a(1:end-1)];
x = zeros(2046+2046+1,1);
for idx = 1:length(x)
    x(idx) = b'*a;
    b = [b(end); b(1:end-1)];
end
figure(99);
stem(-2046:2046,x); grid on;
