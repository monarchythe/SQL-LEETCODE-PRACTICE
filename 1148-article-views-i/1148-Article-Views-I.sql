# Write your MySQL query statement below

SELECT distinct author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id;


# Now 
-- weather we can do author_id = viewer_id in a single select query ?
-- OR WE NEED self join ? ! 

# The question is: did the author view their own article? 
-- That's just author_id = viewer_id on the same row. Both values sit in one row — nothing to join.

-- ANS. ----------->
-- --> The diagnostic to save you next time: before writing a join, ask "are the two values I'm comparing in the same row, or different rows?"

-- -->  Same row → WHERE col_a = col_b. No join.
-- -->  Different rows → join or window function.

-- --> "Author viewed their own article" = same row. "Employee earns more than their manager" = different rows, needs a self-join. That one question sorts most of these

#self join 
-- The engine does exactly one thing:

-- **** For every row in v1, scan every row in v2, and keep the pair if the ON condition is true ****

-- Two rules that fix most self-join confusion

-- Row count is multiplicative, not additive. If a key appears m times on the left and n times on the right, you get m × n rows for that key. Here it was 3 × 1 = 3, plus 1 × 1 = 1.
-- The condition is directional. v1.author_id = v2.viewer_id and v1.viewer_id = v2.author_id give completely different results. Always say out loud what you're asking: here it's "find rows where this article's author also appears as a viewer somewhere."