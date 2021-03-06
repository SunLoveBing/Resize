function PicResize(BlankPicPath,SrcImgPath,destination)

BlankPicPath = strcat(BlankPicPath,'blank.jpg');
ImgPath = dir([SrcImgPath,'*','.jpg']);

%统计待处理图片的张数
ImgNum = 0;
for i = 1 : length(ImgPath)
    ImgNum = ImgNum + 1;
end

%待处理图片的储存路径ImgPathName以及处理后图片的储存路径destinationName
ImgPathName = cell(ImgNum,1);
destinationName = cell(ImgNum,1);
for i = 1 : ImgNum
    ImgPathName{i} = strcat(SrcImgPath,ImgPath(i).name);
    destinationName{i} = strcat(destination,ImgPath(i).name);
end

%调整图片尺寸
for k = 1 : ImgNum
    BlankPic = imread(BlankPicPath);
    BlankPic_width = size(BlankPic,2);
    BlankPic_height = size(BlankPic,1);
    
    Img = imread(ImgPathName{k});
    Img_width = size(Img,2);
    Img_height = size(Img,1);

    Img = imresize(Img,[Img_height*BlankPic_width/Img_width,BlankPic_width]);
    Img_height = size(Img,1);
    diff = BlankPic_height - Img_height;

    if diff > 0
        for i = BlankPic_height : -1 : 1
            if i > diff
                for j = 1 : BlankPic_width
                    BlankPic(i,j,1) = Img(i-diff,j,1);
                    BlankPic(i,j,2) = Img(i-diff,j,2);
                    BlankPic(i,j,3) = Img(i-diff,j,3);
                end
            end
        end  
        imwrite(BlankPic,destinationName{k},'jpg');
    else
        imwrite(Img,destinationName{k},'jpg');
    end
end