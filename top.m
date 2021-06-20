clear;
tic
%====Features and Label===
load('input_data.mat')
features=data_all;
f_label_a_binary=data_all(:,215);
f_label_v_binary=data_all(:,216);

for k=1:214
features(:,k)=features(:,k)-min(features(:,k));
end

for k=1:214
 features(:,k)=features(:,k)/max(features(:,k));
end

for i=1:214
 features(:,i)=features(:,i)-0.4;
end

features_GSR=features(:,1:32);
features_ECG=features(:,1+32:32+77); 
features_EMG=features(:,1+32+77:32+77+105); 

%=======HDC============
HD_functions;     % load HD functions
learningrate=0.266;% percentage of the dataset used to train the algorithm
acc_ngram_1=[];
acc_ngram_2=[];


channels_v=length(features_GSR(1,:));
channels_v_ECG=length(features_ECG(1,:));
channels_v_EMG=length(features_EMG(1,:));

channels_a=channels_v;
channels_a_ECG=channels_v_ECG;
channels_a_EMG=channels_v_EMG;

COMPLETE_1_v=features_GSR;
COMPLETE_1_a=features_GSR;
COMPLETE_1_v_ECG=features_ECG;
COMPLETE_1_a_ECG=features_ECG;
COMPLETE_1_v_EMG=features_EMG;
COMPLETE_1_a_EMG=features_EMG;

for j=1:length(learningrate)    
learningFrac = learningrate(j); 
D = 10000; %dimension of the hypervectors
classes = 2; % level of classes
precision = 20; %no use
ngram = 4; % for temporal encode
maxL = 2; % for IM gen
 
channels_v_EXG=channels_v +channels_v_ECG+channels_v_EMG;
channels_a_EXG=channels_a+channels_a_ECG+channels_a_EMG;


[chAM1, iMch1] = initItemMemories (D, maxL, channels_v);
[chAM2, iMch2] = initItemMemories (D, maxL, channels_a);
[chAM3, iMch3] = initItemMemories (D, maxL, channels_v_ECG);
[chAM4, iMch4] = initItemMemories (D, maxL, channels_a_ECG);
[chAM5, iMch5] = initItemMemories (D, maxL, channels_v_EMG);
[chAM6, iMch6] = initItemMemories (D, maxL, channels_a_EMG);
[chAM7, iMch7] = initItemMemories (D, maxL, channels_v_EXG);
[chAM8, iMch8] = initItemMemories (D, maxL, channels_a_EXG);

%downsample the dataset using the value contained in the variable "downSampRate"
downSampRate = 8;
LABEL_1_v=f_label_v_binary;
LABEL_1_a=f_label_a_binary;
[TS_COMPLETE_1, L_TS_COMPLETE_1] = downSampling (COMPLETE_1_v, LABEL_1_v, downSampRate);
[TS_COMPLETE_2, L_TS_COMPLETE_2] = downSampling (COMPLETE_1_a, LABEL_1_a, downSampRate);
[TS_COMPLETE_3, L_TS_COMPLETE_3] = downSampling (COMPLETE_1_v_ECG, LABEL_1_v, downSampRate);
[TS_COMPLETE_4, L_TS_COMPLETE_4] = downSampling (COMPLETE_1_a_ECG, LABEL_1_a, downSampRate);
[TS_COMPLETE_5, L_TS_COMPLETE_5] = downSampling (COMPLETE_1_v_EMG, LABEL_1_v, downSampRate);
[TS_COMPLETE_6, L_TS_COMPLETE_6] = downSampling (COMPLETE_1_a_EMG, LABEL_1_a, downSampRate);

%generate the training matrices using the learning rate contined in the
%variable "learningFrac"
[L_SAMPL_DATA_1, SAMPL_DATA_1] = genTrainData (TS_COMPLETE_1, L_TS_COMPLETE_1, learningFrac, 'inorder');
[L_SAMPL_DATA_2, SAMPL_DATA_2] = genTrainData (TS_COMPLETE_2, L_TS_COMPLETE_2, learningFrac, 'inorder');
[L_SAMPL_DATA_3, SAMPL_DATA_3] = genTrainData (TS_COMPLETE_3, L_TS_COMPLETE_3, learningFrac, 'inorder');
[L_SAMPL_DATA_4, SAMPL_DATA_4] = genTrainData (TS_COMPLETE_4, L_TS_COMPLETE_4, learningFrac, 'inorder');
[L_SAMPL_DATA_5, SAMPL_DATA_5] = genTrainData (TS_COMPLETE_5, L_TS_COMPLETE_5, learningFrac, 'inorder');
[L_SAMPL_DATA_6, SAMPL_DATA_6] = genTrainData (TS_COMPLETE_6, L_TS_COMPLETE_6, learningFrac, 'inorder');

%Sparse biopolar mapping
q=0.3;
projM1=projBRandomHV(D,channels_v,q);
projM2=projBRandomHV(D,channels_a,q);
projM3=projBRandomHV(D,channels_v_ECG,q);
projM4=projBRandomHV(D,channels_a_ECG,q);
projM5=projBRandomHV(D,channels_v_EMG,q);
projM6=projBRandomHV(D,channels_a_EMG,q);


%for N = 1 : ngram
for N = 4 : ngram
N

fprintf ('HDC for Arousal\n');
[numpat_2, hdc_model_2] = hdctrainproj (L_SAMPL_DATA_2, SAMPL_DATA_2, chAM8, iMch2, D, N, precision, channels_a,projM2); 
[numpat_4, hdc_model_4] = hdctrainproj (L_SAMPL_DATA_4, SAMPL_DATA_4, chAM8, iMch4, D, N, precision, channels_a_ECG,projM4); 
[numpat_6, hdc_model_6] = hdctrainproj (L_SAMPL_DATA_6, SAMPL_DATA_6, chAM8, iMch6, D, N, precision, channels_a_EMG,projM6); 

hdc_model_2(1)=mode([hdc_model_2(1); hdc_model_4(1); hdc_model_6(1)]);
hdc_model_2(2)=mode([hdc_model_2(2); hdc_model_4(2); hdc_model_6(2)]);


for i=1:channels_a
iMch8(i)=iMch2(i);
end
for i=channels_a+1:channels_a+channels_a_ECG
iMch8(i)=iMch4(i-channels_a);
end
for i=channels_a+channels_a_ECG+1:channels_a+channels_a_ECG+channels_a_EMG
iMch8(i)=iMch6(i-channels_a-channels_a_ECG);
end

[acc_ex2, acc2, pl2, al2] = hdcpredictproj  (L_TS_COMPLETE_2, TS_COMPLETE_2, L_TS_COMPLETE_4, TS_COMPLETE_4, L_TS_COMPLETE_6, TS_COMPLETE_6,hdc_model_2, chAM8, iMch8, D, N, precision, classes, channels_a,channels_a_ECG,channels_a_EMG,projM2,projM4,projM6);
toc
accuracy(N,2) = acc2;
acc2
%acc1
acc_ngram_2(N,j)=acc2;
end


end