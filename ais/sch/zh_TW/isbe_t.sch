/* 
================================================================================
檔案代號:isbe_t
檔案名稱:發票認證紀錄單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table isbe_t
(
isbeent       number(5)      ,/* 企業編碼 */
isbecomp       varchar2(10)      ,/* 法人 */
isbedocno       varchar2(20)      ,/* 單據單號 */
isbesite       varchar2(10)      ,/* 營運據點 */
isbeseq       number(10,0)      ,/* 項次 */
isbe001       varchar2(10)      ,/* 發票代碼 */
isbe002       varchar2(10)      ,/* 發票號碼 */
isbe003       date      ,/* 發票日期 */
isbe004       varchar2(20)      ,/* 銷方稅號 */
isbe005       number(20,6)      ,/* 未稅 */
isbe006       number(20,6)      ,/* 稅額 */
isbe007       date      ,/* 認證日期 */
isbe008       varchar2(40)      ,/* 認證結果 */
isbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isbe_t add constraint isbe_pk primary key (isbeent,isbecomp,isbedocno,isbeseq) enable validate;

create unique index isbe_pk on isbe_t (isbeent,isbecomp,isbedocno,isbeseq);

grant select on isbe_t to tiptop;
grant update on isbe_t to tiptop;
grant delete on isbe_t to tiptop;
grant insert on isbe_t to tiptop;

exit;
