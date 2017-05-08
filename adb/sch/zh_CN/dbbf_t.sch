/* 
================================================================================
檔案代號:dbbf_t
檔案名稱:庫存組織出貨範圍設定-銷售區域範圍
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table dbbf_t
(
dbbfent       number(5)      ,/* 企業編號 */
dbbfsite       varchar2(10)      ,/* 營運據點 */
dbbf001       varchar2(10)      ,/* 庫位編號 */
dbbf002       varchar2(10)      ,/* 層級類型 */
dbbf003       varchar2(10)      ,/* 銷售區域編碼 */
dbbfownid       varchar2(20)      ,/* 資料所有者 */
dbbfowndp       varchar2(10)      ,/* 資料所屬部門 */
dbbfcrtid       varchar2(20)      ,/* 資料建立者 */
dbbfcrtdp       varchar2(10)      ,/* 資料建立部門 */
dbbfcrtdt       timestamp(0)      ,/* 資料創建日 */
dbbfmodid       varchar2(20)      ,/* 資料修改者 */
dbbfmoddt       timestamp(0)      ,/* 最近修改日 */
dbbfstus       varchar2(10)      ,/* 狀態碼 */
dbbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbbf_t add constraint dbbf_pk primary key (dbbfent,dbbfsite,dbbf001,dbbf002,dbbf003) enable validate;

create unique index dbbf_pk on dbbf_t (dbbfent,dbbfsite,dbbf001,dbbf002,dbbf003);

grant select on dbbf_t to tiptop;
grant update on dbbf_t to tiptop;
grant delete on dbbf_t to tiptop;
grant insert on dbbf_t to tiptop;

exit;
