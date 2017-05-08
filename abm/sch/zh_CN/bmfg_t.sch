/* 
================================================================================
檔案代號:bmfg_t
檔案名稱:ECN損耗率檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfg_t
(
bmfgent       number(5)      ,/* 企業編號 */
bmfgsite       varchar2(10)      ,/* 營運據點 */
bmfgdocno       varchar2(20)      ,/* ECN單號 */
bmfg002       number(10,0)      ,/* 項次 */
bmfg003       number(20,6)      ,/* 生產起始量 */
bmfg004       number(20,6)      ,/* 生產截止量 */
bmfg005       number(20,6)      ,/* 變動損耗率 */
bmfg006       number(20,6)      ,/* 固定損耗量 */
bmfgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfg_t add constraint bmfg_pk primary key (bmfgent,bmfgsite,bmfgdocno,bmfg002,bmfg003) enable validate;

create unique index bmfg_pk on bmfg_t (bmfgent,bmfgsite,bmfgdocno,bmfg002,bmfg003);

grant select on bmfg_t to tiptop;
grant update on bmfg_t to tiptop;
grant delete on bmfg_t to tiptop;
grant insert on bmfg_t to tiptop;

exit;
