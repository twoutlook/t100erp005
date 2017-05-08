/* 
================================================================================
檔案代號:xrec_t
檔案名稱:暫估月結檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xrec_t
(
xrecent       number(5)      ,/* 企業代碼 */
xrecsite       varchar2(10)      ,/* 帳務組織 */
xreccomp       varchar2(10)      ,/* 法人 */
xrecld       varchar2(5)      ,/* 帳別 */
xrec001       number(5,0)      ,/* 年度 */
xrec002       number(5,0)      ,/* 期別 */
xrec003       varchar2(10)      ,/* 來源模組 */
xrec004       varchar2(10)      ,/* 帳款性質 */
xrec005       varchar2(10)      ,/* 帳款對象 */
xrec006       varchar2(10)      ,/* 收款對象 */
xrec007       varchar2(40)      ,/* 料號(費用代碼) */
xrec008       varchar2(10)      ,/* 單位 */
xrec009       number(20,6)      ,/* 本期暫估數量 */
xrec010       number(20,6)      ,/* 本期沖暫估量 */
xrec011       number(20,6)      ,/* 累計未沖量 */
xrec100       varchar2(10)      ,/* 幣別 */
xrec103       number(20,6)      ,/* 本期暫估原幣金額 */
xrec104       number(20,6)      ,/* 本期沖暫估原幣金額 */
xrec113       number(20,6)      ,/* 本期暫估本幣金額 */
xrec114       number(20,6)      ,/* 本期沖暫估本幣金額 */
xrecud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrecud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrecud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrecud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrecud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrecud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrecud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrecud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrecud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrecud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrecud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrecud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrecud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrecud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrecud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrecud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrecud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrecud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrecud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrecud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrecud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrecud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrecud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrecud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrecud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrecud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrecud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrecud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrecud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrecud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrec_t add constraint xrec_pk primary key (xrecent,xrecsite,xrecld,xrec001,xrec002,xrec003,xrec004,xrec005,xrec006,xrec007,xrec008,xrec100) enable validate;

create unique index xrec_pk on xrec_t (xrecent,xrecsite,xrecld,xrec001,xrec002,xrec003,xrec004,xrec005,xrec006,xrec007,xrec008,xrec100);

grant select on xrec_t to tiptop;
grant update on xrec_t to tiptop;
grant delete on xrec_t to tiptop;
grant insert on xrec_t to tiptop;

exit;
