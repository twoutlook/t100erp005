/* 
================================================================================
檔案代號:dear_t
檔案名稱:門店收銀備用金領用單單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table dear_t
(
dearent       number(5)      ,/* 企業編號 */
dearsite       varchar2(10)      ,/* 營運據點 */
dearunit       varchar2(10)      ,/* 應用組織 */
deardocno       varchar2(20)      ,/* 單據編號 */
dearseq       number(10,0)      ,/* 項次 */
dear000       varchar2(10)      ,/* 專櫃編號 */
dear001       varchar2(10)      ,/* 收銀員編號 */
dear002       varchar2(10)      ,/* 款別分類 */
dear003       varchar2(10)      ,/* 款別編號 */
dear004       varchar2(10)      ,/* 面額編號 */
dear005       number(20,6)      ,/* 單位金額 */
dear006       varchar2(10)      ,/* 幣別 */
dear007       number(20,6)      ,/* 數量 */
dear008       number(20,6)      ,/* 金額 */
dear009       number(20,10)      ,/* 匯率 */
dearud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dearud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dearud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dearud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dearud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dearud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dearud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dearud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dearud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dearud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dearud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dearud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dearud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dearud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dearud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dearud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dearud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dearud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dearud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dearud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dearud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dearud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dearud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dearud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dearud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dearud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dearud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dearud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dearud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dearud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dear_t add constraint dear_pk primary key (dearent,deardocno,dearseq) enable validate;

create unique index dear_pk on dear_t (dearent,deardocno,dearseq);

grant select on dear_t to tiptop;
grant update on dear_t to tiptop;
grant delete on dear_t to tiptop;
grant insert on dear_t to tiptop;

exit;
