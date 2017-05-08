/* 
================================================================================
檔案代號:xmic_t
檔案名稱:銷售預測單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmic_t
(
xmicent       number(5)      ,/* 企業編號 */
xmic001       varchar2(10)      ,/* 預測編號 */
xmic002       date      ,/* 預測起始日 */
xmic003       number(5,0)      ,/* 版本 */
xmic004       varchar2(10)      ,/* 預測營運據點 */
xmic005       varchar2(10)      ,/* 銷售組織 */
xmic006       varchar2(20)      ,/* 業務員 */
xmic007       varchar2(10)      ,/* 幣別 */
xmicownid       varchar2(20)      ,/* 資料所有者 */
xmicowndp       varchar2(10)      ,/* 資料所屬部門 */
xmiccrtid       varchar2(20)      ,/* 資料建立者 */
xmiccrtdp       varchar2(10)      ,/* 資料建立部門 */
xmiccrtdt       timestamp(0)      ,/* 資料創建日 */
xmicmodid       varchar2(20)      ,/* 資料修改者 */
xmicmoddt       timestamp(0)      ,/* 最近修改日 */
xmiccnfid       varchar2(20)      ,/* 資料確認者 */
xmiccnfdt       timestamp(0)      ,/* 資料確認日 */
xmicpstid       varchar2(20)      ,/* 資料過帳者 */
xmicpstdt       timestamp(0)      ,/* 資料過帳日 */
xmicstus       varchar2(10)      ,/* 狀態碼 */
xmicud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmicud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmicud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmicud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmicud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmicud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmicud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmicud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmicud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmicud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmicud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmicud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmicud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmicud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmicud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmicud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmicud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmicud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmicud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmicud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmicud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmicud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmicud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmicud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmicud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmicud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmicud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmicud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmicud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmicud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmic_t add constraint xmic_pk primary key (xmicent,xmic001,xmic002,xmic003,xmic004,xmic005,xmic006) enable validate;

create unique index xmic_pk on xmic_t (xmicent,xmic001,xmic002,xmic003,xmic004,xmic005,xmic006);

grant select on xmic_t to tiptop;
grant update on xmic_t to tiptop;
grant delete on xmic_t to tiptop;
grant insert on xmic_t to tiptop;

exit;
