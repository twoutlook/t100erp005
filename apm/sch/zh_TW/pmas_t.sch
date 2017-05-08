/* 
================================================================================
檔案代號:pmas_t
檔案名稱:彈性採購價格畫面設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pmas_t
(
pmasent       number(5)      ,/* 企業編號 */
pmas001       varchar2(10)      ,/* 畫面設定編號 */
pmas002       varchar2(1)      ,/* 產品特徵 */
pmas003       varchar2(1)      ,/* 洲別編號 */
pmas004       varchar2(1)      ,/* 國家編號 */
pmas005       varchar2(1)      ,/* 州省編號 */
pmas006       varchar2(1)      ,/* 供應商價格群組 */
pmas007       varchar2(1)      ,/* 供應商分類 */
pmas008       varchar2(1)      ,/* 稅別編號 */
pmas009       varchar2(1)      ,/* 付款條件 */
pmas010       varchar2(1)      ,/* 交易條件 */
pmasownid       varchar2(20)      ,/* 資料所有者 */
pmasowndp       varchar2(10)      ,/* 資料所屬部門 */
pmascrtid       varchar2(20)      ,/* 資料建立者 */
pmascrtdp       varchar2(10)      ,/* 資料建立部門 */
pmascrtdt       timestamp(0)      ,/* 資料創建日 */
pmasmodid       varchar2(20)      ,/* 資料修改者 */
pmasmoddt       timestamp(0)      ,/* 最近修改日 */
pmasstus       varchar2(10)      ,/* 狀態碼 */
pmasud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmasud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmasud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmasud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmasud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmasud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmasud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmasud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmasud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmasud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmasud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmasud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmasud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmasud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmasud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmasud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmasud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmasud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmasud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmasud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmasud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmasud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmasud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmasud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmasud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmasud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmasud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmasud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmasud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmasud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmas011       varchar2(1)      ,/* 料件編號 */
pmas012       varchar2(1)      ,/* 系列 */
pmas013       varchar2(1)      /* 產品分類 */
);
alter table pmas_t add constraint pmas_pk primary key (pmasent,pmas001) enable validate;

create unique index pmas_pk on pmas_t (pmasent,pmas001);

grant select on pmas_t to tiptop;
grant update on pmas_t to tiptop;
grant delete on pmas_t to tiptop;
grant insert on pmas_t to tiptop;

exit;
