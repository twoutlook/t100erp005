/* 
================================================================================
檔案代號:prbr_t
檔案名稱:門店商品削價單明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prbr_t
(
prbrent       number(5)      ,/* 企業編號 */
prbrunit       varchar2(10)      ,/* 應用組織 */
prbrsite       varchar2(10)      ,/* 營運據點 */
prbrdocno       varchar2(20)      ,/* 單據編號 */
prbrseq       number(10,0)      ,/* 項次 */
prbr001       varchar2(40)      ,/* 商品編號 */
prbr002       varchar2(40)      ,/* 商品條碼 */
prbr003       varchar2(256)      ,/* 商品特征 */
prbr004       varchar2(10)      ,/* 計價單位 */
prbr005       number(20,6)      ,/* 進價 */
prbr006       number(20,6)      ,/* 售價 */
prbr007       number(20,6)      ,/* 原毛利率 */
prbr008       varchar2(40)      ,/* 削價條碼 */
prbr009       varchar2(80)      ,/* 削價說明 */
prbr010       number(20,6)      ,/* 數量 */
prbr011       number(20,6)      ,/* 削價單價 */
prbr012       number(20,6)      ,/* 削價金額 */
prbr013       number(20,6)      ,/* 實際銷售數量 */
prbr014       varchar2(10)      ,/* 削價原因 */
prbr015       number(20,6)      ,/* 新毛利率 */
prbrud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prbrud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prbrud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prbrud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prbrud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prbrud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prbrud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prbrud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prbrud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prbrud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prbrud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prbrud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prbrud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prbrud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prbrud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prbrud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prbrud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prbrud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prbrud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prbrud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prbrud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prbrud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prbrud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prbrud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prbrud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prbrud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prbrud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prbrud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prbrud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prbrud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prbr_t add constraint prbr_pk primary key (prbrent,prbrdocno,prbrseq) enable validate;

create unique index prbr_pk on prbr_t (prbrent,prbrdocno,prbrseq);

grant select on prbr_t to tiptop;
grant update on prbr_t to tiptop;
grant delete on prbr_t to tiptop;
grant insert on prbr_t to tiptop;

exit;
