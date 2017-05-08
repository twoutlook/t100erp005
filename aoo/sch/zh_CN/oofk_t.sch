/* 
================================================================================
檔案代號:oofk_t
檔案名稱:編碼轉換單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oofk_t
(
oofkent       number(5)      ,/* 企業編號 */
oofk001       varchar2(10)      ,/* 轉換表號 */
oofk002       varchar2(10)      ,/* 輸入值 */
oofk003       number(15,3)      ,/* 數值(From) */
oofk004       number(15,3)      ,/* 數值(To) */
oofk005       varchar2(10)      ,/* 轉換值 */
oofkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oofkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oofkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oofkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oofkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oofkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oofkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oofkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oofkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oofkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oofkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oofkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oofkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oofkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oofkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oofkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oofkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oofkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oofkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oofkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oofkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oofkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oofkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oofkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oofkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oofkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oofkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oofkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oofkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oofkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oofk_t add constraint oofk_pk primary key (oofkent,oofk001,oofk002,oofk003,oofk004) enable validate;

create  index oofk_01 on oofk_t (oofk001,oofk002);
create  index oofk_02 on oofk_t (oofk001,oofk003,oofk004);
create unique index oofk_pk on oofk_t (oofkent,oofk001,oofk002,oofk003,oofk004);

grant select on oofk_t to tiptop;
grant update on oofk_t to tiptop;
grant delete on oofk_t to tiptop;
grant insert on oofk_t to tiptop;

exit;
