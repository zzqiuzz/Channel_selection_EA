function [pop]=mutate(pop,popsize, chromosize, mutaterate)%�����������
 for i=1:popsize
    if rand < mutaterate%����һ��������ж��Ƿ���Ҫ���죨mutate_rateΪ������ʣ�һ��Ϊһ���Ƚ�С��ʵ����
        mutate_pos1 = ceil(rand*chromosize);%ȷ������λ��
        mutate_pos2=ceil(rand*chromosize);
        pop(i,mutate_pos1) = 1 - pop(i, mutate_pos1);%�Ը�λ�õĶ��������ֽ��б��죺1���0, 0���1.
        pop(i,mutate_pos2) = 1 - pop(i, mutate_pos2);%�Ը�λ�õĶ��������ֽ��б��죺1���0, 0���1.
    end
 end 
end
