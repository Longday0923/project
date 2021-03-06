-- entities
-- User
create table Users(
	uid varchar(9) primary key,
	Nickname varchar(20) not null,
	Gender varchar(7) default 'unknown',check (Gender in ('male','female','unknown')),
	Signup_date date not null,
	VIP bool default false
);

--zones
create table zones(
	zone_id varchar(2) primary key,
	zone_name varchar(10) not null
);

--admin 
create table admins(
	aid varchar(9) primary key,
	Aname varchar(20) not null,
	Aemail varchar(30) not null
);


-- Works
create table works(
	AV varchar(9) primary key,
	diy bool default true,
	Works_create_date timestamp not null,
	VIP_limit bool default false
);

-- vip
create table vip(
	vip_type varchar(2) primary key,
	vip_length int,
	vip_price numeric(4,0)
);

-- posts
create table posts(
	post_id varchar(9) primary key,
	post_date timestamp not null,
	post_type bool default true,
	post_content varchar(30) not null
);

-- relations
-- upload
create table uploads(
	av varchar(9) references works on delete cascade,
	uid varchar(9) references users on delete cascade,
	upload_date timestamp not null,
	primary key (av , uid)
);
-- collection 
create table collection(
	av varchar(9) references works on delete cascade,
	uid varchar(9) references users on delete cascade,
	collection_date timestamp not null,
	primary key (av , uid)
);

--subscribe 
create table subscribe(
	av varchar(9) references works on delete cascade,
	uid varchar(9) references users on delete cascade,
	subscribe_date timestamp not null,
	primary key (av , uid)
);

--play
create table play(
	av varchar(9) references works on delete cascade,
	uid varchar(9) references users on delete no action,
	play_date timestamp not null,
	play_state numeric(2,2) default 0,
	primary key(av, uid,play_date)
);

-- likes
create table likes(
	av varchar(9) references works on delete cascade,
	uid varchar(9) references users on delete no action,
	like_date timestamp not null,
	primary key (av , uid)
);

-- coins 
create table coins(
	av varchar(9) references works on delete no action,
	uid varchar(9) references users on delete no action,
	coins_date timestamp not null,
	coins_num numeric(1,0) default 1,
	primary key (av , uid)
);

--follow: UID1 follows UID2
--follow_date should be restrain by checkin_date of both UID1 & UID2
create table follow(
	UID1 varchar(9) references users on delete cascade,
	UID2 varchar(9) references users on delete cascade,
	follow_date timestamp not null,
	primary key (UID1,UID2)
);

--Danmaku
create table Danmaku(
	av varchar(9) references works on delete cascade,
	uid varchar(9) references users on delete no action,
	Dan_create_date timestamp not null,
	time_stamp time not null,
	Dan_level int default'1',check (Dan_level in ('1','2','3')),
	dan_content  varchar(50),
	primary key (av , uid,Dan_create_date)
);



--posts comment
create table posts_comment(
	uid varchar(9) references users on delete no action,
	post_id varchar(9) references posts(post_id) on delete cascade,
	post_comment_content varchar(40) not null,
	Post_comment_date timestamp not null,
	primary key (post_id,Post_comment_date)
);


--works_comment
create table works_comment(
	uid varchar(9) references users on delete no action,
	av varchar(9) references works on delete cascade,
	works_comment_content varchar(40) not null,
	works_comment_date timestamp not null,
	primary key (av,works_comment_date)
);


-- shares
create table shares(
	uid varchar(9) references users on delete no action,
	av varchar(9) references works on delete cascade,
	share_date timestamp not null,
	share_destin varchar(20) not null,
	primary key(av,share_date,uid)
);


-- posting 
create table posting(
	post_id varchar(9) references posts(post_id) on delete cascade,
	uid varchar(9) references users on delete no action,
	posting_date timestamp not null,
	primary key(post_id)
);

--works_zones
create table works_zones(
	av varchar(9) references works on delete cascade,
	zone_id varchar(2) references zones on delete set null on update cascade,
	primary key (av)
);

--become_vip
create table become_vip(
	uid varchar(9) references users on delete no action,
	vip_signup_date timestamp not null ,
	vip_type varchar(2) references vip on delete set null on update cascade,
	primary key(uid,vip_signup_date)
);

--admin_zones
create table admin_zones(
	aid varchar(9) references admins on delete cascade,
	zone_id varchar(2) references zones on delete set null on update cascade,
	primary key(aid)
);

-- examines
create table examines(
	aid varchar(9) references admins on delete no action,
	av varchar(9) references works on delete no action,
	primary key (av)
);
