function [userdata,direction] = had(position,arena,userdata)
[m,n]=size(arena);

if(isfield(userdata,'smer')==0)
	userdata.smer=1;
end

minrange=10000;
for x = 1:m
	for y = 1:n
    	if arena(x,y)==7
        	range=abs(position(2)-x)+abs(position(1)-y);
        	if range<minrange
            	minrange=range;
            	minx=x;
            	miny=y;
        	end
    	end
	end
end
apple = [minx, miny];
if position(1) > apple(2)
    	volno(1);
elseif position(1) < apple(2)
    	volno(3);
else
	if position(2) > apple(1)
    	volno(2);
	elseif position(2) < apple(1)
    	volno(4);
	end
end
end


function smer = volno(smer)
	b=position(1);
	a=position(2);
	for i = 1:4
    	switch smer
        	case 1
            	if arena(a,b-1)==1||arena(a,b-1)==7
                	direction = 1;
                	break;
            	else
                	smer = 2;
            	end
        	case 2
            	if arena(a-1,b)==1||arena(a-1,b)==7
                	direction = 2;
                	break;
            	else
                	smer = 3;
            	end
        	case 3
            	if arena(a,b+1)==1||arena(a,b+1)==7
                	direction = 3;
                	break;
            	else
                	smer = 4;
            	end
        	case 4
            	if arena(a+1,b)==1||arena(a+1,b)==7
                	direction = 4;
                	break;
            	else
                	smer = 1;
            	end
    	end
    end
end

function [snakes, apples] = getInfo(arena)
[m, n] = size(arena);
apples = zeros(5, 2);
snakes = zeros(5, 1, 2);
i = 1;
l = 1;
for x = 1:m
	for y = 1:n
    	if arena(x, y) == 7
           apples(i, 1) = x;
           apples(i, 2) = y;
           i = i + 1;
        elseif arena(x, y) ~= 7
            snakes(l) = getSnake([x, y], arena);
            l = l + 1;
        end
	end
end
end

function [snake] = getSnake(startingPoint, arena)
snakeNum = arena(startingPoint(1), startingPoint(2));
currPos = startingPoint;
oldPos = currPos;
while true
   if arena(currPos(1)+1, currPos(2)) == snakeNum
       wantPos = [currPos(1)+1, currPos(2)];
   elseif arena(currPos(1)-1, currPos(2)) == snakeNum
       wantPos = [currPos(1)-1, currPos(2)];
   elseif arena(currPos(1), currPos(2)+1) == snakeNum
       wantPos = [currPos(1), currPos(2)+1];
   elseif arena(currPos(1), currPos(2)-1) == snakeNum
       wantPos = [currPos(1), currPos(2)-1];
   else
       break
   end
   oldPos = currPos;
   if oldPos == wantPos
       break
   else
       currPos = wanrPos;
   end
end


i = 1;
oldPos = currPos;
while true
   if arena(currPos(1)+1, currPos(2)) == snakeNum
       wantPos = [currPos(1)+1, currPos(2)];
   elseif arena(currPos(1)-1, currPos(2)) == snakeNum
       wantPos = [currPos(1)-1, currPos(2)];
   elseif arena(currPos(1), currPos(2)+1) == snakeNum
       wantPos = [currPos(1), currPos(2)+1];
   elseif arena(currPos(1), currPos(2)-1) == snakeNum
       wantPos = [currPos(1), currPos(2)-1];
   else
       break
   end
   oldPos = currPos;
   if oldPos == wantPos
       break
   else
       snake(i) = currPos;
       currPos = wantPos;
       i = i + 1;
   end
end
end

