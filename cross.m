function [pop]=cross(pop,popsize,chromosize,pc)
% function [a,b]=cross(a,b)

for i=1:2:popsize
    if(rand < pc&&i<popsize)
        cross_pos = ceil(rand * chromosize);
        for j=cross_pos:chromosize
            pop(i,j)=pop(i,j) & 1;
            pop(i+1,j)=pop(i+1,j) | 1;
        end
    end
end


end
