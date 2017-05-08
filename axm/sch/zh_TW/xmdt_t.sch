/* 
================================================================================
檔案代號:xmdt_t
檔案名稱:銷售核價單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmdt_t
(
xmdtent       number(5)      ,/* 企業編號 */
xmdtsite       varchar2(10)      ,/* 營運據點 */
xmdtdocno       varchar2(20)      ,/* 單號 */
xmdtdocdt       date      ,/* 單據日期 */
xmdt001       varchar2(1)      ,/* 委外否 */
xmdt002       varchar2(20)      ,/* 申請人員 */
xmdt003       varchar2(10)      ,/* 申請部門 */
xmdt004       varchar2(10)      ,/* 核價客戶 */
xmdt005       varchar2(10)      ,/* 幣別 */
xmdt006       varchar2(10)      ,/* 稅別 */
xmdt007       number(5,2)      ,/* 稅率 */
xmdt008       varchar2(1)      ,/* 單價含稅否 */
xmdt009       varchar2(10)      ,/* 收款條件 */
xmdt010       varchar2(1)      ,/* 限定收款條件否 */
xmdt011       varchar2(10)      ,/* 交易條件 */
xmdt012       varchar2(1)      ,/* 限定交易條件否 */
xmdt013       varchar2(1)      ,/* 限定幣別否 */
xmdt014       varchar2(1)      ,/* 限定稅別否 */
xmdt015       date      ,/* 生效日期 */
xmdt016       date      ,/* 失效日期 */
xmdt017       varchar2(10)      ,/* 核價對象管制 */
xmdt018       varchar2(10)      ,/* 核價使用管制 */
xmdt019       varchar2(10)      ,/* 銷售通路 */
xmdt020       varchar2(1)      ,/* 限定銷售通路 */
xmdt030       varchar2(255)      ,/* 備註 */
xmdtownid       varchar2(20)      ,/* 資料所有者 */
xmdtowndp       varchar2(10)      ,/* 資料所屬部門 */
xmdtcrtid       varchar2(20)      ,/* 資料建立者 */
xmdtcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmdtcrtdt       timestamp(0)      ,/* 資料創建日 */
xmdtmodid       varchar2(20)      ,/* 資料修改者 */
xmdtmoddt       timestamp(0)      ,/* 最近修改日 */
xmdtcnfid       varchar2(20)      ,/* 資料確認者 */
xmdtcnfdt       timestamp(0)      ,/* 資料確認日 */
xmdtpstid       varchar2(20)      ,/* 資料過帳者 */
xmdtpstdt       timestamp(0)      ,/* 資料過帳日 */
xmdtstus       varchar2(10)      ,/* 狀態碼 */
xmdtud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmdtud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmdtud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmdtud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmdtud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmdtud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmdtud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmdtud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmdtud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmdtud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmdtud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmdtud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmdtud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmdtud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmdtud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmdtud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmdtud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmdtud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmdtud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmdtud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmdtud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmdtud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmdtud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmdtud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmdtud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmdtud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmdtud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmdtud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmdtud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmdtud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmdt_t add constraint xmdt_pk primary key (xmdtent,xmdtdocno) enable validate;

create unique index xmdt_pk on xmdt_t (xmdtent,xmdtdocno);

grant select on xmdt_t to tiptop;
grant update on xmdt_t to tiptop;
grant delete on xmdt_t to tiptop;
grant insert on xmdt_t to tiptop;

exit;
