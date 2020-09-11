%% �Գ���ͼ����ͼ��Ԥ����
plate_img = imread('����ͼ��.jpg');

%% ת���ɻҶ�ͼ��
plate_img1 = rgb2gray(plate_img);    % RGBͼ��ת�Ҷ�ͼ��
figure;
subplot(1, 2, 1);
imshow(plate_img1);
title('�Ҷ�ͼ��');
subplot(1, 2, 2);
imhist(plate_img1);
title('�Ҷȴ����ĻҶ�ֱ��ͼ');

%% ֱ��ͼ���⻯
plate_img2 = histeq(plate_img1);
figure('name', 'ֱ��ͼ���⻯');
subplot(1,2,1);
imshow(plate_img2);
title('ֱ��ͼ���⻯��ͼ��');
subplot(1,2,2);
imhist(plate_img2);
title('ֱ��ͼ');

%% ��ֵ������
plate_img3 = im2bw(plate_img2, 0.76);
figure('name', '��ֵ������');
imshow(plate_img3);
title('���ƶ�ֵͼ��');

%% ��ֵ�˲�
plate_img4 = medfilt2(plate_img3);
figure('name', '��ֵ�˲�');
imshow(plate_img4);
title('��ֵ�˲����ͼ��');

%% �����ַ�ʶ��
plate_img5 = my_imsplit(plate_img4);
[m, n] = size(plate_img5);

s = sum(plate_img5);    %sum(x)����������ӣ���ÿ�еĺͣ������������;
j = 1;
k1 = 1;
k2 = 1;
while j ~= n
    while s(j) == 0
        j = j + 1;
    end
    k1 = j;
    while s(j) ~= 0 && j <= n-1
        j = j + 1;
    end
    k2 = j + 1;
    if k2 - k1 > round(n / 6.5)
        [val, num] = min(sum(plate_img5(:, [k1+5:k2-5])));
        plate_img5(:, k1+num+5) = 0;
    end
end

y1 = 10;
y2 = 0.25;
flag = 0;
word1 = [];
while flag == 0
    [m, n] = size(plate_img5);
    left = 1;
    width = 0;
    while sum(plate_img5(:, width+1)) ~= 0
        width = width + 1;
    end
    if width < y1
        plate_img5(:, [1:width]) = 0;
        plate_img5 = my_imsplit(plate_img5);
    else
        temp = my_imsplit(imcrop(plate_img5, [1,1,width,m]));
        [m, n] = size(temp);
        all = sum(sum(temp));
        two_thirds=sum(sum(temp([round(m/3):2*round(m/3)],:)));
        if two_thirds/all > y2
            flag = 1;
            word1 = temp;
        end
        plate_img5(:, [1:width]) = 0;
        plate_img5 = my_imsplit(plate_img5);
    end
end

