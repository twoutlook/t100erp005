/* 
================================================================================
檔案代號:xrep_t
檔案名稱:各期遞延沖轉主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xrep_t
(
xrepent       number(5)      ,/* 企業代碼 */
xrepsite       varchar2(10)      ,/* 帳務中心 */
xrepcomp       varchar2(10)      ,/* 法人 */
xrepdocno       varchar2(20)      ,/* 單據號碼 */
xrepdocdt       date      ,/* 單據日期 */
xrepld       varchar2(5)      ,/* 帳別 */
xrep001       number(5,0)      ,/* 年度 */
xrep002       number(5,0)      ,/* 期別 */
xrep003       varchar2(20)      ,/* 帳務人員 */
xrep004       varchar2(20)      ,/* 傳票號碼 */
xrep005       varchar2(1)      ,/* 第一期系統認列 */
xrepstus       varchar2(10)      ,/* 狀態碼 */
xrepownid       varchar2(20)      ,/* 資料所有者 */
xrepowndp       varchar2(10)      ,/* 資料所屬部門 */
xrepcrtid       varchar2(20)      ,/* 資料建立者 */
xrepcrtdp       varchar2(10)      ,/* 資料建立部門 */
xrepcrtdt       timestamp(0)      ,/* 資料創建日 */
xrepmodid       varchar2(20)      ,/* 資料修改者 */
xrepmoddt       timestamp(0)      ,/* 最近修改日 */
xrepcnfid       varchar2(20)      ,/* 資料確認者 */
xrepcnfdt       timestamp(0)      ,/* 資料確認日 */
xrepud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrepud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrepud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrepud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrepud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrepud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrepud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrepud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrepud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrepud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrepud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrepud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrepud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrepud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrepud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrepud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrepud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrepud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrepud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrepud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrepud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrepud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrepud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrepud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrepud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrepud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrepud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrepud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrepud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrepud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrep_t add constraint xrep_pk primary key (xrepent,xrepdocno,xrepld) enable validate;

create unique index xrep_pk on xrep_t (xrepent,xrepdocno,xrepld);

grant select on xrep_t to tiptop;
grant update on xrep_t to tiptop;
grant delete on xrep_t to tiptop;
grant insert on xrep_t to tiptop;

exit;
