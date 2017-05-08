/* 
================================================================================
檔案代號:bmce_t
檔案名稱:元件限定特徵單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmce_t
(
bmceent       number(5)      ,/* 企業編號 */
bmcesite       varchar2(10)      ,/* 營運據點 */
bmce001       varchar2(40)      ,/* 主件料號 */
bmce002       varchar2(30)      ,/* 特性代碼 */
bmce003       varchar2(40)      ,/* 元件料號 */
bmce004       varchar2(10)      ,/* 部位編號 */
bmce005       timestamp(0)      ,/* 生效日期時間 */
bmce007       varchar2(10)      ,/* 作業編號 */
bmce008       varchar2(10)      ,/* 製程段號 */
bmce009       varchar2(30)      ,/* 限定特徵 */
bmce010       varchar2(30)      ,/* 特徵值 */
bmceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmce_t add constraint bmce_pk primary key (bmceent,bmcesite,bmce001,bmce002,bmce003,bmce004,bmce005,bmce007,bmce008,bmce009) enable validate;

create  index bmce_01 on bmce_t (bmce001,bmce002,bmce003,bmce004,bmce005,bmce007,bmce008,bmce009);
create unique index bmce_pk on bmce_t (bmceent,bmcesite,bmce001,bmce002,bmce003,bmce004,bmce005,bmce007,bmce008,bmce009);

grant select on bmce_t to tiptop;
grant update on bmce_t to tiptop;
grant delete on bmce_t to tiptop;
grant insert on bmce_t to tiptop;

exit;
