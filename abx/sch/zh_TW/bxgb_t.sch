/* 
================================================================================
檔案代號:bxgb_t
檔案名稱:保稅料件期間統計資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxgb_t
(
bxgbent       number(5)      ,/* 企業編號 */
bxgbsite       varchar2(10)      ,/* 營運據點 */
bxgb001       varchar2(40)      ,/* 料件編號 */
bxgb002       number(5,0)      ,/* 年度 */
bxgb003       date      ,/* 生效日期 */
bxgb004       number(20,6)      ,/* 內銷數量(庫存單位) */
bxgb005       number(20,6)      ,/* 外銷數量(庫存單位) */
bxgb006       number(20,6)      ,/* 報廢數量(庫存單位) */
bxgb007       number(20,6)      ,/* 外運數量(庫存單位) */
bxgbownid       varchar2(20)      ,/* 資料所有者 */
bxgbowndp       varchar2(10)      ,/* 資料所屬部門 */
bxgbcrtid       varchar2(20)      ,/* 資料建立者 */
bxgbcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxgbcrtdt       timestamp(0)      ,/* 資料創建日 */
bxgbmodid       varchar2(20)      ,/* 資料修改者 */
bxgbmoddt       timestamp(0)      ,/* 最近修改日 */
bxgbcnfid       varchar2(20)      ,/* 資料確認者 */
bxgbcnfdt       timestamp(0)      ,/* 資料確認日 */
bxgbstus       varchar2(10)      ,/* 狀態碼 */
bxgbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxgbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxgbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxgbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxgbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxgbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxgbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxgbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxgbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxgbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxgbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxgbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxgbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxgbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxgbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxgbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxgbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxgbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxgbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxgbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxgbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxgbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxgbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxgbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxgbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxgbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxgbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxgbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxgbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxgbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxgb_t add constraint bxgb_pk primary key (bxgbent,bxgbsite,bxgb001,bxgb002,bxgb003) enable validate;

create unique index bxgb_pk on bxgb_t (bxgbent,bxgbsite,bxgb001,bxgb002,bxgb003);

grant select on bxgb_t to tiptop;
grant update on bxgb_t to tiptop;
grant delete on bxgb_t to tiptop;
grant insert on bxgb_t to tiptop;

exit;
