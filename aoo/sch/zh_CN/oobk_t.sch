/* 
================================================================================
檔案代號:oobk_t
檔案名稱:單據別庫存標籤To限定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table oobk_t
(
oobkent       number(5)      ,/* 企業編號 */
oobk001       varchar2(5)      ,/* 參照表號 */
oobk002       varchar2(5)      ,/* 單據別 */
oobk003       varchar2(10)      ,/* 庫存標籤編號 */
oobkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oobkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oobkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oobkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oobkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oobkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oobkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oobkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oobkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oobkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oobkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oobkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oobkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oobkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oobkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oobkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oobkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oobkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oobkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oobkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oobkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oobkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oobkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oobkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oobkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oobkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oobkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oobkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oobkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oobkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oobk_t add constraint oobk_pk primary key (oobkent,oobk001,oobk002,oobk003) enable validate;

create unique index oobk_pk on oobk_t (oobkent,oobk001,oobk002,oobk003);

grant select on oobk_t to tiptop;
grant update on oobk_t to tiptop;
grant delete on oobk_t to tiptop;
grant insert on oobk_t to tiptop;

exit;
