%�����㷨���ò���ƥ�佻��
function [pop]=cross(pop,popsize,chromosize,pc)
% function [a,b]=cross(a,b)

for i=1:2:popsize%��i���Եȷ�
    if(rand < pc&&i<popsize)%�ж��Ƿ���Ҫ���н��棨cross_rateΪ������ʣ�
        cross_pos = ceil(rand * chromosize);%�����Ҫ���棬�����ѡ�񽻲�λ��
       
%         for j=cross_pos:chromosize
%             temp = pop(i,j);
%             pop(i,j) = pop(i+1,j);
%             pop(i+1,j) = temp;%������λ���Ժ�Ķ����ƴ����жԻ�����������λ�ã�
%         end
        %��򽻲�
        %i ��
        %i+1 ��
        for j=cross_pos:chromosize
            pop(i,j)=pop(i,j) & 1;
            pop(i+1,j)=pop(i+1,j) | 1;
        end
    end
end


end
