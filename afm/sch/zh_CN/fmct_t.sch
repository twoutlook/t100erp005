/* 
================================================================================
檔案代號:fmct_t
檔案名稱:融資帳務單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fmct_t
(
fmctent       number(5)      ,/* 企業代碼 */
fmctownid       varchar2(20)      ,/* 資料所屬者 */
fmctowndp       varchar2(10)      ,/* 資料所屬部門 */
fmctcrtid       varchar2(20)      ,/* 資料建立者 */
fmctcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmctcrtdt       timestamp(0)      ,/* 資料創建日 */
fmctmodid       varchar2(20)      ,/* 資料修改者 */
fmctmoddt       timestamp(0)      ,/* 最近修改日 */
fmctcnfid       varchar2(20)      ,/* 資料確認者 */
fmctcnfdt       timestamp(0)      ,/* 資料確認日 */
fmctstus       varchar2(10)      ,/* 狀態碼 */
fmctdocno       varchar2(20)      ,/* 融資到帳帳務單號 */
fmctsite       varchar2(10)      ,/* 賬務中心 */
fmctld       varchar2(5)      ,/* 帳套 */
fmctcomp       varchar2(10)      ,/* 法人 */
fmctdocdt       date      ,/* 日期 */
fmct001       varchar2(10)      ,/* 資料來源 */
fmct002       varchar2(20)      ,/* 憑證編號 */
fmct003       date      ,/* 憑證日期 */
fmctud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmctud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmctud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmctud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmctud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmctud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmctud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmctud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmctud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmctud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmctud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmctud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmctud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmctud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmctud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmctud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmctud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmctud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmctud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmctud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmctud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmctud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmctud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmctud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmctud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmctud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmctud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmctud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmctud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmctud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fmct_t add constraint fmct_pk primary key (fmctent,fmctdocno) enable validate;

create unique index fmct_pk on fmct_t (fmctent,fmctdocno);

grant select on fmct_t to tiptop;
grant update on fmct_t to tiptop;
grant delete on fmct_t to tiptop;
grant insert on fmct_t to tiptop;

exit;
