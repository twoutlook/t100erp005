/* 
================================================================================
檔案代號:oogb_t
檔案名稱:行事曆假日當
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oogb_t
(
oogbent       number(5)      ,/* 企業編號 */
oogb001       varchar2(5)      ,/* 行事曆參照表號 */
oogb002       date      ,/* 日期 */
oogb003       varchar2(10)      ,/* 休假類型 */
oogb004       varchar2(80)      ,/* 原因說明 */
oogb005       varchar2(10)      ,/* 分類一 */
oogb006       varchar2(10)      ,/* 分類二 */
oogb007       varchar2(10)      ,/* 分類三 */
oogb008       varchar2(10)      ,/* 分類四 */
oogb009       varchar2(10)      ,/* 分類五 */
oogbstus       varchar2(10)      ,/* 狀態碼 */
oogbownid       varchar2(20)      ,/* 資料所有者 */
oogbowndp       varchar2(10)      ,/* 資料所屬部門 */
oogbcrtid       varchar2(20)      ,/* 資料建立者 */
oogbcrtdp       varchar2(10)      ,/* 資料建立部門 */
oogbcrtdt       timestamp(0)      ,/* 資料創建日 */
oogbmodid       varchar2(20)      ,/* 資料修改者 */
oogbmoddt       timestamp(0)      ,/* 最近修改日 */
oogb010       number(5,0)      ,/* 年度 */
oogbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oogbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oogbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oogbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oogbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oogbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oogbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oogbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oogbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oogbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oogbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oogbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oogbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oogbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oogbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oogbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oogbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oogbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oogbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oogbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oogbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oogbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oogbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oogbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oogbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oogbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oogbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oogbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oogbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oogbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oogb_t add constraint oogb_pk primary key (oogbent,oogb001,oogb002,oogb010) enable validate;

create unique index oogb_pk on oogb_t (oogbent,oogb001,oogb002,oogb010);

grant select on oogb_t to tiptop;
grant update on oogb_t to tiptop;
grant delete on oogb_t to tiptop;
grant insert on oogb_t to tiptop;

exit;
