/* 
================================================================================
檔案代號:gzwg_t
檔案名稱:服務人員主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzwg_t
(
gzwgent       number(5)      ,/* 企業代碼 */
gzwgownid       varchar2(20)      ,/* 資料所有者 */
gzwgowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwgcrtid       varchar2(20)      ,/* 資料建立者 */
gzwgcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwgcrtdt       timestamp(0)      ,/* 資料創建日 */
gzwgmodid       varchar2(20)      ,/* 資料修改者 */
gzwgmoddt       timestamp(0)      ,/* 最近修改日 */
gzwgstus       varchar2(10)      ,/* 狀態碼 */
gzwg001       varchar2(10)      ,/* 營運據點 */
gzwg002       varchar2(20)      ,/* 服務人員 */
gzwg003       varchar2(10)      ,/* 聯絡對象類型 */
gzwg004       varchar2(20)      ,/* 服務人員編號 */
gzwgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzwgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzwgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzwgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzwgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzwgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzwgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzwgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzwgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzwgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzwgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzwgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzwgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzwgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzwgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzwgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzwgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzwgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzwgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzwgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzwgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzwgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzwgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzwgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzwgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzwgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzwgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzwgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzwgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzwgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzwg_t add constraint gzwg_pk primary key (gzwgent,gzwg001,gzwg002) enable validate;

create unique index gzwg_pk on gzwg_t (gzwgent,gzwg001,gzwg002);

grant select on gzwg_t to tiptop;
grant update on gzwg_t to tiptop;
grant delete on gzwg_t to tiptop;
grant insert on gzwg_t to tiptop;

exit;
