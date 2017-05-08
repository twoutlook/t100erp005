/* 
================================================================================
檔案代號:xrem_t
檔案名稱:暫估帳務主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table xrem_t
(
xrement       number(5)      ,/* 企業代碼 */
xremownid       varchar2(20)      ,/* 資料所有者 */
xremowndp       varchar2(10)      ,/* 資料所屬部門 */
xremcrtid       varchar2(20)      ,/* 資料建立者 */
xremcrtdp       varchar2(10)      ,/* 資料建立部門 */
xremcrtdt       timestamp(0)      ,/* 資料創建日 */
xremmodid       varchar2(20)      ,/* 資料修改者 */
xremmoddt       timestamp(0)      ,/* 最近修改日 */
xremcnfid       varchar2(20)      ,/* 資料確認者 */
xremcnfdt       timestamp(0)      ,/* 資料確認日 */
xremstus       varchar2(10)      ,/* 狀態碼 */
xremsite       varchar2(10)      ,/* 營運據點 */
xremld       varchar2(5)      ,/* 帳別 */
xremcomp       varchar2(10)      ,/* 法人 */
xremdocno       varchar2(20)      ,/* 單據編號 */
xremdocdt       date      ,/* 單據日期 */
xrem001       number(5,0)      ,/* 年度 */
xrem002       number(5,0)      ,/* 期別 */
xrem003       varchar2(10)      ,/* 來源模組 */
xrem004       varchar2(20)      ,/* 帳務人員 */
xrem005       varchar2(20)      ,/* 傳票號碼 */
xrem006       varchar2(1)      ,/* 暫估類型 */
xremud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xremud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xremud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xremud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xremud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xremud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xremud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xremud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xremud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xremud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xremud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xremud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xremud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xremud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xremud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xremud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xremud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xremud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xremud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xremud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xremud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xremud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xremud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xremud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xremud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xremud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xremud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xremud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xremud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xremud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrem_t add constraint xrem_pk primary key (xrement,xremdocno) enable validate;

create unique index xrem_pk on xrem_t (xrement,xremdocno);

grant select on xrem_t to tiptop;
grant update on xrem_t to tiptop;
grant delete on xrem_t to tiptop;
grant insert on xrem_t to tiptop;

exit;
