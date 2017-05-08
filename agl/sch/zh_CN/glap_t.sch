/* 
================================================================================
檔案代號:glap_t
檔案名稱:傳票憑證單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table glap_t
(
glapent       number(5)      ,/* 企業編號 */
glapld       varchar2(5)      ,/* 帳別 */
glapcomp       varchar2(10)      ,/* 法人 */
glapdocno       varchar2(20)      ,/* 單號 */
glapdocdt       date      ,/* 單據日期 */
glap001       varchar2(1)      ,/* 傳票性質 */
glap002       number(5,0)      ,/* 會計年度 */
glap003       number(5,0)      ,/* 會計季別 */
glap004       number(5,0)      ,/* 會計期別 */
glap005       number(5,0)      ,/* 會計周別 */
glap006       varchar2(24)      ,/* 收支科目 */
glap007       varchar2(10)      ,/* 來源碼 */
glap008       varchar2(10)      ,/* 帳款類型 */
glap009       number(10,0)      ,/* 總號 */
glap010       number(20,6)      ,/* 借方總金額 */
glap011       number(20,6)      ,/* 貸方總金額 */
glap012       number(5,0)      ,/* 列印次數 */
glap013       number(5,0)      ,/* 附件張數 */
glap014       varchar2(1)      ,/* 外幣憑證否 */
glap015       varchar2(20)      ,/* 原傳票編號 */
glap016       varchar2(5)      ,/* 來源帳別編號 */
glap017       varchar2(20)      ,/* 來源傳票編號 */
glapownid       varchar2(20)      ,/* 資料所有者 */
glapowndp       varchar2(10)      ,/* 資料所屬部門 */
glapcrtid       varchar2(20)      ,/* 資料建立者 */
glapcrtdp       varchar2(10)      ,/* 資料建立部門 */
glapcrtdt       timestamp(0)      ,/* 資料創建日 */
glapmodid       varchar2(20)      ,/* 資料修改者 */
glapmoddt       timestamp(0)      ,/* 最近修改日 */
glapcnfid       varchar2(20)      ,/* 資料確認者 */
glapcnfdt       timestamp(0)      ,/* 資料確認日 */
glappstid       varchar2(20)      ,/* 資料過帳者 */
glappstdt       timestamp(0)      ,/* 資料過帳日 */
glapstus       varchar2(10)      ,/* 狀態碼 */
glapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glap_t add constraint glap_pk primary key (glapent,glapld,glapdocno) enable validate;

create unique index glap_pk on glap_t (glapent,glapld,glapdocno);

grant select on glap_t to tiptop;
grant update on glap_t to tiptop;
grant delete on glap_t to tiptop;
grant insert on glap_t to tiptop;

exit;
