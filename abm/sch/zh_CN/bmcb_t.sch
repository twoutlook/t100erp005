/* 
================================================================================
檔案代號:bmcb_t
檔案名稱:特徵限定用料單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmcb_t
(
bmcbent       number(5)      ,/* 企業編號 */
bmcbsite       varchar2(10)      ,/* 營運據點 */
bmcb001       varchar2(40)      ,/* 主件料號 */
bmcb002       varchar2(30)      ,/* 特性代碼 */
bmcb003       varchar2(40)      ,/* 元件料號 */
bmcb004       varchar2(10)      ,/* 部位編號 */
bmcb005       timestamp(0)      ,/* 生效日期時間 */
bmcb007       varchar2(10)      ,/* 作業編號 */
bmcb008       varchar2(10)      ,/* 製程段號 */
bmcb009       varchar2(30)      ,/* 限定特徵 */
bmcb010       number(10,0)      ,/* 項次 */
bmcb011       varchar2(30)      ,/* 特徵起始值 */
bmcb012       varchar2(30)      ,/* 特徵終止值 */
bmcbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmcbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmcbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmcbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmcbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmcbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmcbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmcbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmcbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmcbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmcbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmcbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmcbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmcbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmcbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmcbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmcbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmcbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmcbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmcbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmcbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmcbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmcbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmcbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmcbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmcbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmcbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmcbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmcbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmcbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmcb_t add constraint bmcb_pk primary key (bmcbent,bmcbsite,bmcb001,bmcb002,bmcb003,bmcb004,bmcb005,bmcb007,bmcb008,bmcb009,bmcb010) enable validate;

create  index bmcb_01 on bmcb_t (bmcb001,bmcb002,bmcb003,bmcb004,bmcb005,bmcb007,bmcb008,bmcb009,bmcb010);
create unique index bmcb_pk on bmcb_t (bmcbent,bmcbsite,bmcb001,bmcb002,bmcb003,bmcb004,bmcb005,bmcb007,bmcb008,bmcb009,bmcb010);

grant select on bmcb_t to tiptop;
grant update on bmcb_t to tiptop;
grant delete on bmcb_t to tiptop;
grant insert on bmcb_t to tiptop;

exit;
