classdef Snake < handle
    %PATCH 2016-11-09 JN
    properties
        arena = ones(100,200);
        elements
        TRONS
        life
        player
        err %PATCH 2016-11-09 JN
    end
    methods
        function hObject = Snake(varargin)
%             [y f]=audioread('ReeckFirebird.mps3'); %PATCH 2016-11-09 JN
%             hObject.player = audioplayer(y,f); %PATCH 2016-11-09 JN
            hObject.elements.counter=0;
            hObject.elements.speed=5;
            hObject.elements.drawnow = varargin{2};
            hObject.create_arena;
            hObject.load_trons;
            hObject.tournament;
        end  
        function hObject = create_arena(hObject)
            hObject.elements.Main_figure = figure('Menubar','none',...
                                            'Color','k',...
                                            'Units','normalized',...
                                            'Name','Snake',...
                                            'Position',[0.1 0.1 0.8 0.8]); 
                                        
            hObject.elements.axes = axes(   'Parent',hObject.elements.Main_figure,...
                                            'Units','normalized',...
                                            'XColor','w',...
                                            'YColor','w',...
                                            'XTick',[],...
                                            'YTick',[],...
                                            'Position',[0 0 0.8 1]);
                                        
           hObject.elements.axes2 = axes(   'Parent',hObject.elements.Main_figure,...
                                            'Units','normalized',...
                                            'Color','k',...
                                            'XColor','w',...
                                            'YColor','w',...
                                            'XTick',[],...
                                            'YTick',[],...
                                            'Position',[0.8 0 0.2 1]);
                                        
            hObject.elements.text3=text(    'Parent',hObject.elements.axes2,...
                                            'FontUnits','normalized',...
                                            'FontSize',0.02,...
                                            'Position',[0.5 1],...
                                            'Color','w',...
                                            'HorizontalAlignment','center',...
                                            'VerticalAlignment','top',...
                                            'String','Snakes');
                                        
            hObject.elements.text4=text(    'Parent',hObject.elements.axes2,...
                                            'FontUnits','normalized',...
                                            'FontSize',0.02,...
                                            'Position',[0.5 0.25],...
                                            'Color','w',...
                                            'HorizontalAlignment','center',...
                                            'VerticalAlignment','bottom',...
                                            'String','Play again',...
                                            'ButtonDownFcn',{@hObject.play});
                                        
            hObject.elements.text5=text(    'Parent',hObject.elements.axes2,...
                                            'FontUnits','normalized',...
                                            'FontSize',0.02,...
                                            'Position',[0.5 0.2],...
                                            'Color','w',...
                                            'HorizontalAlignment','center',...
                                            'VerticalAlignment','bottom',...
                                            'ButtonDownFcn',{@hObject.visible});
                                        
            if hObject.elements.drawnow(1:2)=='on'
                set(hObject.elements.text5,'string','Visible: On')
            else
                set(hObject.elements.text5,'string','Visible: Off')
            end 
            
            hObject.elements.text9=text(    'Parent',hObject.elements.axes2,...
                                            'FontUnits','normalized',...
                                            'FontSize',0.02,...
                                            'Position',[0.4 0.15],...
                                            'Color','w',...
                                            'HorizontalAlignment','right',...
                                            'VerticalAlignment','bottom',...
                                            'String','Slower',...
                                            'tag','Slower',...
                                            'ButtonDownFcn',{@hObject.speed});
                                        
            hObject.elements.text10=text(   'Parent',hObject.elements.axes2,...
                                            'FontUnits','normalized',...
                                            'FontSize',0.02,...
                                            'Position',[0.6 0.15],...
                                            'Color','w',...
                                            'HorizontalAlignment','left',...
                                            'VerticalAlignment','bottom',...
                                            'String','Faster',...
                                            'tag','Faster',...
                                            'ButtonDownFcn',{@hObject.speed});
            
            hObject.elements.text6=text(    'Parent',hObject.elements.axes2,...
                                            'FontUnits','normalized',...
                                            'FontSize',0.02,...
                                            'Position',[0.5 0.1],...
                                            'Color','w',...
                                            'HorizontalAlignment','center',...
                                            'VerticalAlignment','bottom',...
                                            'String','Reset score',...
                                            'ButtonDownFcn',{@hObject.reset});
            hObject.elements.exit=0;
            hObject.elements.text7=text(    'Parent',hObject.elements.axes2,...
                                            'FontUnits','normalized',...
                                            'FontSize',0.02,...
                                            'Position',[0.5 0.05],...
                                            'Color','w',...
                                            'HorizontalAlignment','center',...
                                            'VerticalAlignment','bottom',...
                                            'String','Exit',...
                                            'ButtonDownFcn',{@hObject.exit});
                                        
