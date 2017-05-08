/* 
================================================================================
檔案代號:xreg_t
檔案名稱:重評價帳務主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xreg_t
(
xregent       number(5)      ,/* 企業代碼 */
xregcomp       varchar2(10)      ,/* 法人 */
xregsite       varchar2(10)      ,/* 帳務中心 */
xregdocno       varchar2(20)      ,/* 單據號碼 */
xregdocdt       date      ,/* 單據日期 */
xregld       varchar2(5)      ,/* 帳別 */
xreg001       number(5,0)      ,/* 年度 */
xreg002       number(5,0)      ,/* 期別 */
xreg003       varchar2(10)      ,/* 來源模組 */
xreg004       varchar2(20)      ,/* 帳務人員 */
xreg005       varchar2(20)      ,/* 傳票號碼 */
xregstus       varchar2(10)      ,/* 狀態碼 */
xregownid       varchar2(20)      ,/* 資料所有者 */
xregowndp       varchar2(10)      ,/* 資料所屬部門 */
xregcrtid       varchar2(20)      ,/* 資料建立者 */
xregcrtdp       varchar2(10)      ,/* 資料建立部門 */
xregcrtdt       timestamp(0)      ,/* 資料創建日 */
xregmodid       varchar2(20)      ,/* 資料修改者 */
xregmoddt       timestamp(0)      ,/* 最近修改日 */
xregcnfid       varchar2(20)      ,/* 資料確認者 */
xregcnfdt       timestamp(0)      ,/* 資料確認日 */
xregud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xregud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xregud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xregud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xregud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xregud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xregud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xregud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xregud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xregud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xregud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xregud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xregud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xregud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xregud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xregud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xregud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xregud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xregud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xregud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xregud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xregud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xregud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xregud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xregud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xregud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xregud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xregud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xregud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xregud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xreg_t add constraint xreg_pk primary key (xregent,xregdocno) enable validate;

create unique index xreg_pk on xreg_t (xregent,xregdocno);

grant select on xreg_t to tiptop;
grant update on xreg_t to tiptop;
grant delete on xreg_t to tiptop;
grant insert on xreg_t to tiptop;

exit;
