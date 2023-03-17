update articles set source_ = case
    when aid = 1 then 'habr.com'
    when aid = 2 then 'habr.com'
    when aid = 3 then 'stackoverflow.com'
    when aid = 4 then 'stackoverflow.com'
    when aid = 5 then 'github.com'
    when aid = 6 then 'github.com'
end;