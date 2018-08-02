function [pop]=mutate(pop,popsize, chromosize, mutaterate)
 for i=1:popsize
    if rand < mutaterate
        mutate_pos1 = ceil(rand*chromosize);
        mutate_pos2=ceil(rand*chromosize);
        pop(i,mutate_pos1) = 1 - pop(i, mutate_pos1);
        pop(i,mutate_pos2) = 1 - pop(i, mutate_pos2);
    end
 end 
end
