/* 
================================================================================
檔案代號:xmaw_t
檔案名稱:銷售價格表檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmaw_t
(
xmawent       number(5)      ,/* 企業編號 */
xmaw001       varchar2(5)      ,/* 銷售價格參照表號 */
xmaw002       varchar2(10)      ,/* 基礎幣別 */
xmaw011       varchar2(40)      ,/* 料件編號 */
xmaw012       varchar2(256)      ,/* 產品特徵 */
xmaw013       varchar2(10)      ,/* 計價單位 */
xmaw014       varchar2(1)      ,/* 參考資料否 */
xmaw015       varchar2(40)      ,/* 參考料號 */
xmaw016       varchar2(256)      ,/* 參考料號產品特徵 */
xmaw017       number(20,6)      ,/* 加金額 */
xmaw018       number(20,6)      ,/* 加百分比 */
xmaw019       number(20,6)      ,/* 標準成本 */
xmaw020       number(20,6)      ,/* 銷售底價 */
xmaw021       number(20,6)      ,/* 業務底價 */
xmaw022       number(20,6)      ,/* 一般售價 */
xmaw023       number(20,6)      ,/* 標準定價 */
xmaw100       varchar2(20)      ,/* 申請單號 */
xmawstus       varchar2(10)      ,/* 資料狀態碼 */
xmawownid       varchar2(20)      ,/* 資料所有者 */
xmawowndp       varchar2(10)      ,/* 資料所屬部門 */
xmawcrtid       varchar2(20)      ,/* 資料建立者 */
xmawcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmawcrtdt       timestamp(0)      ,/* 資料創建日 */
xmawmodid       varchar2(20)      ,/* 資料修改者 */
xmawmoddt       timestamp(0)      ,/* 最近修改日 */
xmawud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmawud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmawud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmawud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmawud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmawud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmawud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmawud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmawud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmawud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmawud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmawud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmawud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmawud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmawud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmawud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmawud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmawud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmawud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmawud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmawud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmawud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmawud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmawud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmawud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmawud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmawud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmawud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmawud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmawud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmaw031       varchar2(10)      ,/* 系列 */
xmaw032       varchar2(10)      ,/* 產品分類 */
xmaw033       varchar2(10)      ,/* 參考系列 */
xmaw034       varchar2(10)      /* 參考產品分類 */
);
alter table xmaw_t add constraint xmaw_pk primary key (xmawent,xmaw001,xmaw002,xmaw011,xmaw012,xmaw013,xmaw031,xmaw032) enable validate;

create unique index xmaw_pk on xmaw_t (xmawent,xmaw001,xmaw002,xmaw011,xmaw012,xmaw013,xmaw031,xmaw032);

grant select on xmaw_t to tiptop;
grant update on xmaw_t to tiptop;
grant delete on xmaw_t to tiptop;
grant insert on xmaw_t to tiptop;

exit;
