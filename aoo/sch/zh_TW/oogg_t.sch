/* 
================================================================================
檔案代號:oogg_t
檔案名稱:組別行事歷檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oogg_t
(
ooggent       number(5)      ,/* 企業編號 */
ooggstus       varchar2(10)      ,/* 狀態碼 */
oogg001       varchar2(10)      ,/* 組別編號 */
oogg002       date      ,/* 日期 */
oogg003       varchar2(10)      ,/* 班別編號 */
ooggownid       varchar2(20)      ,/* 資料所有者 */
ooggowndp       varchar2(10)      ,/* 資料所屬部門 */
ooggcrtid       varchar2(20)      ,/* 資料建立者 */
ooggcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooggcrtdt       timestamp(0)      ,/* 資料創建日 */
ooggmodid       varchar2(20)      ,/* 資料修改者 */
ooggmoddt       timestamp(0)      ,/* 最近修改日 */
ooggsite       varchar2(10)      ,/* 營運據點 */
ooggud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooggud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooggud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooggud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooggud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooggud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooggud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooggud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooggud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooggud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooggud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooggud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooggud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooggud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooggud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooggud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooggud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooggud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooggud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooggud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooggud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooggud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooggud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooggud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooggud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooggud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooggud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooggud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooggud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooggud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oogg_t add constraint oogg_pk primary key (ooggent,oogg001,oogg002,ooggsite) enable validate;

create unique index oogg_pk on oogg_t (ooggent,oogg001,oogg002,ooggsite);

grant select on oogg_t to tiptop;
grant update on oogg_t to tiptop;
grant delete on oogg_t to tiptop;
grant insert on oogg_t to tiptop;

exit;
