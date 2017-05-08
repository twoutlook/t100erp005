/* 
================================================================================
檔案代號:inbh_t
檔案名稱:庫存異常變更明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inbh_t
(
inbhent       number(5)      ,/* 企業編號 */
inbhsite       varchar2(10)      ,/* 營運據點 */
inbhdocno       varchar2(20)      ,/* 單據編號 */
inbhseq       number(10,0)      ,/* 項次 */
inbhseq1       number(10,0)      ,/* 項序 */
inbh001       varchar2(10)      ,/* 變更類型 */
inbh002       varchar2(40)      ,/* 料件編號 */
inbh003       varchar2(10)      ,/* 庫位 */
inbh004       varchar2(10)      ,/* 儲位 */
inbh005       varchar2(256)      ,/* 變更前-產品特徵 */
inbh006       varchar2(30)      ,/* 變更前-庫存管理特徵 */
inbh007       varchar2(30)      ,/* 變更前-批號 */
inbh008       varchar2(10)      ,/* 變更前-庫存單位 */
inbh011       varchar2(256)      ,/* 變更後-產品特徵 */
inbh012       varchar2(30)      ,/* 變更後-庫存管理特徵 */
inbh013       varchar2(30)      ,/* 變更後-批號 */
inbh014       varchar2(10)      ,/* 變更後-庫存單位 */
inbh017       number(20,6)      ,/* 變更數量 */
inbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inbhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inbh_t add constraint inbh_pk primary key (inbhent,inbhdocno,inbhseq,inbhseq1) enable validate;

create unique index inbh_pk on inbh_t (inbhent,inbhdocno,inbhseq,inbhseq1);

grant select on inbh_t to tiptop;
grant update on inbh_t to tiptop;
grant delete on inbh_t to tiptop;
grant insert on inbh_t to tiptop;

exit;
