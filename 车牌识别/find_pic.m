%ּ�ڶ�λͼƬ�еĳ��ƣ���������ͼƬ�����ڱ���

%% �Ҷȴ���
img1 = rgb2gray(img);    % RGBͼ��ת�Ҷ�ͼ��
figure;
subplot(1, 2, 1);
imshow(img1);
title('�Ҷ�ͼ��');
subplot(1, 2, 2);
imhist(img1);
title('�Ҷȴ����ĻҶ�ֱ��ͼ');

%% ֱ��ͼ���⻯
img2 = histeq(img1);    %ֱ��ͼ���⻯
figure;
subplot(1, 2, 1);
imshow(img2);
title('�Ҷ�ͼ��');
subplot(1, 2, 2);
imhist(img2);
title('�Ҷȴ����ĻҶ�ֱ��ͼ');

%% ��ֵ�˲�
img3 = medfilt2(img2);
figure;
imshow(img3);
title('��ֵ�˲�');

%% ��Ե��ȡ
% img4 = edge(img3, 'roberts', 0.15, 'both');
% figure('name','��Ե���');
% imshow(img4);
% title('roberts���ӱ�Ե���');

img4 = edge(img3, 'sobel', 0.2);
figure('name','��Ե���');
imshow(img4);
title('sobel���ӱ�Ե���');

%% ͼ��ʴ
se=[1;1;1];
img5 = imerode(img4, se);
figure('name','ͼ��ʴ');
imshow(img5);
title('ͼ��ʴ���ͼ��');

%% ƽ��ͼ��ͼ������
se = strel('rectangle', [20, 20]);
img6 = imclose(img5, se);
figure('name','ƽ������');
imshow(img6);
title('ƽ��ͼ�������');

%% ��ͼ����ɾ����������1000����8�ڽ�
img7 = bwareaopen(img6, 1000);
figure('name', '�Ƴ�С����');
imshow(img7);
title('��ͼ�����Ƴ�С����');

%% �и��ͼ��
[y, x, z] = size(img7);
img8 = double(img7);    % ת��˫���ȸ�����

% ���Ƶ���ɫ����
% Y����
blue_Y = zeros(y, 1);
for i = 1:y
    for j = 1:x
        if(img8(i, j) == 1) % �жϳ���λ������
            blue_Y(i, 1) = blue_Y(i, 1) + 1;    % ���ص�ͳ��
        end
    end
end

% �ҵ�Y�������Сֵ
img_Y1 = 1;
while (blue_Y(img_Y1) < 5) && (img_Y1 < y)
    img_Y1 = img_Y1 + 1;
end

% �ҵ�Y��������ֵ
img_Y2 = y;
while (blue_Y(img_Y2) < 5) && (img_Y2 > img_Y1)
    img_Y2 = img_Y2 - 1;
end

% x����
blue_X = zeros(1, x);
for j = 1:x
    for i = 1:y
        if(img8(i, j) == 1) % �жϳ���λ������
            blue_X(1, j) = blue_X(1, j) + 1;
        end
    end
end

% �ҵ�x�������Сֵ
img_X1 = 1;
while (blue_X(1, img_X1) < 5) && (img_X1 < x)
    img_X1 = img_X1 + 1;
end

% �ҵ�x�������Сֵ
img_X2 = x;
while (blue_X(1, img_X2) < 5) && (img_X2 > img_X1)
    img_X2 = img_X2 - 1;
end

% ��ͼ����вü�
img9 = img(img_Y1:img_Y2, img_X1:img_X2, :);
figure('name', '��λ����ͼ��');
imshow(img9);
title('��λ���к�Ĳ�ɫ����ͼ��')


% ������ȡ�����ĳ���ͼ��
imwrite(img9, '����ͼ��.jpg');

