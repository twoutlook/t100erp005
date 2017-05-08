/* 
================================================================================
檔案代號:xmau_t
檔案名稱:彈性銷售價格檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmau_t
(
xmauent       number(5)      ,/* 企業編號 */
xmau001       varchar2(5)      ,/* 銷售價格參照表號 */
xmau002       varchar2(10)      ,/* 銷售控制組 */
xmau003       varchar2(10)      ,/* 幣別編號 */
xmau005       varchar2(10)      ,/* 銷售通路 */
xmau006       varchar2(20)      ,/* 作業編號 */
xmau011       varchar2(40)      ,/* 料件編號 */
xmau012       varchar2(256)      ,/* 產品特徵 */
xmau013       varchar2(10)      ,/* 洲別編號 */
xmau014       varchar2(10)      ,/* 國家編號 */
xmau015       varchar2(10)      ,/* 州省編號 */
xmau016       varchar2(10)      ,/* 客戶價格群組 */
xmau017       varchar2(10)      ,/* 客戶分類 */
xmau018       varchar2(10)      ,/* 計價單位 */
xmau019       varchar2(10)      ,/* 稅別編號 */
xmau020       varchar2(10)      ,/* 收款條件 */
xmau021       varchar2(10)      ,/* 交易條件 */
xmau022       number(20,6)      ,/* 單價 */
xmau100       varchar2(20)      ,/* 申請單號 */
xmaustus       varchar2(10)      ,/* 資料狀態碼 */
xmauownid       varchar2(20)      ,/* 資料所有者 */
xmauowndp       varchar2(10)      ,/* 資料所屬部門 */
xmaucrtid       varchar2(20)      ,/* 資料建立者 */
xmaucrtdp       varchar2(10)      ,/* 資料建立部門 */
xmaucrtdt       timestamp(0)      ,/* 資料創建日 */
xmaumodid       varchar2(20)      ,/* 資料修改者 */
xmaumoddt       timestamp(0)      ,/* 最近修改日 */
xmauud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmauud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmauud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmauud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmauud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmauud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmauud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmauud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmauud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmauud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmauud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmauud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmauud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmauud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmauud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmauud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmauud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmauud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmauud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmauud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmauud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmauud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmauud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmauud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmauud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmauud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmauud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmauud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmauud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmauud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmau031       varchar2(10)      ,/* 系列 */
xmau032       varchar2(10)      /* 產品分類 */
);
alter table xmau_t add constraint xmau_pk primary key (xmauent,xmau001,xmau002,xmau003,xmau005,xmau006,xmau011,xmau012,xmau013,xmau014,xmau015,xmau016,xmau017,xmau018,xmau019,xmau020,xmau021,xmau031,xmau032) enable validate;

create unique index xmau_pk on xmau_t (xmauent,xmau001,xmau002,xmau003,xmau005,xmau006,xmau011,xmau012,xmau013,xmau014,xmau015,xmau016,xmau017,xmau018,xmau019,xmau020,xmau021,xmau031,xmau03);

grant select on xmau_t to tiptop;
grant update on xmau_t to tiptop;
grant delete on xmau_t to tiptop;
grant insert on xmau_t to tiptop;

exit;
