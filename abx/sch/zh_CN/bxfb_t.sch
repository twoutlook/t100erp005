/* 
================================================================================
檔案代號:bxfb_t
檔案名稱:保稅受託加工原料料件月統計檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table bxfb_t
(
bxfbent       number(5)      ,/* 企業編號 */
bxfbsite       varchar2(10)      ,/* 營運據點 */
bxfb001       varchar2(40)      ,/* 料件編號 */
bxfb002       number(5,0)      ,/* 年度 */
bxfb003       number(5,0)      ,/* 期別 */
bxfb004       varchar2(20)      ,/* 訂單單號 */
bxfb005       number(10,0)      ,/* 訂單項次 */
bxfb006       number(10,0)      ,/* 訂單項序 */
bxfb007       number(10,0)      ,/* 訂單分批序 */
bxfb011       number(20,6)      ,/* 本期雜收總量 */
bxfb012       number(20,6)      ,/* 本期雜發總量 */
bxfb013       number(20,6)      ,/* 本期報廢總量 */
bxfb014       number(20,6)      ,/* 本期工單發料總量 */
bxfb015       number(20,6)      ,/* 本期工單退料總量 */
bxfb016       number(20,6)      ,/* 本期完工入庫總量 */
bxfb017       number(20,6)      ,/* 本期採購入庫總量 */
bxfb018       number(20,6)      ,/* 本期採購倉退總量 */
bxfb019       number(20,6)      ,/* 本期銷貨總量 */
bxfb020       number(20,6)      ,/* 本期銷貨退回總量 */
bxfb021       number(20,6)      ,/* 本期其他異動總量 */
bxfb022       number(20,6)      ,/* 期末數量 */
bxfbownid       varchar2(20)      ,/* 資料所有者 */
bxfbowndp       varchar2(10)      ,/* 資料所屬部門 */
bxfbcrtid       varchar2(20)      ,/* 資料建立者 */
bxfbcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxfbcrtdt       timestamp(0)      ,/* 資料創建日 */
bxfbmodid       varchar2(20)      ,/* 資料修改者 */
bxfbmoddt       timestamp(0)      ,/* 最近修改日 */
bxfbstus       varchar2(10)      ,/* 狀態碼 */
bxfbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxfbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxfbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxfbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxfbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxfbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxfbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxfbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxfbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxfbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxfbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxfbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxfbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxfbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxfbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxfbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxfbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxfbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxfbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxfbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxfbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxfbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxfbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxfbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxfbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxfbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxfbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxfbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxfbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxfbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxfb_t add constraint bxfb_pk primary key (bxfbent,bxfbsite,bxfb001,bxfb002,bxfb003,bxfb004,bxfb005,bxfb006,bxfb007) enable validate;

create unique index bxfb_pk on bxfb_t (bxfbent,bxfbsite,bxfb001,bxfb002,bxfb003,bxfb004,bxfb005,bxfb006,bxfb007);

grant select on bxfb_t to tiptop;
grant update on bxfb_t to tiptop;
grant delete on bxfb_t to tiptop;
grant insert on bxfb_t to tiptop;

exit;
