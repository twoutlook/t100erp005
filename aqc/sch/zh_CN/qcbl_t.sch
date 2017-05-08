/* 
================================================================================
檔案代號:qcbl_t
檔案名稱:Xbar-R管制資料單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table qcbl_t
(
qcblent       number(5)      ,/* 企業編號 */
qcblsite       varchar2(10)      ,/* 營運據點 */
qcbl001       varchar2(20)      ,/* 檢驗單號 */
qcbl002       number(10,0)      ,/* 檢驗行序 */
qcblseq       number(10,0)      ,/* 組號 */
qcbl003       date      ,/* 日期 */
qcbl004       varchar2(8)      ,/* 時間 */
qcbl005       number(10,0)      ,/* 樣本數 */
qcbl006       number(20,6)      ,/* 合計 */
qcbl007       number(20,6)      ,/* Xbar 值 */
qcbl008       number(20,6)      ,/* R值 */
qcbl009       varchar2(20)      ,/* 檢驗單號 */
qcblud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcblud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcblud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcblud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcblud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcblud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcblud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcblud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcblud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcblud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcblud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcblud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcblud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcblud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcblud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcblud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcblud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcblud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcblud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcblud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcblud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcblud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcblud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcblud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcblud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcblud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcblud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcblud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcblud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcblud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcbl_t add constraint qcbl_pk primary key (qcblent,qcblsite,qcbl001,qcbl002,qcblseq) enable validate;

create unique index qcbl_pk on qcbl_t (qcblent,qcblsite,qcbl001,qcbl002,qcblseq);

grant select on qcbl_t to tiptop;
grant update on qcbl_t to tiptop;
grant delete on qcbl_t to tiptop;
grant insert on qcbl_t to tiptop;

exit;
