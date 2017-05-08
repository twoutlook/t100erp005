/* 
================================================================================
檔案代號:sfdd_t
檔案名稱:發退料明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table sfdd_t
(
sfddent       number(5)      ,/* 企業編號 */
sfddsite       varchar2(10)      ,/* 營運據點 */
sfdddocno       varchar2(20)      ,/* 發退料單號 */
sfddseq       number(10,0)      ,/* 項次 */
sfddseq1       number(10,0)      ,/* 項序 */
sfdd001       varchar2(40)      ,/* 發退料料號 */
sfdd002       number(20,6)      ,/* 替代率 */
sfdd003       varchar2(10)      ,/* 庫位 */
sfdd004       varchar2(10)      ,/* 儲位 */
sfdd005       varchar2(30)      ,/* 批號 */
sfdd006       varchar2(10)      ,/* 單位 */
sfdd007       number(20,6)      ,/* 數量 */
sfdd008       varchar2(10)      ,/* 參考單位 */
sfdd009       number(20,6)      ,/* 參考單位數量 */
sfdd010       varchar2(30)      ,/* 庫存管理特徵 */
sfdd011       varchar2(40)      ,/* 包裝容器 */
sfdd012       number(5,0)      ,/* 正負 */
sfdd013       varchar2(256)      ,/* 產品特徵 */
sfddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfddud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table sfdd_t add constraint sfdd_pk primary key (sfddent,sfdddocno,sfddseq,sfddseq1) enable validate;

create unique index sfdd_pk on sfdd_t (sfddent,sfdddocno,sfddseq,sfddseq1);

grant select on sfdd_t to tiptop;
grant update on sfdd_t to tiptop;
grant delete on sfdd_t to tiptop;
grant insert on sfdd_t to tiptop;

exit;
