SELECT g.id, COUNT(m.id) FROM Game g 
NATURAL JOINS Matches m
GROUP BY g.id;