%% Error construction with W.
% After channel selection,implement construction of W.
clear
clc
addpath 'new_data'
%%
filter_num=512; %to be modified.
filter_channel=512;
filter_height=3;
filter_width=3;
filter_channel_wise=filter_height*filter_width;%weights number in a channel
col_buffer=filter_channel*filter_height*filter_width;
sample_size=10000;
%%
target_layer='conv5_1';
file_data_x=[target_layer,'data_x.bin'];
file_data_y=[target_layer,'data_y.bin'];
file_bias=[target_layer,'bias.bin'];
file_weight=[target_layer,'weight.bin'];
fid_x=fopen(file_data_x,'r');
[data_x, ~]=fread(fid_x,'float');
fid_y=fopen(file_data_y,'r');
[data_y, ~]=fread(fid_y,'float');
fid_bias=fopen(file_bias,'r');
%read bias
[data_bias,~]=fread(fid_bias,'float');
fid_weight=fopen(file_weight,'r');
%read weight
[data_weight, ~]=fread(fid_weight,[filter_channel*filter_height*filter_width,filter_num],'float');
data_weight=data_weight';
data_x=reshape(data_x,[col_buffer,sample_size]);
data_y=reshape(data_y,[filter_num,sample_size]);
answer=data_weight*data_x+repmat(data_bias,1,sample_size);
load conv5_1Pc0.8Pm0.2iter5000error281780.5529rate0.5.mat
%%
index= find(best_individual==1);
col_stored=length(index)*filter_channel_wise;

%select channels
id=best_individual'*ones(1,filter_channel_wise);
[row_id,col_id]=size(id);
id=reshape(id',1,row_id*col_id);
iid= id==1;
new_weight=data_weight(:,iid);
new_data_x=data_x(iid,:);
[~,col]=size(new_weight);
assert(col==col_stored);
[data_row,~]=size(new_data_x);
assert(data_row==col_stored);
fprintf('Error before W reconstruction:%f \n',smallest_error);
%% Linear regression
X=new_data_x';
Y=data_y'; 
W=(X'*X)\X'*Y;
% W=pinv(X'*X)*X'*Y;%广义求逆
W_=W';
error=norm(data_y-W_*new_data_x-repmat(data_bias,1,sample_size),2);
fprintf('Error after W reconstruction:%f \n',error);
%% write weight to bin file.
fileName=['EC_',target_layer,'channel.bin'];
%write best_individual to .bin file for C++ to read.
fid=fopen(fileName,'wb');
assert(fid>0,'File open error!'); 
fwrite(fid,W,'float');%matlab 中按列存储.
fclose(fid);  