%             hObject.elements.text8=text(    'Parent',hObject.elements.axes2,...%PATCH 2016-11-09 JN
%                                             'FontUnits','normalized',...
%                                             'FontSize',0.02,...
%                                             'Position',[0.5 0.3],...
%                                             'Color','g',...
%                                             'HorizontalAlignment','center',...
%                                             'VerticalAlignment','bottom',...
%                                             'String','Play song',...
%                                             'ButtonDownFcn',{@hObject.song});
                                         
            hObject.elements.myColormap=prism;
            hObject.elements.myColormap(1,:)=0;
            colormap(hObject.elements.axes,hObject.elements.myColormap);
            hObject.elements.pcolor=image(hObject.arena,...
                                            'Parent',hObject.elements.axes); 
                                        
        end 
        function hObject = speed(hObject,eventdata,~)
            if get(eventdata,'tag')=='Slower'
                hObject.elements.speed=hObject.elements.speed-1;
                if hObject.elements.speed<0
                   hObject.elements.speed=0; 
                end
            else
                hObject.elements.speed=hObject.elements.speed+1;
            end
        end     
        function hObject = reset(hObject,~,~)
            for i=1:length(hObject.TRONS)
                hObject.TRONS{i}.score=0;
                set(hObject.elements.text2(i),'string',[num2str(hObject.TRONS{i}.score),' '])
            end
        end      
        function hObject = play(hObject,~,~)
            hObject.arena = ones(100,200);
            [m,n]=size(hObject.arena);
            for i=1:length(hObject.TRONS)
                hObject.TRONS{i}.userdata=[]; %PATCH 2016-11-09 JN
                hObject.TRONS{i}.position=[randi(n) randi(m)];
                x=hObject.TRONS{i}.position(1);
                y=hObject.TRONS{i}.position(2);
                hObject.TRONS{i}.tailX=linspace(x,x,5);
                hObject.TRONS{i}.tailY=linspace(y,y,5);
                hObject.arena(hObject.TRONS{i}.position(2),hObject.TRONS{i}.position(1))=i+2;
                hObject.TRONS{i}.score=5;
            end
            hObject.life(:)=1;
            hObject.tournament;
        end      
        function hObject = exit(hObject,~,~)
%             stop(hObject.player)
            hObject.elements.exit=1;
            close all
        end        
        function hObject = visible(hObject,eventdata,~)
            if hObject.elements.drawnow(1:2)=='on'
                set(eventdata,'string','Visible: Off')
                hObject.elements.drawnow='off';
            else
                hObject.elements.drawnow='on';
                set(eventdata,'string','Visible: On')
            end
        end       
        function hObject = load_trons(hObject)
            addpath(strcat(pwd,'/Snakes'));                                  % Pøidá cestu k Tronùm
            files=dir(strcat(pwd,'/Snakes/','*.m'));                         % Najde .m soubory
            if ~isempty(files)
                TRONS={files(not(strncmp({files(:).name}, '.', 1))).name};  % Odstraní soubory který zaèínají teèkou (skryté soubory)
                [m,n]=size(hObject.arena);
                for i=1:length(TRONS)
                    hObject.TRONS{i}.name = TRONS{i}(1:end-2);              % Odstraní .m
                    hObject.TRONS{i}.userdata=[];
                    hObject.TRONS{i}.position=[randi(n) randi(m)];
                    x=hObject.TRONS{i}.position(1);
                    y=hObject.TRONS{i}.position(2);
                    hObject.TRONS{i}.tailX=linspace(x,x,5);
                    hObject.TRONS{i}.tailY=linspace(y,y,5);
                    hObject.life(i)=1;
                    hObject.TRONS{i}.score=0;
                    hObject.arena(hObject.TRONS{i}.position(2),hObject.TRONS{i}.position(1))=i+2;
                    hObject.elements.text1(i)=text( 'Parent',hObject.elements.axes2,...
                                                    'FontUnits','normalized',...
                                                    'FontSize',0.02,...
                                                    'Position',[0 1-i*0.05],...
                                                    'Color',hObject.elements.myColormap(i+2,:),...
                                                    'HorizontalAlignment','left',...
                                                    'VerticalAlignment','top',...
                                                    'String',[' ',TRONS{i}(1:end-2)]);
                                                
                    hObject.elements.text2(i)=text( 'Parent',hObject.elements.axes2,...
                                                    'FontUnits','normalized',...
                                                    'FontSize',0.02,...
                                                    'Position',[1 1-i*0.05],...
                                                    'Color',hObject.elements.myColormap(i+2,:),...
                                                    'HorizontalAlignment','right',...
                                                    'VerticalAlignment','top',...
                                                    'String',['0 ',]);
                                          
                end
            end
        end          
        function hObject = tournament(hObject)
            while and(any(hObject.life),hObject.elements.exit==0)
                %% jídlo
                if length(find(hObject.arena==7)) < 5
                    [n,m]=size(hObject.arena);
                    x=randi(n);
                    y=randi(m);
                    if hObject.arena(x,y)==1
                        hObject.arena(x,y)=7;
                    end
                end
                
                for i = 1:length(hObject.TRONS)
                    if hObject.life(i) == 1
