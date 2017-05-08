/* 
================================================================================
檔案代號:pmbt_t
檔案名稱:採購彈性價格申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmbt_t
(
pmbtent       number(5)      ,/* 企業編號 */
pmbtdocno       varchar2(20)      ,/* 申請單號 */
pmbtdocdt       date      ,/* 申請日期 */
pmbt001       varchar2(5)      ,/* 採購價格參照表號 */
pmbt002       varchar2(10)      ,/* 採購控制組 */
pmbt003       varchar2(10)      ,/* 幣別編號 */
pmbt005       varchar2(10)      ,/* 採購通路 */
pmbt006       varchar2(20)      ,/* 作業編號 */
pmbt007       varchar2(10)      ,/* 申請資料外處理方式 */
pmbt900       varchar2(20)      ,/* 申請人員 */
pmbt901       varchar2(10)      ,/* 申請部門 */
pmbtstus       varchar2(10)      ,/* 資料狀態碼 */
pmbtownid       varchar2(20)      ,/* 資料所有者 */
pmbtowndp       varchar2(10)      ,/* 資料所屬部門 */
pmbtcrtid       varchar2(20)      ,/* 資料建立者 */
pmbtcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmbtcrtdt       timestamp(0)      ,/* 資料創建日 */
pmbtmodid       varchar2(20)      ,/* 資料修改者 */
pmbtmoddt       timestamp(0)      ,/* 最近修改日 */
pmbtcnfid       varchar2(20)      ,/* 資料確認者 */
pmbtcnfdt       timestamp(0)      ,/* 資料確認日 */
pmbtpstid       varchar2(20)      ,/* 資料過帳者 */
pmbtpstdt       timestamp(0)      ,/* 資料過帳日 */
pmbtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbtud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmbt_t add constraint pmbt_pk primary key (pmbtent,pmbtdocno) enable validate;

create  index pmbt_01 on pmbt_t (pmbt001,pmbt002,pmbt003,pmbt005,pmbt006);
create unique index pmbt_pk on pmbt_t (pmbtent,pmbtdocno);

grant select on pmbt_t to tiptop;
grant update on pmbt_t to tiptop;
grant delete on pmbt_t to tiptop;
grant insert on pmbt_t to tiptop;

exit;
