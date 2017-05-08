/* 
================================================================================
檔案代號:xmag_t
檔案名稱:客戶料件價格檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmag_t
(
xmagent       number(5)      ,/* 企業編號 */
xmagsite       varchar2(10)      ,/* 營運據點 */
xmag000       varchar2(1)      ,/* 委外否 */
xmag001       varchar2(10)      ,/* 客戶編號 */
xmag002       varchar2(40)      ,/* 料件編號 */
xmag003       varchar2(256)      ,/* 產品特徵 */
xmag004       varchar2(10)      ,/* 作業編號 */
xmag005       varchar2(10)      ,/* 作業序 */
xmag006       varchar2(10)      ,/* 計價單位 */
xmag007       varchar2(10)      ,/* 計價幣別 */
xmag008       number(20,10)      ,/* 匯率 */
xmag009       varchar2(10)      ,/* 稅別 */
xmag010       varchar2(1)      ,/* 單價含稅否 */
xmag011       number(5,2)      ,/* 稅率 */
xmag012       number(20,6)      ,/* 原幣單價 */
xmag013       number(20,6)      ,/* 本幣單價 */
xmag014       varchar2(10)      ,/* 最近銷售單位 */
xmag015       number(20,6)      ,/* 最近銷售數量 */
xmag016       number(20,6)      ,/* 最近銷售含稅金額 */
xmag017       number(20,6)      ,/* 最近銷售未稅金額 */
xmag018       varchar2(20)      ,/* 參考單號 */
xmag019       date      ,/* 最近異動日期 */
xmag020       varchar2(20)      ,/* 最近異動人員 */
xmagownid       varchar2(20)      ,/* 資料所有者 */
xmagowndp       varchar2(10)      ,/* 資料所屬部門 */
xmagcrtid       varchar2(20)      ,/* 資料建立者 */
xmagcrtdp       varchar2(10)      ,/* 資料建立部門 */
xmagcrtdt       timestamp(0)      ,/* 資料創建日 */
xmagmodid       varchar2(20)      ,/* 資料修改者 */
xmagmoddt       timestamp(0)      ,/* 最近修改日 */
xmagstus       varchar2(10)      ,/* 狀態碼 */
xmagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmag_t add constraint xmag_pk primary key (xmagent,xmagsite,xmag000,xmag001,xmag002,xmag003,xmag004,xmag005,xmag006,xmag007,xmag009) enable validate;

create unique index xmag_pk on xmag_t (xmagent,xmagsite,xmag000,xmag001,xmag002,xmag003,xmag004,xmag005,xmag006,xmag007,xmag009);

grant select on xmag_t to tiptop;
grant update on xmag_t to tiptop;
grant delete on xmag_t to tiptop;
grant insert on xmag_t to tiptop;

exit;
