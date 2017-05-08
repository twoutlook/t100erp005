/* 
================================================================================
檔案代號:sfce_t
檔案名稱:RunCard拆分記錄單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfce_t
(
sfceent       number(5)      ,/* 企業編號 */
sfcesite       varchar2(10)      ,/* 營運據點 */
sfcedocno       varchar2(20)      ,/* 工單單號 */
sfcedocdt       date      ,/* 拆分日期 */
sfce001       number(10,0)      ,/* 拆分版本 */
sfce002       varchar2(10)      ,/* 作業編號 */
sfce003       varchar2(10)      ,/* 作業序 */
sfce004       number(10,0)      ,/* 原RunCard編號 */
sfce005       number(20,6)      ,/* 拆分轉出數量 */
sfceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfce_t add constraint sfce_pk primary key (sfceent,sfcedocno,sfce001) enable validate;

create unique index sfce_pk on sfce_t (sfceent,sfcedocno,sfce001);

grant select on sfce_t to tiptop;
grant update on sfce_t to tiptop;
grant delete on sfce_t to tiptop;
grant insert on sfce_t to tiptop;

exit;
