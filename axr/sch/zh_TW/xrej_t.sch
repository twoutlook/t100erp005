/* 
================================================================================
檔案代號:xrej_t
檔案名稱:壞帳提列主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xrej_t
(
xrejent       number(5)      ,/* 企業代碼 */
xrejownid       varchar2(20)      ,/* 資料所有者 */
xrejowndp       varchar2(10)      ,/* 資料所屬部門 */
xrejcrtid       varchar2(20)      ,/* 資料建立者 */
xrejcrtdp       varchar2(10)      ,/* 資料建立部門 */
xrejcrtdt       timestamp(0)      ,/* 資料創建日 */
xrejmodid       varchar2(20)      ,/* 資料修改者 */
xrejmoddt       timestamp(0)      ,/* 最近修改日 */
xrejcnfid       varchar2(20)      ,/* 資料確認者 */
xrejcnfdt       timestamp(0)      ,/* 資料確認日 */
xrejstus       varchar2(10)      ,/* 狀態碼 */
xrejsite       varchar2(10)      ,/* 帳務中心 */
xrejld       varchar2(5)      ,/* 帳別 */
xrejcomp       varchar2(10)      ,/* 法人 */
xrejdocno       varchar2(20)      ,/* 單號 */
xrejdocdt       date      ,/* 單據日期 */
xrej001       number(5,0)      ,/* 年度 */
xrej002       number(5,0)      ,/* 期別 */
xrej003       varchar2(10)      ,/* 來源模組 */
xrej004       varchar2(20)      ,/* 帳務人員 */
xrej005       varchar2(20)      ,/* 傳票號碼 */
xrejud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrejud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrejud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrejud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrejud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrejud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrejud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrejud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrejud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrejud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrejud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrejud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrejud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrejud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrejud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrejud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrejud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrejud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrejud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrejud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrejud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrejud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrejud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrejud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrejud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrejud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrejud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrejud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrejud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrejud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrej_t add constraint xrej_pk primary key (xrejent,xrejdocno) enable validate;

create unique index xrej_pk on xrej_t (xrejent,xrejdocno);

grant select on xrej_t to tiptop;
grant update on xrej_t to tiptop;
grant delete on xrej_t to tiptop;
grant insert on xrej_t to tiptop;

exit;
