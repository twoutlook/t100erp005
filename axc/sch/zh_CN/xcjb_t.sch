/* 
================================================================================
檔案代號:xcjb_t
檔案名稱:內部交易定價主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcjb_t
(
xcjbent       number(5)      ,/* 企業編號 */
xcjb001       varchar2(10)      ,/* 計算類型(版本) */
xcjb002       number(5,0)      ,/* 年度 */
xcjb003       number(5,0)      ,/* 期別 */
xcjb004       varchar2(40)      ,/* 料號 */
xcjb005       varchar2(10)      ,/* 銷售組織 */
xcjb006       varchar2(10)      ,/* 採購組織 */
xcjb007       varchar2(10)      ,/* 計價單位 */
xcjb008       varchar2(10)      ,/* 幣別 */
xcjb009       number(20,6)      ,/* 內部定價 */
xcjbownid       varchar2(20)      ,/* 資料所有者 */
xcjbowndp       varchar2(10)      ,/* 資料所屬部門 */
xcjbcrtid       varchar2(20)      ,/* 資料建立者 */
xcjbcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcjbcrtdt       timestamp(0)      ,/* 資料創建日 */
xcjbmodid       varchar2(20)      ,/* 資料修改者 */
xcjbmoddt       timestamp(0)      ,/* 最近修改日 */
xcjbstus       varchar2(10)      ,/* 狀態碼 */
xcjbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcjbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcjbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcjbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcjbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcjbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcjbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcjbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcjbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcjbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcjbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcjbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcjbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcjbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcjbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcjbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcjbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcjbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcjbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcjbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcjbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcjbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcjbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcjbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcjbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcjbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcjbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcjbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcjbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcjbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcjb_t add constraint xcjb_pk primary key (xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006) enable validate;

create unique index xcjb_pk on xcjb_t (xcjbent,xcjb001,xcjb002,xcjb003,xcjb004,xcjb005,xcjb006);

grant select on xcjb_t to tiptop;
grant update on xcjb_t to tiptop;
grant delete on xcjb_t to tiptop;
grant insert on xcjb_t to tiptop;

exit;
