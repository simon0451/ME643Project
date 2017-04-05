function [the_range] = get_that_out_too(mag)

for j = 1:length(mag)
    if mag(j) < 0.10 && j < length(mag)/2
        mark1 = j;
    elseif mag(j) < 0.10 && j > length(j)/2
        mark2 = j;
    end
end
first = mag(1:mark1);
middle = -mag((mark1+1):mark2);
second = mag((mark2+1):length(mag));
the_range = horzcat(first', middle', second');