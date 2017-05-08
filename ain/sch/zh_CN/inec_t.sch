/* 
================================================================================
檔案代號:inec_t
檔案名稱:盤點範圍資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inec_t
(
inecent       number(5)      ,/* 企業編號 */
inecdocno       varchar2(20)      ,/* 盤點計劃單號 */
inec001       number(10,0)      ,/* 組別 */
inec002       varchar2(10)      ,/* 屬性 */
inec003       varchar2(40)      ,/* 屬性代碼 */
inecstus       varchar2(1)      ,/* 狀態 */
inecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inecud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inec_t add constraint inec_pk primary key (inecent,inecdocno,inec001,inec002,inec003) enable validate;

create unique index inec_pk on inec_t (inecent,inecdocno,inec001,inec002,inec003);

grant select on inec_t to tiptop;
grant update on inec_t to tiptop;
grant delete on inec_t to tiptop;
grant insert on inec_t to tiptop;

exit;
