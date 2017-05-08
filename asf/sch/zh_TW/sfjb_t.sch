/* 
================================================================================
檔案代號:sfjb_t
檔案名稱:工單下階料報廢單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table sfjb_t
(
sfjbent       number(5)      ,/* 企業編號 */
sfjbsite       varchar2(10)      ,/* 營運據點 */
sfjbdocno       varchar2(20)      ,/* 報廢單號 */
sfjbseq       number(10,0)      ,/* 項次 */
sfjb001       varchar2(20)      ,/* 工單單號 */
sfjb002       number(10,0)      ,/* 工單項次 */
sfjb003       varchar2(40)      ,/* 料件編號 */
sfjb004       varchar2(256)      ,/* 產品特徵 */
sfjb005       varchar2(10)      ,/* 單位 */
sfjb006       number(20,6)      ,/* 報廢數量 */
sfjb007       varchar2(10)      ,/* 參考單位 */
sfjb008       number(20,6)      ,/* 參考數量 */
sfjb009       varchar2(10)      ,/* 理由碼 */
sfjb010       varchar2(10)      ,/* 預計處理方式 */
sfjb011       varchar2(10)      ,/* 庫位 */
sfjb012       varchar2(10)      ,/* 儲位 */
sfjb013       varchar2(30)      ,/* 批號 */
sfjb014       varchar2(30)      ,/* 庫存管理特徵 */
sfjb015       number(10,0)      ,/* 工單項序 */
sfjbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
sfjbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
sfjbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
sfjbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
sfjbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
sfjbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
sfjbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
sfjbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
sfjbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
sfjbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
sfjbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
sfjbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
sfjbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
sfjbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
sfjbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
sfjbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
sfjbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
sfjbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
sfjbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
sfjbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
sfjbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
sfjbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
sfjbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
sfjbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
sfjbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
sfjbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
sfjbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
sfjbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
sfjbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
sfjbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
sfjb016       varchar2(40)      ,/* 生產料號 */
sfjb017       varchar2(30)      ,/* BOM特性 */
sfjb018       varchar2(30)      ,/* 產品特徵 */
sfjb019       varchar2(10)      /* 生產計劃 */
);
alter table sfjb_t add constraint sfjb_pk primary key (sfjbent,sfjbdocno,sfjbseq) enable validate;

create unique index sfjb_pk on sfjb_t (sfjbent,sfjbdocno,sfjbseq);

grant select on sfjb_t to tiptop;
grant update on sfjb_t to tiptop;
grant delete on sfjb_t to tiptop;
grant insert on sfjb_t to tiptop;

exit;
