function [userdata,direction] = Snakes1(position,arena,userdata)
[m,n]=size(arena);
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
	direction = 1;
elseif position(1) < apple(2)
	direction = 3;
else
	if position(2) > apple(1)
    	direction = 2;
	elseif position(2) < apple(1)
    	direction = 4;
	end
end
end

