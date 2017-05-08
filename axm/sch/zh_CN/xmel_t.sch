/* 
================================================================================
檔案代號:xmel_t
檔案名稱:包裝單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmel_t
(
xmelent       number(5)      ,/* 企業編號 */
xmelsite       varchar2(10)      ,/* 營運據點 */
xmeldocno       varchar2(20)      ,/* 包裝單號 */
xmeldocdt       date      ,/* 單據日期 */
xmel001       varchar2(20)      ,/* 人員 */
xmel002       varchar2(10)      ,/* 部門 */
xmel003       varchar2(10)      ,/* 客戶 */
xmel004       varchar2(10)      ,/* 包裝單來源 */
xmel005       varchar2(20)      ,/* 來源單號 */
xmel006       date      ,/* 起運日期 */
xmel007       varchar2(10)      ,/* 運輸方式 */
xmel008       varchar2(10)      ,/* 航次 */
xmel009       varchar2(10)      ,/* 起運地 */
xmel010       varchar2(10)      ,/* 卸貨地 */
xmel011       varchar2(10)      ,/* 重量計量制度 */
xmel012       varchar2(10)      ,/* 材積計量制度 */
xmel013       varchar2(10)      ,/* 額外品名規格編號 */
xmel014       varchar2(255)      ,/* 備註 */
xmelownid       varchar2(20)      ,/* 資料所有者 */
xmelowndp       varchar2(10)      ,/* 資料所屬部門 */
xmelcrtid       varchar2(20)      ,/* 資料建立者 */
xmelcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmelcrtdt       timestamp(0)      ,/* 資料創建日 */
xmelmodid       varchar2(20)      ,/* 資料修改者 */
xmelmoddt       timestamp(0)      ,/* 最近修改日 */
xmelcnfid       varchar2(20)      ,/* 資料確認者 */
xmelcnfdt       timestamp(0)      ,/* 資料確認日 */
xmelpstid       varchar2(20)      ,/* 資料過帳者 */
xmelpstdt       timestamp(0)      ,/* 資料過帳日 */
xmelstus       varchar2(10)      ,/* 狀態碼 */
xmelud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmelud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmelud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmelud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmelud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmelud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmelud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmelud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmelud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmelud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmelud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmelud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmelud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmelud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmelud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmelud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmelud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmelud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmelud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmelud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmelud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmelud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmelud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmelud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmelud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmelud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmelud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmelud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmelud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmelud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmel015       varchar2(10)      ,/* 多角流程代碼 */
xmel016       varchar2(1)      ,/* 多角貿易已拋轉 */
xmel017       varchar2(20)      ,/* 多角序號 */
xmel018       varchar2(20)      ,/* 集裝箱載貨清單 */
xmel019       varchar2(20)      ,/* 封條號碼 */
xmel020       date      ,/* 預計出發日期 */
xmel021       date      /* 預計到達日期 */
);
alter table xmel_t add constraint xmel_pk primary key (xmelent,xmeldocno) enable validate;

create unique index xmel_pk on xmel_t (xmelent,xmeldocno);

grant select on xmel_t to tiptop;
grant update on xmel_t to tiptop;
grant delete on xmel_t to tiptop;
grant insert on xmel_t to tiptop;

exit;
