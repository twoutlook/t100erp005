/* 
================================================================================
檔案代號:isbc_t
檔案名稱:發票收款沖銷明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table isbc_t
(
isbcent       number(5)      ,/* 企業編碼 */
isbccomp       varchar2(10)      ,/* 法人 */
isbcdocno       varchar2(20)      ,/* 收款單號 */
isbcseq       number(10,0)      ,/* 項次 */
isbc001       varchar2(20)      ,/* 發票代碼 */
isbc002       varchar2(20)      ,/* 發票號碼 */
isbc003       number(20,6)      ,/* 發票未收含稅金額 */
isbc103       number(20,6)      ,/* 收款原幣金額 */
isbc104       number(20,6)      ,/* 收款本幣金額 */
isbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isbcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
isbc004       varchar2(20)      /* 開票單號 */
);
alter table isbc_t add constraint isbc_pk primary key (isbcent,isbccomp,isbcdocno,isbcseq) enable validate;

create unique index isbc_pk on isbc_t (isbcent,isbccomp,isbcdocno,isbcseq);

grant select on isbc_t to tiptop;
grant update on isbc_t to tiptop;
grant delete on isbc_t to tiptop;
grant insert on isbc_t to tiptop;

exit;
