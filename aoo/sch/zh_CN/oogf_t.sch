/* 
================================================================================
檔案代號:oogf_t
檔案名稱:組別成員檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oogf_t
(
oogfent       number(5)      ,/* 企業編號 */
oogfstus       varchar2(10)      ,/* 狀態碼 */
oogf001       varchar2(10)      ,/* 組別編號 */
oogf002       varchar2(20)      ,/* 員工編號 */
oogf003       date      ,/* 生效日期 */
oogf004       date      ,/* 失效日期 */
oogfsite       varchar2(10)      ,/* 營運據點 */
oogfownid       varchar2(20)      ,/* 資料所有者 */
oogfowndp       varchar2(10)      ,/* 資料所屬部門 */
oogfcrtid       varchar2(20)      ,/* 資料建立者 */
oogfcrtdp       varchar2(10)      ,/* 資料建立部門 */
oogfcrtdt       timestamp(0)      ,/* 資料創建日 */
oogfmodid       varchar2(20)      ,/* 資料修改者 */
oogfmoddt       timestamp(0)      ,/* 最近修改日 */
oogfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oogfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oogfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oogfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oogfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oogfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oogfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oogfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oogfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oogfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oogfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oogfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oogfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oogfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oogfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oogfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oogfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oogfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oogfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oogfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oogfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oogfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oogfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oogfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oogfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oogfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oogfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oogfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oogfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oogfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oogf_t add constraint oogf_pk primary key (oogfent,oogf001,oogf002,oogfsite) enable validate;

create unique index oogf_pk on oogf_t (oogfent,oogf001,oogf002,oogfsite);

grant select on oogf_t to tiptop;
grant update on oogf_t to tiptop;
grant delete on oogf_t to tiptop;
grant insert on oogf_t to tiptop;

exit;
