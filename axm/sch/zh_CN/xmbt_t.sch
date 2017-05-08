/* 
================================================================================
檔案代號:xmbt_t
檔案名稱:銷售彈性價格申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmbt_t
(
xmbtent       number(5)      ,/* 企業編號 */
xmbtdocno       varchar2(20)      ,/* 申請單號 */
xmbtdocdt       date      ,/* 申請日期 */
xmbt001       varchar2(5)      ,/* 銷售價格參照表號 */
xmbt002       varchar2(10)      ,/* 銷售控制組 */
xmbt003       varchar2(10)      ,/* 幣別編號 */
xmbt005       varchar2(10)      ,/* 銷售通路 */
xmbt006       varchar2(20)      ,/* 作業編號 */
xmbt007       varchar2(10)      ,/* 申請資料外處理方式 */
xmbt900       varchar2(20)      ,/* 申請人員 */
xmbt901       varchar2(10)      ,/* 申請部門 */
xmbtstus       varchar2(10)      ,/* 資料狀態碼 */
xmbtownid       varchar2(20)      ,/* 資料所有者 */
xmbtowndp       varchar2(10)      ,/* 資料所屬部門 */
xmbtcrtid       varchar2(20)      ,/* 資料建立者 */
xmbtcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmbtcrtdt       timestamp(0)      ,/* 資料創建日 */
xmbtmodid       varchar2(20)      ,/* 資料修改者 */
xmbtmoddt       timestamp(0)      ,/* 最近修改日 */
xmbtcnfid       varchar2(20)      ,/* 資料確認者 */
xmbtcnfdt       timestamp(0)      ,/* 資料確認日 */
xmbtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmbtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmbtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmbtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmbtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmbtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmbtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmbtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmbtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmbtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmbtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmbtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmbtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmbtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmbtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmbtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmbtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmbtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmbtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmbtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmbtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmbtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmbtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmbtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmbtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmbtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmbtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmbtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmbtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmbtud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmbt_t add constraint xmbt_pk primary key (xmbtent,xmbtdocno) enable validate;

create  index xmbt_01 on xmbt_t (xmbt001,xmbt002,xmbt003,xmbt005,xmbt006);
create unique index xmbt_pk on xmbt_t (xmbtent,xmbtdocno);

grant select on xmbt_t to tiptop;
grant update on xmbt_t to tiptop;
grant delete on xmbt_t to tiptop;
grant insert on xmbt_t to tiptop;

exit;