figure;
subplot(2,4,1), imshow(plate_img5);

 % �ָ���ڶ����ַ�
 [word2,plate_img5]=getword(plate_img5);
 subplot(2,4,2), imshow(plate_img5);
 % �ָ���������ַ�
 [word3,plate_img5]=getword(plate_img5);
 subplot(2,4,3), imshow(plate_img5);
 % �ָ�����ĸ��ַ�
 [word4,plate_img5]=getword(plate_img5);
 subplot(2,4,4), imshow(plate_img5);
 % �ָ��������ַ�
 [word5,plate_img5]=getword(plate_img5);
 subplot(2,3,4), imshow(plate_img5);
 % �ָ���������ַ�
 [word6,plate_img5]=getword(plate_img5);
 subplot(2,3,5), imshow(plate_img5);
 % �ָ�����߸��ַ�
 [word7,plate_img5]=getword(plate_img5);
 subplot(2,3,6), imshow(plate_img5);

 figure;
 subplot(5,7,1),imshow(word1),title('1');
 subplot(5,7,2),imshow(word2),title('2');
 subplot(5,7,3),imshow(word3),title('3');
 subplot(5,7,4),imshow(word4),title('4');
 subplot(5,7,5),imshow(word5),title('5');
 subplot(5,7,6),imshow(word6),title('6');
 subplot(5,7,7),imshow(word7),title('7');

 word1=imresize(word1,[40 20]);%imresize��ͼ�������Ŵ������õ��ø�ʽΪ��B=imresize(A,ntimes,method)������method��ѡnearest,bilinear��˫���ԣ�,bicubic,box,lanczors2,lanczors3��
 word2=imresize(word2,[40 20]);
 word3=imresize(word3,[40 20]);
 word4=imresize(word4,[40 20]);
 word5=imresize(word5,[40 20]);
 word6=imresize(word6,[40 20]);
 word7=imresize(word7,[40 20]);

 subplot(5,7,15),imshow(word1),title('11');
 subplot(5,7,16),imshow(word2),title('22');
 subplot(5,7,17),imshow(word3),title('33');
 subplot(5,7,18),imshow(word4),title('44');
 subplot(5,7,19),imshow(word5),title('55');
 subplot(5,7,20),imshow(word6),title('66');
 subplot(5,7,21),imshow(word7),title('77');
 
 imwrite(word1,'1.jpg'); % ������λ�����ַ�ͼ��
 imwrite(word2,'2.jpg');
 imwrite(word3,'3.jpg');
 imwrite(word4,'4.jpg');
 imwrite(word5,'5.jpg');
 imwrite(word6,'6.jpg');
 imwrite(word7,'7.jpg');
 
 %% �����ַ�ʶ��
 liccode=char(['0':'9' 'A':'Z' '��������³��']);
 % ��ţ�0-9�ֱ�Ϊ 1-10;A-Z�ֱ�Ϊ 11-36;
 % ��  ��  ��  ��  ��  ��  ��  ��  ³  ԥ  ��  ��  ��  ��  ��  ��  ��
 % ��  ��  ��  ��  ��  ̨  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��
 % 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 
 % 60 61 62 63 64 65 66 67 68 69 70
 subBw2 = zeros(40, 20);
 num = 1;   
 % ����λ��
 for i = 1:7
    ii = int2str(i);    % ����������ת��Ϊ�ַ���������
    word = imread([ii,'.jpg']); % ��ȡ֮ǰ�ָ�����ַ���ͼƬ
    segBw2 = imresize(word, [40,20], 'nearest');    % ����ͼƬ�Ĵ�С
    segBw2 = im2bw(segBw2, 0.5);    % ͼ���ֵ��
    if i == 1   % �ַ���һλΪ���֣���λ���������ֶ�
        kMin = 37;
        kMax = 42;
    elseif i == 2   % �ڶ�λΪӢ����ĸ����λ��ĸ�����ֶ�
        kMin = 11;
        kMax = 36;
    elseif i >= 3   % ����λ��ʼ���������ˣ���λ���������ֶ�
        kMin = 1;
        kMax = 36;
    end
    
    l = 1;
    for k = kMin : kMax
        fname = strcat('namebook/',liccode(k),'.jpg');  % �����ַ����ҵ�ͼƬģ��
        samBw2 = imread(fname); % ��ȡģ����е�ͼƬ
        samBw2 = im2bw(samBw2, 0.5);    % ͼ���ֵ��
        
        % ����ʶ��ͼƬ��ģ��ͼƬ����
        for i1 = 1:40
            for j1 = 1:20
                subBw2(i1, j1) = segBw2(i1, j1) - samBw2(i1 ,j1);
            end
        end
        
        % ͳ������ͼƬ��ͬ��ĸ���������������
        Dmax = 0;
        for i2 = 1:40
            for j2 = 1:20
                if subBw2(i2, j2) ~= 0
                    Dmax = Dmax + 1;
                end
            end
        end
        error(l) = Dmax;
        l = l + 1;
    end
    
    % �ҵ�ͼƬ������ٵ�ͼ��
    errorMin = min(error);
    findc = find(error == errorMin);

    % �����ֿ⣬��Ӧ��ʶ����ַ�
    Code(num*2 - 1) = liccode(findc(1) + kMin - 1);
    Code(num*2) = ' ';
    num = num + 1;
    
    
 end
 
 % ��ʾʶ����
 disp(Code);
 msgbox(Code,'ʶ����ĳ��ƺ�');

