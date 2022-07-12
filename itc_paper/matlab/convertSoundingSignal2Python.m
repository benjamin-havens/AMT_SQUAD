load soundingSignal-BW10-Fs20.mat
fprintf(1,'x_tilde = [ ');
idx = 1;
if imag(xl(idx))>= 0
    fprintf(1,'(%16.15f+%16.15fj), \n',real(xl(idx)),imag(xl(idx)));
else
    fprintf(1,'(%16.15f%16.15fj), \n',real(xl(idx)),imag(xl(idx)));
end
for idx = 2:length(xl)-1
    if imag(xl(idx))>= 0
        fprintf(1,'\t\t(%16.15f+%16.15fj), \n',real(xl(idx)),imag(xl(idx)));
    else
        fprintf(1,'\t\t(%16.15f%16.15fj), \n',real(xl(idx)),imag(xl(idx)));
    end
end
idx = length(xl);
if imag(xl(idx))>= 0
    fprintf(1,'\t\t(%16.15f+%16.15fj)] \n',real(xl(idx)),imag(xl(idx)));
else
    fprintf(1,'\t\t(%16.15f%16.15fj)] \n',real(xl(idx)),imag(xl(idx)));
end