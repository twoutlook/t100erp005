/* 
================================================================================
檔案代號:mhbb_t
檔案名稱:場地申請明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mhbb_t
(
mhbbent       number(5)      ,/* 企業編號 */
mhbbsite       varchar2(10)      ,/* 營運據點 */
mhbbunit       varchar2(10)      ,/* 制定組織 */
mhbbdocno       varchar2(20)      ,/* 單據編號 */
mhbb001       varchar2(10)      ,/* 樓棟編號 */
mhbb002       varchar2(10)      ,/* 樓層編號 */
mhbb003       varchar2(10)      ,/* 區域編號 */
mhbb004       varchar2(20)      ,/* 場地編號 */
mhbb005       number(20,6)      ,/* 建築面積 */
mhbb006       number(20,6)      ,/* 測量面積 */
mhbb007       number(20,6)      ,/* 經營面積 */
mhbb008       varchar2(10)      ,/* 場地使用狀態 */
mhbb009       number(5,0)      ,/* 場地版本 */
mhbb010       varchar2(10)      ,/* 場地等級 */
mhbbacti       varchar2(1)      ,/* 資料有效碼 */
mhbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhbbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mhbb_t add constraint mhbb_pk primary key (mhbbent,mhbbdocno,mhbb004) enable validate;

create unique index mhbb_pk on mhbb_t (mhbbent,mhbbdocno,mhbb004);

grant select on mhbb_t to tiptop;
grant update on mhbb_t to tiptop;
grant delete on mhbb_t to tiptop;
grant insert on mhbb_t to tiptop;

exit;
