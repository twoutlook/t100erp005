/* 
================================================================================
檔案代號:imbm_t
檔案名稱:料件申請料號國際認證編號檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imbm_t
(
imbment       number(5)      ,/* 企業編號 */
imbm001       varchar2(40)      ,/* 料件編號 */
imbm002       varchar2(10)      ,/* 認證類別 */
imbm003       varchar2(40)      ,/* 認證編號 */
imbmdocno       varchar2(20)      ,/* 申請單號 */
imbm004       varchar2(255)      ,/* 補充說明 */
imbm005       varchar2(255)      ,/* 認證單位 */
imbm006       date      ,/* 認證日期 */
imbmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imbmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imbmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imbmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imbmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imbmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imbmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imbmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imbmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imbmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imbmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imbmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imbmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imbmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imbmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imbmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imbmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imbmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imbmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imbmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imbmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imbmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imbmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imbmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imbmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imbmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imbmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imbmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imbmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imbmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imbm_t add constraint imbm_pk primary key (imbment,imbm002,imbmdocno) enable validate;

create  index imbm_01 on imbm_t (imbm001);
create  index imbm_02 on imbm_t (imbm003);
create unique index imbm_pk on imbm_t (imbment,imbm002,imbmdocno);

grant select on imbm_t to tiptop;
grant update on imbm_t to tiptop;
grant delete on imbm_t to tiptop;
grant insert on imbm_t to tiptop;

exit;
