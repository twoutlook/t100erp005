/* 
================================================================================
檔案代號:xmas_t
檔案名稱:彈性銷售價格畫面設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xmas_t
(
xmasent       number(5)      ,/* 企業編號 */
xmas001       varchar2(10)      ,/* 畫面設定編號 */
xmas002       varchar2(1)      ,/* 產品特徵 */
xmas003       varchar2(1)      ,/* 洲別編號 */
xmas004       varchar2(1)      ,/* 國家編號 */
xmas005       varchar2(1)      ,/* 州省編號 */
xmas006       varchar2(1)      ,/* 客戶價格群組 */
xmas007       varchar2(1)      ,/* 客戶分類 */
xmas008       varchar2(1)      ,/* 稅別編號 */
xmas009       varchar2(1)      ,/* 收款條件 */
xmas010       varchar2(1)      ,/* 交易條件 */
xmasownid       varchar2(20)      ,/* 資料所有者 */
xmasowndp       varchar2(10)      ,/* 資料所屬部門 */
xmascrtid       varchar2(20)      ,/* 資料建立者 */
xmascrtdp       varchar2(10)      ,/* 資料建立部門 */
xmascrtdt       timestamp(0)      ,/* 資料創建日 */
xmasmodid       varchar2(20)      ,/* 資料修改者 */
xmasmoddt       timestamp(0)      ,/* 最近修改日 */
xmasstus       varchar2(10)      ,/* 狀態碼 */
xmasud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmasud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmasud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmasud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmasud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmasud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmasud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmasud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmasud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmasud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmasud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmasud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmasud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmasud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmasud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmasud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmasud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmasud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmasud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmasud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmasud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmasud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmasud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmasud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmasud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmasud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmasud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmasud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmasud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmasud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmas011       varchar2(1)      ,/* 料件編號 */
xmas012       varchar2(1)      ,/* 系列 */
xmas013       varchar2(1)      /* 產品分類 */
);
alter table xmas_t add constraint xmas_pk primary key (xmasent,xmas001) enable validate;

create unique index xmas_pk on xmas_t (xmasent,xmas001);

grant select on xmas_t to tiptop;
grant update on xmas_t to tiptop;
grant delete on xmas_t to tiptop;
grant insert on xmas_t to tiptop;

exit;
