/* 
================================================================================
檔案代號:sfec_t
檔案名稱:完工入庫明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table sfec_t
(
sfecent       number(5)      ,/* 企業編號 */
sfecsite       varchar2(10)      ,/* 營運據點 */
sfecdocno       varchar2(20)      ,/* 單號 */
sfecseq       number(10,0)      ,/* 項次 */
sfecseq1       number(10,0)      ,/* 項次1 */
sfec001       varchar2(20)      ,/* 工單單號 */
sfec002       varchar2(20)      ,/* FQC單號 */
sfec003       number(10,0)      ,/* 判定項次 */
sfec004       varchar2(10)      ,/* 入庫類型 */
sfec005       varchar2(40)      ,/* 料件編號 */
sfec006       varchar2(256)      ,/* 特徵 */
sfec007       varchar2(40)      ,/* 包裝容器 */
sfec008       varchar2(10)      ,/* 單位 */
sfec009       number(20,6)      ,/* 數量 */
sfec010       varchar2(10)      ,/* 參考單位 */
sfec011       number(20,6)      ,/* 參考數量 */
sfec012       varchar2(10)      ,/* 庫位 */
sfec013       varchar2(10)      ,/* 儲位 */
sfec014       varchar2(30)      ,/* 批號 */
sfec015       varchar2(30)      ,/* 庫存管理特徵 */
sfec016       date      ,/* 有效日期 */
sfec017       varchar2(4000)      ,/* 庫存備註 */
sfec018       varchar2(40)      ,/* 生產料號 */
sfec019       varchar2(30)      ,/* 生產料號BOM特性 */
sfec020       varchar2(256)      ,/* 生產料號產品特徵 */
sfec021       number(10,0)      ,/* RUN CARD */
sfecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfecud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
sfec022       varchar2(20)      ,/* 專案編號 */
sfec023       varchar2(30)      ,/* WBS */
sfec024       varchar2(30)      /* 活動編號 */
);
alter table sfec_t add constraint sfec_pk primary key (sfecent,sfecdocno,sfecseq,sfecseq1) enable validate;

create unique index sfec_pk on sfec_t (sfecent,sfecdocno,sfecseq,sfecseq1);

grant select on sfec_t to tiptop;
grant update on sfec_t to tiptop;
grant delete on sfec_t to tiptop;
grant insert on sfec_t to tiptop;

exit;
