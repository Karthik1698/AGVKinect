%%Kinect with matlab%%
%% Kinect Interface%%
imaqhwinfo('kinect'); %Detect Kinect%
colorVid = videoinput('kinect',1);  %Color Sensor%
depthVid = videoinput('kinect',2);  %Depth Sensor%
preview(colorVid);
preview(depthVid);
im= getsnapshot(depthVid);
flush(colorVid);
%% Getting Images from Kinect %%
imaqhwinfo('kinect')
depthVid = videoinput('kinect',2);
triggerconfig =(depthVid, 'manual')
set(depthVid,'FramesPerTrigger',1);
set(depthVid,'Trigger Repeat', Inf)

colorVid = videoinput('kinect',1)
triggerconfig = (colorVid,'manual')
set(colorVid,'FramesPerTrigger',1);
set(colorVid,'Trigger Repeat', Inf)

t0=tic;
start(depthVid)
start(colorVid)
i=15;
while(1)
    trigger(depthVid)
    [imd,depthTimeData,depthMetaData]= getdata(depthVid);
    trigger(colorVid)
    [imc,colorTimeData,colorMetaData]=getdata(colorVid);
    
    subplot(1,2,1)
    imshow(imd,[]);
    
    subplot(1,2,2);
    imshow(imc,[]);
    if toc(t0) > 10.0
        
        t0 = tic;
        imwrite(imc,['color' num2str(i) '.jpg']);
        save(['depth' num2str(i)],'imd');
        i = i+1;
    end
end
stop(depthVid);
stop(colorVid);
