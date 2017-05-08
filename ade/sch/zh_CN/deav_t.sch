/* 
================================================================================
檔案代號:deav_t
檔案名稱:保全對賬差異明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table deav_t
(
deavent       number(5)      ,/* 企業編號 */
deavsite       varchar2(10)      ,/* 營運據點 */
deavunit       varchar2(10)      ,/* 應用組織 */
deavdocno       varchar2(20)      ,/* 單據編號 */
deavdocdt       date      ,/* 營業日期 */
deavseq       number(10,0)      ,/* 項次 */
deav001       varchar2(10)      ,/* 款別分類 */
deav002       varchar2(10)      ,/* 款別編號 */
deav003       varchar2(10)      ,/* 卡券種編號 */
deav004       varchar2(10)      ,/* 券面額編號 */
deav005       varchar2(10)      ,/* 幣別 */
deav006       number(20,6)      ,/* 代收數量 */
deav007       number(20,6)      ,/* 代收金額 */
deav008       varchar2(20)      ,/* 支票號碼 */
deav009       varchar2(80)      ,/* 備註 */
deav010       varchar2(20)      ,/* 存繳單號 */
deav011       number(20,6)      ,/* 存繳數量 */
deav012       number(20,6)      ,/* 存繳金額 */
deav013       number(20,6)      ,/* 差異金額 */
deav014       varchar2(1)      ,/* 是否處理 */
deav015       varchar2(80)      ,/* 處理方式 */
deav016       varchar2(80)      ,/* 處理備註 */
deavud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deavud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deavud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deavud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deavud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deavud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deavud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deavud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deavud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deavud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deavud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deavud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deavud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deavud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deavud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deavud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deavud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deavud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deavud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deavud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deavud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deavud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deavud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deavud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deavud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deavud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deavud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deavud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deavud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deavud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deav_t add constraint deav_pk primary key (deavent,deavdocno,deavseq) enable validate;

create unique index deav_pk on deav_t (deavent,deavdocno,deavseq);

grant select on deav_t to tiptop;
grant update on deav_t to tiptop;
grant delete on deav_t to tiptop;
grant insert on deav_t to tiptop;

exit;