%                         hObject.TRONS{i}.score=hObject.TRONS{i}.score+1;
                        set(hObject.elements.text2(i),'string',[num2str(hObject.TRONS{i}.score),' '])
                        try
                            direction=[];
                            [hObject.TRONS{i}.userdata,direction]=feval(hObject.TRONS{i}.name,hObject.TRONS{i}.position,hObject.arena,hObject.TRONS{i}.userdata);                        
                            x=hObject.TRONS{i}.position(1);
                            y=hObject.TRONS{i}.position(2);
                            
                            switch direction
                                case 1
                                    hObject.TRONS{i}.position(1)=x-1;
                                    hObject.TRONS{i}.position(2)=y;
                                case 2
                                    hObject.TRONS{i}.position(1)=x;
                                    hObject.TRONS{i}.position(2)=y-1;
                                case 3
                                    hObject.TRONS{i}.position(1)=x+1;
                                    hObject.TRONS{i}.position(2)=y;
                                case 4
                                    hObject.TRONS{i}.position(1)=x;
                                    hObject.TRONS{i}.position(2)=y+1;
                                otherwise
                                    disp(strcat('Snake: ',hObject.TRONS{i}.name,' je mrtvej (nedefinovanej smìr)')) 
                                    hObject.TRONS(i).life=0;
                            end
                            hObject.collision(i);
%                             hObject.arena(y,x)=1;
                            set(hObject.elements.pcolor,'CData',hObject.arena)
                        catch err %PATCH 2016-11-09 JN
                            hObject.err{i}=err; %PATCH 2016-11-09 JN
                            fprintf(2,'Error in %s ',hObject.err{i}.stack(1).name) %PATCH 2016-11-09 JN
                            fprintf(2,'on line %d\n',hObject.err{i}.stack(1).line) %PATCH 2016-11-09 JN
                            fprintf(2,'Error identifier: %s\n',hObject.err{i}.identifier) %PATCH 2016-11-09 JN
                            fprintf(2,'Error message: %s\n',hObject.err{i}.message) %PATCH 2016-11-09 JN
                          
                            disp(strcat('Snake: ',hObject.TRONS{i}.name,' je mrtvej (program nefunguje)'))
                            hObject.life(i)=0;
                        end
                    end
                end
                if hObject.elements.drawnow(1:2)=='on'
                   
                   pause(0.1/(hObject.elements.speed+1)) 
                   hObject.elements.counter=hObject.elements.counter+1;
%                    if hObject.elements.counter>hObject.elements.speed
%                        hObject.elements.counter=0;
                       drawnow
%                    end
                end
            end
            disp('Game Over')
        end        
        function hObject = collision(hObject,i)
            [m,n] = size(hObject.arena);
            
            X = hObject.TRONS{i}.position(1);
            Y = hObject.TRONS{i}.position(2);
            
            if (X>0 && X<=n) & (Y>0 && Y<=m)
                if hObject.arena(Y,X)==1
                   hObject.arena(Y,X)=i+2;
                   hObject.TRONS{i}.tailX=[X,hObject.TRONS{i}.tailX(1:end-1)];
                   hObject.TRONS{i}.tailY=[Y,hObject.TRONS{i}.tailY(1:end-1)];
                   Xend=hObject.TRONS{i}.tailX(end);
                   Yend=hObject.TRONS{i}.tailY(end);
                   hObject.arena(Yend,Xend)=1;
                elseif hObject.arena(Y,X)==7
                   hObject.TRONS{i}.score=hObject.TRONS{i}.score+1;
                   hObject.arena(Y,X)=i+2;
                   hObject.TRONS{i}.tailX=[X,hObject.TRONS{i}.tailX(1:end)];
                   hObject.TRONS{i}.tailY=[Y,hObject.TRONS{i}.tailY(1:end)];
                   Xend=hObject.TRONS{i}.tailX(end);
                   Yend=hObject.TRONS{i}.tailY(end);
                   hObject.arena(Yend,Xend)=1; 
                else
                    disp(strcat('Snake: ',hObject.TRONS{i}.name,' je mrtvej (narazil do hráèe)'))
                    hObject.life(i)=0;
                end
            else
                disp(strcat('Snake: ',hObject.TRONS{i}.name,' je mrtvej (narazil do stìny)'))
                hObject.life(i)=0;
            end
        end 
    end
end