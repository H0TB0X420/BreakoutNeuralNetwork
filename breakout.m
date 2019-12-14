classdef breakout
   properties
         Score,paddle,bricks, ball, paddlePos, X, Y, State, Sound, Speed, hScore, hSplash, hSound, hSpeed, ballX,ballY,ballDX,ballDY
   end
   methods
       function self = new(self)
        self.X = 400; self.Y = 300;
        scrsz = get(0,'ScreenSize');
        % Initialize figure window
        figure('Name','Breakout',...
            'Numbertitle','off',...
            'Menubar','none',...
            'Pointer','custom',...
            'PointerShapeCData',zeros(16)*NaN,...
            'Color','k',...
            'Tag','Breakout',...
            'DoubleBuffer','on',...
            'Colormap',[0 0 0;1 1 1],...
            'Position',[(scrsz(3)-self.X)/2 (scrsz(4)-self.Y)/2 self.X self.Y]);
        % Create The axes
        axes('Units','Normalized',...
            'Position', [0 0 1 1],...
            'Visible','off',...
            'DrawMode','fast');
        axis([0,self.X,0,self.Y])
        self.ball = text(self.X/2,self.Y/2,'\bullet',...
            'Color','w',...
            'FontUnits','normalized',...
            'FontSize',.065,...
            'Visible','off',...
            'HorizontalAlignment','Center',...
            'VerticalAlignment','Middle');
        self.paddlePos = [self.X/4,0,self.X/6,self.Y/20];
        self.paddle = rectangle('Position',self.paddlePos,...
            'FaceColor','m');
        self.bricks = zeros(5,10);
        self.Sound = true;
        self.Speed = 10;
        set(self.ball,'Visible','on')
        delete(findobj(gcbf,'Tag','Bricks'))
        colors = 'rygcb';
        self.X = 400; self.Y = 300;
        for i=1:5
            for j=0:9
                self.bricks(i,j+1) = rectangle(...
                    'Position',[j*self.X/10,self.Y-self.Y/20*(2+i),self.X/10,self.Y/20],...
                    'Tag','Bricks',...
                    'FaceColor',colors(i));
            end
        end
        self.State = 1;
        self.Score = 0;
        self.ballX = self.X/2; self.ballY = self.Y/2; self.ballDX = 5; self.ballDY = -5;
        self.paddlePos = [self.X/4,0,self.X/6,self.Y/20];
       end
        function [self, paddle, ball, win, score, leftBound, rightBound] = update(self,dir)
                leftBound = 0;
                rightBound = 0;
                paddle = self.paddlePos(1);
                ball = [self.ballX,self.ballY];
                t0 = clock;
                win = 0;
                if self.State==1
                    if self.ballX<0
                        self.ballX = 0; 
                        self.ballDX = -self.ballDX;
                        if self.Sound,soundsc(sin(1:100),5000);end
                    elseif self.ballX>self.X
                        self.ballX = self.X; 
                        self.ballDX = -self.ballDX;
                        if self.Sound,soundsc(sin(1:100),5000);end
                    end
                    YPos = ceil(self.ballY/self.Y*20);
                    switch YPos
                        case 0 % Ball down the drain
                                self.State = 0;
                                if self.Sound,soundsc(sin(1:100),1000);end
                                win = -1;
                                score = self.Score;
                                return
                        case 1 % Ball in height of paddle
                            if self.ballX<self.paddlePos(1)+self.paddlePos(3) && self.ballX>self.paddlePos(1)
                                self.ballDY = -self.ballDY;
                                self.ballDX = (self.ballX-(self.paddlePos(1)+self.paddlePos(3)/2))/3;
                                if self.Sound,soundsc(sin(1:100),5000);end
                            end                  
                        case 21 % Ball hit ceiling
                            self.ballDY = -self.ballDY;
                            if self.Sound,soundsc(sin(1:100),5000);end                   
                        case {18 17 16 15 14} % Ball in height of bricks
                            YPos = 19-YPos;
                            if ismember(YPos,[1 2 3 4 5])
                                XPos = max(1,ceil(self.ballX/self.X*10));
                                if self.bricks(YPos,XPos)
                                    delete(self.bricks(YPos,XPos))
                                    self.bricks(YPos,XPos) = 0;
                                    self.ballDY = -self.ballDY;
                                    self.Score = self.Score+(6-YPos);
                                    if self.Sound,soundsc(sin(1:100),10000);end
                                    set(self.hScore,'String',sprintf(' Score: %i',self.Score))
                                    if isempty(find(self.bricks,1))
                                        close
                                        win = 1
                                        return
                                    end
                                end
                            end
                    end
                    % Move ball
                    self.ballX = self.ballX + self.ballDX;
                    self.ballY = self.ballY + self.ballDY;
                    set(self.ball,'Position',[self.ballX self.ballY])
                    if dir == 1
                        self.paddlePos(1) = self.paddlePos(1) + 20;
                    end
                    if dir == 2
                        self.paddlePos(1) = self.paddlePos(1) - 20;
                    end
                    set(self.paddle,'Position',self.paddlePos)
                    while etime(clock,t0)<1/self.Speed
                        drawnow
                    end
                else
                    pause(.1)
                end
                paddle = self.paddlePos(1);
                if paddle < 20
                    leftBound = 1;
                elseif paddle > 320
                    rightBound = 1;
                end
                ball = [self.ballX,self.ballY];
                score = self.Score;
                
        end
       end
end


