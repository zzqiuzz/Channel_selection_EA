function [selected_pop]=select(pop,popsize,chromosize,sum_error,errortable)

selected_pop(popsize,chromosize)=0;
for i=1:popsize
    r = rand *sum_error;
    first = 1;
    last = popsize;
    mid = round((last+first)/2);
    idx = -1;
    while (first <= last) && (idx == -1) 
        if r > errortable(mid)
            first = mid;
        elseif r < errortable(mid)
            last = mid;
        else
            idx = mid;
            break;
        end
        mid = round((last+first)/2);
        if (last - first) == 1
            idx = last;
            break;
        end
    end
    for j=1:chromosize
        selected_pop(i,j)=pop(idx,j);
    end
end









end
