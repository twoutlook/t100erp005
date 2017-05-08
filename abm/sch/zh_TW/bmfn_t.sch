/* 
================================================================================
檔案代號:bmfn_t
檔案名稱:ECN元件限定庫存特徵單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table bmfn_t
(
bmfnent       number(5)      ,/* 企業編號 */
bmfnsite       varchar2(10)      ,/* 營運據點 */
bmfndocno       varchar2(20)      ,/* ECN單號 */
bmfn002       number(10,0)      ,/* ECN項次 */
bmfn003       varchar2(30)      ,/* 特徵代碼 */
bmfn004       number(10,0)      ,/* 項次 */
bmfn005       varchar2(30)      ,/* 特徴起始值 */
bmfn006       varchar2(30)      ,/* 特徵終止值 */
bmfnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmfnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmfnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmfnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmfnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmfnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmfnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmfnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmfnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmfnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmfnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmfnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmfnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmfnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmfnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmfnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmfnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmfnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmfnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmfnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmfnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmfnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmfnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmfnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmfnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmfnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmfnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmfnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmfnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmfnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmfn_t add constraint bmfn_pk primary key (bmfnent,bmfnsite,bmfndocno,bmfn002,bmfn003,bmfn004,bmfn005) enable validate;

create unique index bmfn_pk on bmfn_t (bmfnent,bmfnsite,bmfndocno,bmfn002,bmfn003,bmfn004,bmfn005);

grant select on bmfn_t to tiptop;
grant update on bmfn_t to tiptop;
grant delete on bmfn_t to tiptop;
grant insert on bmfn_t to tiptop;

exit;
