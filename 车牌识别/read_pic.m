%%
clc;
clear;
close all;
set(0,'DefaultFigureWindowStyle','docked')


%% �Զ�������ʾ���ȡͼ��

% [FileName,PathName,FilterIndex] = uigetfile(FilterSpec,DialogTitle,DefaultName)
% FileName�����ص��ļ���
% PathName�����ص��ļ���·����
% FilterIndex��ѡ����ļ�����
% FilterSpec���ļ���������
% DialogTitle���򿪶Ի���ı���
% DefaultName��Ĭ��ָ����ļ���
[filename filepath] = uigetfile('.jpg', '����һ����Ҫʶ������Ƶ�ͼ��');   %�Զ�����ͼ��

file = strcat(filepath, filename);   %strcat�����������ַ�������filepath���ַ�����filename�����ӣ���·��/�ļ���
img = imread(file);
figure;
imshow(img);
title('����ͼ��');