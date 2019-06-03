-- Joins
-- 1
select *
from invoice join invoice_line on (invoice.invoice_id = invoice_line.invoice_id)
where invoice_line.unit_price > 0.99;

-- 2
select invoice_date, customer.first_name, customer.last_name, total
from invoice
    join customer on (invoice.customer_id = customer.customer_id);

-- 3
select customer.first_name, customer.last_name, employee.first_name, employee.last_name
from customer
    join employee on (customer.support_rep_id = employee.employee_id);

-- 4
select title, artist.name
from album
    join artist on (album.artist_id = artist.artist_id);

-- 5
select track_id
from playlist
    join playlist_track on (playlist.playlist_id = playlist_track.playlist_id)
where name = 'Music';

-- 6
select track.name
from playlist
    join playlist_track on (playlist.playlist_id = playlist_track.playlist_id)
    join track on (playlist_track.track_id = track.track_id)
where playlist.playlist_id = 5;

--7
select playlist.name, track.name
from playlist
    join playlist_track on (playlist.playlist_id = playlist_track.playlist_id)
    join track on (playlist_track.track_id = track.track_id);

--8
select track.name, album.title
from track
    join album on (track.album_id = album.album_id)
    join genre on (track.genre_id = genre.genre_id)
where genre.name = 'Alternative & Punk';

-- BD
select track.name, album.title, genre.name, artist.name
from playlist_track
    join playlist on (playlist.playlist_id = playlist_track.playlist_id)
    join track on (playlist_track.track_id = track.track_id)
    join album on (track.album_id = album.album_id)
    join artist on (album.artist_id = artist.artist_id)
    join genre on (track.genre_id = genre.genre_id)
where playlist.name = 'Music';

-- Nested Queries
--1
select *
from invoice
where invoice_id in ( select invoice_id
from invoice_line
where unit_price > 0.99);

--2
select *
from playlist_track
where playlist_id in (select playlist_id
from playlist
where name = 'Music');

--3
select name
from track
where track_id in (select track_id
from playlist_track
where playlist_id = 5);

--4
select *
from track
where genre_id in (select genre_id
from genre
where name  = 'Comedy');

--5
select *
from track
where album_id in (select album_id
from album
where name  = 'Fireball');

--6
select *
from track
where album_id in (select album_id
from album
where 
artist_id in (select artist_id
from artist
where name = 'Queen'));

--Rows
--1
update customer
set fax = null;

--2
update customer
set company = 'Self'
where company is null;

--3
update customer
set last_name = 'Thompson'
where first_name = 'Julia'
    and last_name = 'Barnett';

--4
update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';

--5
update track
set composer = 'The darkness around us'
where genre_id in (select genre_id
    from genre
    where name = 'Metal')
    and composer is null;

-- Group by
--1
select count(*), genre.name
from track
    join genre on (track.genre_id = genre.genre_id)
group by genre.name;

--2
select count(*), genre.name
from track
    join genre on (track.genre_id = genre.genre_id)
where genre.name = 'Pop' or genre.name = 'Rock'
group by genre.name;

--3
select count(*), artist.name
from album
    join artist on (album.artist_id = artist.artist_id)
group by artist.name;

--Use Distinct
--1
select distinct composer
from track;

--2
select distinct billing_postal_code
from invoice;

--3
select distinct company
from customer;

--Delete Rows
--1
delete from practice_delete
where type = 'bronze';

--2
delete from practice_delete
where type = 'silver';

--3
delete from practice_delete
where value = 150;

--eCommerce Sim
create table use
(
    use_id serial primary key,
    name text,
    email text
);

create table product
(
    product_id serial primary key,
    name text,
    price int
);

create table orders
(
    order_id serial primary key,
    product_id int references product(product_id)
);

-- forgot to copy inserts from use

insert into product
    (name, price)
values
    ('samich', 4);
insert into product
    (name, price)
values
    ('eggs', 2);
insert into product
    (name, price)
values('unfridgerator', 600);

insert into orders
    (product_id)
values
    (4);
insert into orders
    (product_id)
values(5);
insert into orders
    (product_id)
values(6);

select *
from orders
    join product on (orders.product_id = product.product_id)
where order_id = 1;


select *
from orders;

select count(*)
from orders
    join product on (orders.product_id = product.product_id)
where order_id = 1
group by product.price;

alter table orders add column use_id int references
use
(use_id);

update orders
set use_id = 1
where order_id = 1;
update orders
set use_id = 2
where order_id = 2;
update orders
set use_id = 3
where order_id = 3;

select order_id
from
use
join orders on
(
use.use_id = orders.use_id)
where
use.use_id = 1;

select count(*), name
from
use
join orders on
(
use.use_id = orders.use_id)
group by
use.use_id;

select product.price, 
use.name from
use
join orders on
(
use.use_id = orders.use_id)
join product on
(orders.product_id = product.product_id);