/* 
================================================================================
檔案代號:rtkb_t
檔案名稱:自動補貨配送商品依品類設定配送單日設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:Y
============.========================.==========================================
 */
create table rtkb_t
(
rtkbent       number(5)      ,/* 企業編號 */
rtkbunit       varchar2(10)      ,/* 應用組織 */
rtkb001       varchar2(1)      ,/* 資料類型 */
rtkb002       varchar2(10)      ,/* 店群門店編號 */
rtkb003       varchar2(10)      ,/* 品類編號 */
rtkb004       varchar2(10)      ,/* 出單週期類型 */
rtkb005       varchar2(255)      ,/* 出單日 */
rtkb006       varchar2(255)      ,/* 出單週 */
rtkb007       varchar2(10)      ,/* 送貨時段 */
rtkb008       number(5,0)      ,/* 要貨頻率 */
rtkb009       number(5,0)      ,/* 送貨天數 */
rtkbownid       varchar2(20)      ,/* 資料所有者 */
rtkbowndp       varchar2(10)      ,/* 資料所屬部門 */
rtkbcrtid       varchar2(20)      ,/* 資料建立者 */
rtkbcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtkbcrtdt       timestamp(0)      ,/* 資料創建日 */
rtkbmodid       varchar2(20)      ,/* 資料修改者 */
rtkbmoddt       timestamp(0)      ,/* 最近修改日 */
rtkbstus       varchar2(10)      ,/* 狀態碼 */
rtkbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtkbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtkbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtkbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtkbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtkbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtkbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtkbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtkbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtkbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtkbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtkbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtkbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtkbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtkbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtkbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtkbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtkbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtkbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtkbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtkbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtkbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtkbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtkbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtkbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtkbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtkbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtkbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtkbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtkbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtkb_t add constraint rtkb_pk primary key (rtkbent,rtkb001,rtkb002,rtkb003) enable validate;

create unique index rtkb_pk on rtkb_t (rtkbent,rtkb001,rtkb002,rtkb003);

grant select on rtkb_t to tiptop;
grant update on rtkb_t to tiptop;
grant delete on rtkb_t to tiptop;
grant insert on rtkb_t to tiptop;

exit;
