CREATE TABLE tb_testcase (
	test_id varchar(37) NOT NULL,
	test_name varchar(100) NOT NULL,
	CONSTRAINT tb_testcase_pk PRIMARY KEY (test_id)
);

CREATE TABLE member_info(
    id varchar(20) Not NULL,
    pw varchar(100) Not NULL,
    name varchar(10) Not NULL,
    nickname varchar(15) Not NULL,
    email varchar(30) Not NULL,
    gender varchar(1) NOT NULL,
    birthday varchar(10) NOT NULL,
    login_token varchar(100) Not NULL,
    reg_id varchar(20) Not NULL,
    reg_date TIMESTAMP NOT NULL DEFAULT now(),
    upd_id varchar(20),
    upd_date TIMESTAMP,
    regist_path varchar(1) Not null,
    CONSTRAINT member_info_pk PRIMARY KEY (id)
);

CREATE SEQUENCE member_info_hst_seq;

CREATE TABLE member_info_hst(
    seq integer NOT NULL DEFAULT nextval('member_info_hst_seq'),
     id varchar(20) Not NULL,
    pw varchar(100) Not NULL,
    name varchar(10) Not NULL,
    nickname varchar(15) Not NULL,
    email varchar(30) Not NULL,
    gender varchar(1) NOT NULL,
    upd_status varchar(2) NOT NULL,
    reg_id varchar(20) Not NULL,
    reg_date TIMESTAMP NOT NULL DEFAULT now(),
    upd_id varchar(20),
    upd_date TIMESTAMP,
    CONSTRAINT member_info_hst_pk PRIMARY KEY (seq)
);

CREATE TABLE member_login_info(
    memb_id varchar(20) NOT NULL,
    last_login_mac_id varchar(100),
    last_login_date TIMESTAMP,
    login_fail_cnt integer default 0,
    mac_id_1 varchar(100),
    mac_id_2 varchar(100),
    mac_id_3 varchar(100),
    CONSTRAINT member_login_info_pk PRIMARY KEY (memb_id)
);

CREATE SEQUENCE member_login_hst_seq;

CREATE TABLE member_login_hst(
    seq integer NOT NULL default nextval('member_login_hst_seq'),
    memb_id varchar(20)  NOT NULL,
    mac_id varchar(100)  NOT NULL,
    login_ip varchar(20),
    login_date TIMESTAMP NOT NULL,
    login_location varchar(50),
    login_success_yn varchar(1) NOT NULL,
    CONSTRAINT member_login_hst_pk PRIMARY KEY (seq)
);