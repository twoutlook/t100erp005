/* 
================================================================================
檔案代號:xmab_t
檔案名稱:信用評核異動明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xmab_t
(
xmabent       number(5)      ,/* 企業編號 */
xmab001       varchar2(10)      ,/* 計算項目 */
xmab002       varchar2(1)      ,/* 異動類型 */
xmab003       varchar2(20)      ,/* 單據編號 */
xmab004       number(5,0)      ,/* 單據項次 */
xmab005       varchar2(10)      ,/* 交易營運據點 */
xmab006       varchar2(10)      ,/* 交易客戶 */
xmab007       varchar2(10)      ,/* 交易幣別 */
xmab008       varchar2(10)      ,/* 額度客戶 */
xmab009       number(20,6)      ,/* 交易含稅金額 */
xmab010       number(20,6)      ,/* 已沖銷金額 */
xmab011       date      ,/* 異動日期 */
xmab012       varchar2(10)      ,/* 據點額度幣別 */
xmab013       number(20,10)      ,/* 據點匯率 */
xmabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmabud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
xmab014       varchar2(10)      ,/* 交易計價單位 */
xmab015       number(20,6)      ,/* 計價數量 */
xmab016       number(20,6)      ,/* 已沖銷數量 */
xmab017       varchar2(1)      ,/* 結案否 */
xmab018       varchar2(10)      ,/* 額度營運據點 */
xmab019       varchar2(10)      ,/* 集團額度幣別 */
xmab020       number(20,10)      /* 集團匯率 */
);
alter table xmab_t add constraint xmab_pk primary key (xmabent,xmab001,xmab002,xmab003,xmab004,xmab005) enable validate;

create unique index xmab_pk on xmab_t (xmabent,xmab001,xmab002,xmab003,xmab004,xmab005);

grant select on xmab_t to tiptop;
grant update on xmab_t to tiptop;
grant delete on xmab_t to tiptop;
grant insert on xmab_t to tiptop;

exit;
