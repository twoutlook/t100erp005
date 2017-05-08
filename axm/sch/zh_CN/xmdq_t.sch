/* 
================================================================================
檔案代號:xmdq_t
檔案名稱:訂單附屬零件明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmdq_t
(
xmdqent       number(5)      ,/* 企業編號 */
xmdqsite       varchar2(10)      ,/* 營運據點 */
xmdqdocno       varchar2(20)      ,/* 訂單單號 */
xmdqseq       number(10,0)      ,/* 項次 */
xmdqseq1       number(10,0)      ,/* 項序 */
xmdq001       varchar2(40)      ,/* 附屬零件料號 */
xmdq002       varchar2(40)      ,/* 主件料號 */
xmdq003       varchar2(10)      ,/* 部位編號 */
xmdq004       varchar2(10)      ,/* 作業編號 */
xmdq005       varchar2(10)      ,/* 作業序 */
xmdq006       number(20,6)      ,/* 組成用量 */
xmdq007       number(20,6)      ,/* 主件底數 */
xmdq008       varchar2(10)      ,/* 單位 */
xmdq009       number(20,6)      ,/* 需求數量 */
xmdq010       number(20,6)      ,/* 標準組成用量 */
xmdq011       number(20,6)      ,/* 標準主件底數 */
xmdqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdqud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmdq012       varchar2(10)      /* 子件特性 */
);
alter table xmdq_t add constraint xmdq_pk primary key (xmdqent,xmdqdocno,xmdqseq,xmdqseq1) enable validate;

create unique index xmdq_pk on xmdq_t (xmdqent,xmdqdocno,xmdqseq,xmdqseq1);

grant select on xmdq_t to tiptop;
grant update on xmdq_t to tiptop;
grant delete on xmdq_t to tiptop;
grant insert on xmdq_t to tiptop;

exit;
