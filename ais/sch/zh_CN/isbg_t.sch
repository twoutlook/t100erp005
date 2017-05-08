/* 
================================================================================
檔案代號:isbg_t
檔案名稱:換開發票來源檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table isbg_t
(
isbgent       number(5)      ,/* 企業代碼 */
isbgcomp       varchar2(10)      ,/* 法人 */
isbgdocno       varchar2(20)      ,/* 異動單號 */
isbgseq       number(10,0)      ,/* 項次 */
isbg001       varchar2(20)      ,/* 發票代碼 */
isbg002       varchar2(20)      ,/* 發票號碼 */
isbg003       varchar2(10)      ,/* 發票狀態 */
isbgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isbgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isbgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isbgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isbgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isbgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isbgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isbgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isbgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isbgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isbgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isbgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isbgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isbgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isbgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isbgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isbgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isbgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isbgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isbgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isbgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isbgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isbgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isbgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isbgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isbgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isbgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isbgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isbgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isbgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isbg_t add constraint isbg_pk primary key (isbgent,isbgcomp,isbgdocno,isbgseq) enable validate;

create unique index isbg_pk on isbg_t (isbgent,isbgcomp,isbgdocno,isbgseq);

grant select on isbg_t to tiptop;
grant update on isbg_t to tiptop;
grant delete on isbg_t to tiptop;
grant insert on isbg_t to tiptop;

exit;
