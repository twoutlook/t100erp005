/* 
================================================================================
檔案代號:apfg_t
檔案名稱:集團付款核銷單主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table apfg_t
(
apfgent       number(5)      ,/* 企業代碼 */
apfgdocno       varchar2(20)      ,/* 單號 */
apfgdocdt       date      ,/* 單據日期 */
apfgsite       varchar2(10)      ,/* 營運據點 */
apfgcomp       varchar2(10)      ,/* 法人 */
apfgld       varchar2(5)      ,/* 帳套 */
apfg001       varchar2(20)      ,/* 帳務人員 */
apfg002       varchar2(10)      ,/* 供應商代碼 */
apfgownid       varchar2(20)      ,/* 資料所有者 */
apfgowndp       varchar2(10)      ,/* 資料所屬部門 */
apfgcrtid       varchar2(20)      ,/* 資料建立者 */
apfgcrtdp       varchar2(10)      ,/* 資料建立部門 */
apfgcrtdt       timestamp(0)      ,/* 資料創建日 */
apfgmodid       varchar2(20)      ,/* 資料修改者 */
apfgmoddt       timestamp(0)      ,/* 最近修改日 */
apfgcnfid       varchar2(20)      ,/* 資料確認者 */
apfgcnfdt       timestamp(0)      ,/* 資料確認日 */
apfgpstid       varchar2(20)      ,/* 資料過帳者 */
apfgpstdt       timestamp(0)      ,/* 資料過帳日 */
apfgstus       varchar2(10)      ,/* 狀態碼 */
apfgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apfgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apfgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apfgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apfgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apfgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apfgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apfgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apfgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apfgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apfgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apfgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apfgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apfgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apfgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apfgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apfgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apfgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apfgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apfgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apfgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apfgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apfgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apfgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apfgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apfgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apfgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apfgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apfgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apfgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table apfg_t add constraint apfg_pk primary key (apfgent,apfgdocno) enable validate;

create unique index apfg_pk on apfg_t (apfgent,apfgdocno);

grant select on apfg_t to tiptop;
grant update on apfg_t to tiptop;
grant delete on apfg_t to tiptop;
grant insert on apfg_t to tiptop;

exit;
