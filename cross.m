%交叉算法采用部分匹配交叉
function [pop]=cross(pop,popsize,chromosize,pc)
% function [a,b]=cross(a,b)

for i=1:2:popsize%对i线性等分
    if(rand < pc&&i<popsize)%判断是否需要进行交叉（cross_rate为交叉概率）
        cross_pos = ceil(rand * chromosize);%如果需要交叉，再随机选择交叉位置
       
%         for j=cross_pos:chromosize
%             temp = pop(i,j);
%             pop(i,j) = pop(i+1,j);
%             pop(i+1,j) = temp;%将交叉位置以后的二进制串进行对换（包括交叉位置）
%         end
        %与或交叉
        %i 与
        %i+1 或
        for j=cross_pos:chromosize
            pop(i,j)=pop(i,j) & 1;
            pop(i+1,j)=pop(i+1,j) | 1;
        end
    end
end


end
