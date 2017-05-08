/* 
================================================================================
檔案代號:inbe_t
檔案名稱:庫存留置作業明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inbe_t
(
inbeent       number(5)      ,/* 企業編號 */
inbesite       varchar2(10)      ,/* 營運據點 */
inbedocno       varchar2(20)      ,/* 單據編號 */
inbeseq       number(10,0)      ,/* 項次 */
inbe001       varchar2(40)      ,/* 料件編號 */
inbe002       varchar2(256)      ,/* 產品特徵 */
inbe003       varchar2(30)      ,/* 庫存管理特徵 */
inbe004       varchar2(10)      ,/* 庫位 */
inbe005       varchar2(10)      ,/* 儲位 */
inbe006       varchar2(30)      ,/* 批號 */
inbe007       varchar2(10)      ,/* 庫存單位 */
inbe008       varchar2(10)      ,/* 原因碼 */
inbe009       varchar2(255)      ,/* 備註 */
inbeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inbeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inbeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inbeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inbeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inbeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inbeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inbeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inbeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inbeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inbeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inbeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inbeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inbeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inbeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inbeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inbeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inbeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inbeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inbeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inbeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inbeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inbeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inbeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inbeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inbeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inbeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inbeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inbeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inbeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inbe_t add constraint inbe_pk primary key (inbeent,inbedocno,inbeseq) enable validate;

create unique index inbe_pk on inbe_t (inbeent,inbedocno,inbeseq);

grant select on inbe_t to tiptop;
grant update on inbe_t to tiptop;
grant delete on inbe_t to tiptop;
grant insert on inbe_t to tiptop;

exit;
