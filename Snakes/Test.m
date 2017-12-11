function [userdata,direction] = had(position,arena,userdata)
direction = 2;
%[m,n]=size(arena);
display(getInfo(arena));
end

function [snake] = getSnake(startingPoint, arena)
snake = zeros(1, 2);
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
       currPos = wantPos;
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
return;
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
        elseif arena(x, y) ~= 1
            snakes(l) = getSnake([x, y], arena);
            l = l + 1;
        end
	end
end
end

